from django.urls import path

from . import views

urlpatterns = [
    path('', views.get_info, name='texplain-home'),
    #path("home/", views.get_info),
    path("output/", views.output)
]
