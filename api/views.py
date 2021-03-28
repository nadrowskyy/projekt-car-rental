from django.shortcuts import render
from django.http import JsonResponse


def apiOverfiew(request):
    return JsonResponse("API BASE POINT", safe=False)