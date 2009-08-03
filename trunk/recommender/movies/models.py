from django.db import models
from django.contrib.auth.models import User as DjangoUser

MAX_STARS = 5

class Product(models.Model): # a movie
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=256)
    type = models.CharField(max_length=256)

    @classmethod
    def get_by_id(cls, product_id):
        return cls.objects.get(id=product_id)
    
    def get_ratingtotal(self):
        try:
            return self.ratingtotal
        except:
            return RatingTotal.new(product=self)

    def __unicode__(self):
        return u'%s' % self.name

class User(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=256, blank=True)
    django_user = models.ForeignKey(DjangoUser, null=True, blank=True)

    @classmethod
    def new(cls, django_user):
        user = User(name=django_user.username, django_user=django_user)
        user.save()
        return user

    @classmethod
    def get_by_login(cls, user):
        return cls.objects.filter(django_user=user)[0]

    @classmethod
    def get_users_ratings_dict(cls):
        return UsersDictAdaptor(User.objects.all())

    def get_recommendations(self, type='user_similarity', similarity='pearson'):
        from recommendations import getRecommendations, calculateSimilarItems, get_similarity, getRecommendedItems
        users_prefs = User.get_users_ratings_dict()
        if type == 'user_similarity':
            sim = get_similarity(similarity)
            return [
                (star, Product.get_by_id(productid))
                for star, productid in getRecommendations(users_prefs, self.id, similarity=sim)
                ]
        elif type == 'item_similarity':
            # similar_items = calculateSimilarItems(users_prefs)
            similar_items = ItemSimilarity.get_similarity_dict()
            return [
                (star, Product.get_by_id(productid))
                for star, productid in getRecommendedItems(users_prefs, similar_items, self.id)
                ]
        else:
            raise ValueError('Unknown recommendation type %s' % type)

    def get_similar_users(self, n=-1, similarity='pearson'):
        from recommendations import topMatches, get_similarity
        users_prefs = User.get_users_ratings_dict()        
        sim = get_similarity(similarity)
        return [
                (correlation, User.objects.get(id=userid))
                for correlation, userid in topMatches(users_prefs, self.id, n=n, similarity=sim)
                ]

    def rate_product(self, product_id, rating_percent):
        return Rating.update_or_new(Product.get_by_id(product_id), self, rating_percent)

    def __unicode__(self):
        return u'ID: %d, name: %s' % (self.id, self.name)

class Rating(models.Model):
    id = models.AutoField(primary_key=True)
    stars = models.FloatField()
    user = models.ForeignKey(User)
    product = models.ForeignKey(Product)
    timestamp = models.IntegerField()
    max_stars = MAX_STARS

    @classmethod
    def new(cls, product, user, rating_percent):
        r = cls(user=user, product=product)
        r.set_stars_percent(rating_percent)
        r.set_timestamp()
        RatingTotal.add_rating(r)
        r.save()
        return r

    @classmethod
    def update_or_new(cls, product, user, rating_percent):
        # TODO: verificar race conditions
        user_ratings = cls.objects.filter(product=product, user=user)
        ratings_count = user_ratings.count()
        if ratings_count > 0:
            if ratings_count > 1:
                print 'Warning: more than one rating of the same product (%s), user: %s' % (product, user)
            rating_obj = user_ratings[0]
            RatingTotal.del_rating(rating_obj)
            rating_obj.set_stars_percent(rating_percent)
            rating_obj.set_timestamp()
            RatingTotal.add_rating(rating_obj)
            rating_obj.save()
        else:
            rating_obj = cls.new(product, user, rating_percent)
        return rating_obj

    def set_stars_percent(self, rating_percent):
        rating = rating_percent / 100.0 * self.max_stars
        self.stars = rating

    def set_timestamp(self, ts=None):
        if ts is None:
            from time import time
            ts = int(time())
        self.timestamp = ts

    def __unicode__(self):
        return u'Product: %s, User: %s, Stars: %s' % (self.product, self.user, self.stars)

class RatingTotal(models.Model):
    id = models.AutoField(primary_key=True)
    product = models.OneToOneField(Product)
    total_rating = models.IntegerField(default=0)
    total_votes = models.IntegerField(default=0)
    max_stars = MAX_STARS

    @classmethod
    def new(cls, product):
        r = cls(product=product)
        r.save()
        return r

    @classmethod
    def best_rated(cls, n=20, minimum_votes=5):
        rank = [
                (ratingtotal.get_star_rating(), ratingtotal.product)
                for ratingtotal in cls.objects.all() if ratingtotal.total_votes >= minimum_votes
                ]
        rank.sort()
        rank.reverse()
        return rank[:n]

    @classmethod
    def add_rating(cls, rating_obj):
        product = rating_obj.product
        ratingtotal, is_new = cls.objects.get_or_create(product=product)
        ratingtotal.total_rating += rating_obj.stars
        ratingtotal.total_votes += 1
        ratingtotal.save()
        return ratingtotal

    @classmethod
    def del_rating(cls, rating_obj):
        product = rating_obj.product
        ratingtotal = cls.objects.get(product=product)
        ratingtotal.total_rating -= rating_obj.stars
        ratingtotal.total_votes -= 1
        ratingtotal.save()
        return ratingtotal

    def get_star_rating(self):
        star_rating = 0
        if self.total_votes > 0:
            star_rating = float(self.total_rating)/self.total_votes
        return star_rating

    def get_percent(self):
        if self.total_votes > 0:
            return round(float(self.total_rating)/self.total_votes, 0)
        return 0

class ItemSimilarity(models.Model):
    product = models.ForeignKey(Product)
    score = models.FloatField()
    similar_product = models.ForeignKey(Product, related_name='itemsimilarity_similar_set')

    @classmethod
    def get_similarity_dict(cls):
        return ItemSimilarityDictAdaptor(cls.objects.all())


from UserDict import DictMixin

class RatingsDictAdaptor(DictMixin):
    def __init__(self, ratings_dataset):
        self.ratings_dataset = ratings_dataset
        self._keys = None
        self._ratings = {}
    def __getitem__(self, product_id):
        if product_id not in self.keys(): raise KeyError(product_id)
        if product_id not in self._ratings:
            self._ratings[product_id] = self.ratings_dataset.filter(product=product_id)[0].stars
        return self._ratings[product_id]
    def __setitem__(self, key, value):
        raise NotImplementedError
    def __delitem__(self, key):
        raise NotImplementedError    
    def keys(self):
        if not self._keys:
            self._keys = [ rating.product.id for rating in self.ratings_dataset ]
        return self._keys
    def has_key(self, key):
         return key in self.keys()

class UsersDictAdaptor(DictMixin):
    def __init__(self, user_dataset):
        self.user_dataset = user_dataset
        self._ratings = {}
        self._keys = None
    def __getitem__(self, key):
        if key not in self.keys(): raise KeyError(key)
        if key not in self._ratings:
            self._ratings[key] = RatingsDictAdaptor(self.user_dataset.get(id=key).rating_set.all())
        return self._ratings[key]
    def __setitem__(self, key, value):
        raise NotImplementedError
    def __delitem__(self, key):
        raise NotImplementedError    
    def keys(self):
        if not self._keys:
            self._keys = [ user.id for user in self.user_dataset ]
        return self._keys
    def has_key(self, key):
         return key in self.keys()

class ItemSimilarityDictAdaptor(DictMixin):
    def __init__(self, itemsimilarity_dataset):
        self.itemsimilarity_dataset = itemsimilarity_dataset
        self._d = {}
        self._keys = None
    def __getitem__(self, key):
        if key not in self.keys(): raise KeyError(key)        
        if key not in self._d:
            self._d[key] = []
            objs = self.itemsimilarity_dataset.filter(product=key)
            for obj in objs:
                self._d[key].append((float(obj.score), obj.similar_product.id))
        return self._d[key]
    def __setitem__(self, key, value):
        raise NotImplementedError
    def __delitem__(self, key):
        raise NotImplementedError    
    def keys(self):
        if not self._keys:
            self._keys = [ itemsimilarity.product.id for itemsimilarity in self.itemsimilarity_dataset ]
        return self._keys
    def has_key(self, key):
         return key in self.keys()

from django.db import transaction

@transaction.commit_on_success
def reset_ratingtotal():
    RatingTotal.objects.all().delete()
    products_stars = {}
    products_nratings = {}
    for rating in Rating.objects.all():
        products_stars.setdefault(rating.product, 0)
        products_nratings.setdefault(rating.product, 0)
        products_stars[rating.product] += rating.stars
        products_nratings[rating.product] += 1
    for product in products_stars:
        rt = RatingTotal(product=product,
                total_rating=products_stars[product], total_votes=products_nratings[product])
        rt.save()
        del rt

@transaction.commit_on_success
def reset_ratingtotal2():
    RatingTotal.objects.all().delete()
    for rating in Rating.objects.all():
        RatingTotal.add_rating(rating)

@transaction.commit_on_success
def reset_ratingtotal3():
    from django.db import connection
    cursor = connection.cursor()
    RatingTotal.objects.all().delete()
    cursor.execute('select product_id, sum(stars), count(*) from movies_rating group by product_id')
    for product_id, total_rating, total_votes in cursor.fetchall():
        product = Product(id=product_id)
        rt = RatingTotal(product=product, total_rating=total_rating, total_votes=total_votes)
        rt.save()
        del rt, product


@transaction.commit_on_success
def fill_movies(movielens_filename):
    Product.objects.all().delete()
    for line in file(movielens_filename):
        id, name, type = line.split('::')
        product = Product(id=id, name=name, type=type)
        product.save()

@transaction.commit_on_success
def fill_users_ratings(movielens_filename):
    last_user = None
    nratings = 0
    nusers = 0
    Rating.objects.all().delete()
    for line in file(movielens_filename):
        user_id, movie_id, stars, timestamp = line.split('::')
        if not last_user or last_user.id != user_id:
            last_user = User(id=user_id)
            last_user.save()
            nusers += 1
        #movie = Product.objects.only('id').get(id=movie_id)
        movie = Product(id=movie_id) # create a temporary instance
        #FIXME: usar o .new aqui (ou talvez nao, mas nao esquecer de atualizar o RatingTotal)
        rating = Rating(stars=stars, user=last_user, product=movie, timestamp=timestamp)
        rating.save()
        del movie
        del rating
        nratings += 1
        if nratings % 10000 == 0:
            print 'Ratings: %d, Users: %d' % (nratings, nusers)


@transaction.commit_on_success
def calculate_similar_items():
    from recommendations import calculateSimilarItems
    users_prefs = User.get_users_ratings_dict()
    similar_dict = calculateSimilarItems(users_prefs)
    ItemSimilarity.objects.all().delete()
    for item, similar_items in similar_dict.items():
        for score, similar_item in similar_items:
            product = Product(id=item)
            similar_product = Product(id=similar_item)
            itemsimilarity = ItemSimilarity(product=product, similar_product=similar_product, score=score)
            itemsimilarity.save()
            del product, similar_product, itemsimilarity


