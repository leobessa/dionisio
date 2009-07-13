from django.conf.urls.defaults import *

urlpatterns = patterns('',
    (r'^$', 'movies.views.index'),
)
