from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response


@api_view(['GET'])
def api_overview(request):
    api_urls = {
        'Cars List':'/cars-list/',
        'Detail Car':'/cars-detail/<int:pk>/',
    }

    return Response(api_urls)

