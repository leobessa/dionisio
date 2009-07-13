from django.db import models

class Product(models.Model): # a movie
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=256)
    type = models.CharField(max_length=256)

class User(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=256, blank=True)

class Rating(models.Model):
    id = models.AutoField(primary_key=True)
    stars = models.FloatField()
    user = models.ForeignKey(User)
    product = models.ForeignKey(Product)
    timestamp = models.IntegerField()

def fill_movies(movielens_filename):
    for line in file(movielens_filename).readlines():
        id, name, type = line.split('::')
        product = Product(id=id, name=name, type=type)
        product.save()

def fill_users_ratings(movielens_filename):
    last_user= None
    for line in file(movielens_filename).readlines():
        user_id, movie_id, stars, timestamp = line.split('::')
        if not last_user or last_user.id != user_id:
            last_user = User(id=user_id)
            last_user.save()
        rating = Rating(stars=stars, user=last_user.id, product=movie_id, timestamp=timestamp)
        rating.save()

