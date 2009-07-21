from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response
from django.contrib.auth.decorators import login_required
from django.forms import ModelForm
from django.core.urlresolvers import reverse

from movies.models import User, Rating, Product, RatingTotal


@login_required
def index(request):
    #user = User.get_by_login(request.user)
    #recommendations = user.get_recommendations()
    #bestrated = RatingTotal.best_rated(100)
    return render_to_response('index.html', locals())

def create_login(request):
    from django.contrib.auth.forms import UserCreationForm
    params = request.GET or request.POST
    next = params.get('next', '').strip() or reverse(index)
    if request.method == 'GET':
        form = UserCreationForm()
    else:
        form = UserCreationForm(request.POST)
        if form.is_valid():
            djangouser = form.save()
            User.new(djangouser)
            from django.contrib.auth import authenticate, login
            username = djangouser.username
            password = form.cleaned_data['password1']
            user = authenticate(username=username, password=password)
            assert user and user.is_active
            login(request, user)
            return HttpResponseRedirect(next)
    return render_to_response('create_login.html', locals())

@login_required
def rate_product(request, product_id, rating_percent):
    product_id = int(product_id)
    rating_percent = float(rating_percent)
    user = User.get_by_login(request.user)
    user.rate_product(product_id, rating_percent)
    return HttpResponseRedirect(reverse(index))

def ajax_rate_product(request):
    from django.template import Context
    from django.template.loader import render_to_string
    from movies.templatetags.rabidratings_extras import show_rating
    params = request.POST or request.GET
    product_id = int(params['id'])
    product = Product.get_by_id(product_id)
    rating_percent = float(params['vote'])
    user = User.get_by_login(request.user)
    user.rate_product(product_id, rating_percent)
    rating_context = show_rating(Context(), product.ratingtotal)
    return render_to_response('rabidratings/rating_info.html', rating_context)

def ajax_recommendation_list(request):
    if not request.user.is_authenticated():
        return HttpResponse('This operation needs authentication')
    user = User.get_by_login(request.user)
    recommendations = user.get_recommendations()
    return render_to_response('recommendation_list.html', locals())

def ajax_best_rated_list(request):
    bestrated = RatingTotal.best_rated(1000)
    return render_to_response('best_rated_list.html', locals())

def ajax_similar_users_list(request):
    if not request.user.is_authenticated():
        return HttpResponse('This operation needs authentication')
    user = User.get_by_login(request.user)
    similar_users = user.get_similar_users(n=100)
    return render_to_response('similar_users_list.html', locals())

