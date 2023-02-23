from django.urls import path, include
from rest_framework import routers

from . import views
from django.conf.urls.static import static
from django.conf import settings

router1 = routers.DefaultRouter(trailing_slash = False)
router1.register('data',views.DataView)
router1.register('xai',views.XaiView)

urlpatterns = [
    path('', include(router1.urls))
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
