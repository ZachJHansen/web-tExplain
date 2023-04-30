from django.urls import path

from . import views

urlpatterns = [
    # path('', views.home, name='editor-home'),
    path("home/", views.get_info),
    path("output/", views.output)
]
