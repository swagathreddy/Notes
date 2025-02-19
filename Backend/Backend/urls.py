from django.contrib import admin
from django.urls import path, include, re_path
from django.views.generic import TemplateView
from core.views import CreateUserView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('admin/', admin.site.urls),
    path("core/user/register/", CreateUserView.as_view(), name='register'),
    path("core/token/", TokenObtainPairView.as_view(), name='get_token'),
    path("core/token/refresh/", TokenRefreshView.as_view(), name='refresh'),
    path("core-auth", include("rest_framework.urls")),
    path("core/", include("core.urls")),
    
    # Serve frontend
    path('', TemplateView.as_view(template_name='index.html')),
    # Handle client-side routing
    re_path(r'^.*$', TemplateView.as_view(template_name='index.html')),
]