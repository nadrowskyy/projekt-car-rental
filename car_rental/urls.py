"""car_rental URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from blog.views import main, cars, faq, rent, contact, cars_detail, insurance, order, order_finish, flota, \
admin, admin_additional, admin_cars, admin_insurance, admin_orders, admin_users, cars_edit, users_edit, user_detail, \
orders_edit, admin_prices, prices_edit, insurance_edit, admin_dtd, dtd_edit, flota_detail, accident
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    #path('admin/', admin.site.urls),
    path('', main, name='main'),
    path('cars/', cars, name='cars'),
    path('cars/<int:link>/', cars_detail, name='cars_detail'),
    path('faq/', faq, name='faq'),
    path('rent/', rent, name='rent'),
    path('rent/insurance<int:link>/', insurance, name='insurance'),
    path('rent/order<int:link>/', order, name='order'),
    # path('rent/order/print', render_pdf_view, name='render_pdf'),
    # path('email/', email, name='email'),
    path('contact/', contact, name='contact'),
    path('rent/finish/', order_finish, name='finish'),
    path('accident/', accident, name='accident'),
    path('flota/', flota, name='flota'),
    path('flota/detail/<int:link>/', flota_detail, name='flota_detail'),
    path('admin/', admin, name='admin'),
    path('admin/additional/', admin_additional, name='admin_additional'),
    path('admin/additional/<int:link>/', cars_edit, name='cars_edit'),
    path('admin/cars/', admin_cars, name='admin_cars'),
    path('admin/cars/<int:link>/', cars_edit, name='cars_edit'),
    path('admin/insurance/', admin_insurance, name='admin_insurance'),
    path('admin/insurance/<int:link>/', insurance_edit, name='insurance_edit'),
    path('admin/prices/', admin_prices, name='admin_prices'),
    path('admin/prices/<int:link>/', prices_edit, name='prices_edit'),
    path('admin/orders/', admin_orders, name='admin_orders'),
    path('admin/orders/<int:link>/', orders_edit, name='orders_edit'),
    path('admin/users/', admin_users, name='admin_users'),
    path('admin/users/<int:link>/', users_edit, name='users_edit'),
    path('admin/dtd/', admin_dtd, name='admin_dtd'),
    path('admin/dtd/<int:link>/', dtd_edit, name='dtd_edit'),
    path('user/<int:link>/', user_detail, name='user_detail'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
