from django.conf.urls.defaults import *
from django.contrib.auth.views import logout_then_login
urlpatterns = patterns('movies.views',
    (r'^$', 'index'),
    #(r'^register_user/$', 'register_user'),
    url(r'^logout/$', logout_then_login, name='logout'),
    url(r'^create_login/$', 'create_login', name='create_login'),
    (r'^product/(\d+)/rate/([0-9.]+)/$', 'rate_product'),
    url(r'^ajax_rate_product/$', 'ajax_rate_product', name='ajax_rate_product'),
    url(r'^ajax_recommendation_list/(?P<type>[a-zA-Z_]+)/$', 'ajax_recommendation_list', name='ajax_recommendation_list'),    
    url(r'^ajax_recommendation_list/$', 'ajax_recommendation_list', name='ajax_recommendation_list'),
    url(r'^ajax_best_rated_list/(?P<n>[0-9]+)/$', 'ajax_best_rated_list', name='ajax_best_rated_list'),    
    url(r'^ajax_best_rated_list/$', 'ajax_best_rated_list', name='ajax_best_rated_list'),
    url(r'^ajax_similar_users_list/(?P<n>[0-9]+)/$$', 'ajax_similar_users_list', name='ajax_similar_users_list'),
    url(r'^ajax_similar_users_list/$', 'ajax_similar_users_list', name='ajax_similar_users_list'),
    url(r'^ajax_socialsite_auth/$', 'ajax_socialsite_auth', name='ajax_socialsite_auth'),
)
