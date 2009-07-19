from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()
import settings

urlpatterns = patterns('',
    # Example:
    # (r'^recommender/', include('recommender.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
     (r'^admin/', include(admin.site.urls)),

    (r'^accounts/login/$', 'django.contrib.auth.views.login'),
    (r'^recommender/movies/', include('recommender.movies.urls')),
    url(r'^static/(.*)$', 'django.views.static.serve',
     {'document_root': settings.MEDIA_ROOT}, name='static'),

)
