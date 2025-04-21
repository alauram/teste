from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import PecaViewSet

router = DefaultRouter()
router.register(r'pecas', PecaViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
