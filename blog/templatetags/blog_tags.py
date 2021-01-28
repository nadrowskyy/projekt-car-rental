from django import template
import datetime


register = template.Library()

@register.simple_tag
def add_day():
    now = datetime.datetime.now()
    plus_day = datetime.timedelta(days=1)
    now = now + plus_day
    now = now.strftime("%Y-%m-%d")

    return now