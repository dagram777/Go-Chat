from django.urls import path
from .views import *
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
# from rest_framework_simplejwt import views as jwt_views
# from django.contrib.staticfiles import staticfiles_urlpatterns
urlpatterns = [
    path('posts' , PostViewCreate.as_view(), name='posts'),
    path('posts/<str:pk>' , DetailPost.as_view(), name='posts-detail'),
    path('users' , ViewUser.as_view() , name = 'users'),
    path('usersDetail/<str:pk>' , MemberDetail.as_view() , name = 'getUser'),
    # path('single-user/<str:pk>' , DeleteOrViewUser.as_view() , name='single-user'),
    path('donations' , DonationCreate.as_view() , name = 'donations'),
    path('donations/<str:pk>' , DonationDetail.as_view() , name = 'donation-detail'),
    path('email-password' , Verify.as_view() , name ="verify"),
    path('donationDetail/<str:pk>' , DonationSingle.as_view() , name = "donationDetail")
    # path('api/token/', jwt_views.TokenObtainPairView.as_view(), name='token_obtain_pair'),
    # path('api/token/refresh/', jwt_views.TokenRefreshView.as_view(), name='token_refresh'),

 
] + static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)

# urlpatterns += staticfiles_urlpatterns()
