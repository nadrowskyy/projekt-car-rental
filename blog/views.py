from django.shortcuts import render, redirect
import mysql.connector
from .forms import UserDataForm
from django.contrib import messages
import random
import datetime
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.template.loader import get_template
from xhtml2pdf import pisa
from django.core.mail import send_mail, EmailMessage
from io import StringIO, BytesIO

cnx = mysql.connector.connect(
    host='localhost',
    user='root',
    database='car_rental',
)
cursor = cnx.cursor()




def cars_detail(request, link):
    cursor.execute('SELECT * FROM cars')
    cars_fetch = cursor.fetchall()
    cursor.execute('SELECT * FROM cars_detail')
    cars_detail_fetch = cursor.fetchall()
    cursor.execute('''SELECT segment_price.SegmentID, segment_price.Segment, segment_price.DepositPrice, 
                      segment_price.BasicPrice FROM segment_price, cars WHERE cars.CarID = {}
                      AND cars.SegmentID = segment_price.SegmentID'''.format(link))
    segment_fetch = cursor.fetchall()
    context = ''
    for c in cars_fetch:
        if c[0] == link:
            context = {'car': c}
            break
    for c in cars_detail_fetch:
        if c[0] == link:
            context['car_detail'] = c
            break
    context['segment'] = segment_fetch
    return render(request, 'blog/cars_detail.html', context=context)


def cars_filter (segment, body_type, transmission, fuel, seats, pick_session, return_session):
    filtered = []
    if segment != 'ALL' and body_type == 'ALL' and transmission == 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = {segment}
            AND cars_detail.CarID = cars.CarID
            AND segment_price.SegmentID = {segment}
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment,
                                                                                                 pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type != 'ALL' and transmission == 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.BodyType = "{body_type}" 
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(body_type=body_type, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type == 'ALL' and transmission != 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.TransmissionType = "{transmission}" 
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(transmission=transmission, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type == 'ALL' and transmission == 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.FuelType = "{fuel}" 
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(fuel=fuel, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment != 'ALL' and body_type != 'ALL' and transmission == 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.SegmentID = {segment}
            AND cars.BodyType = '{body_type}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, body_type=body_type, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment != 'ALL' and body_type == 'ALL' and transmission != 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.SegmentID = {segment}
            AND cars.TransmissionType = '{transmission}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, transmission=transmission, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment != 'ALL' and body_type == 'ALL' and transmission == 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.SegmentID = {segment}
            AND cars.FuelType = '{fuel}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, fuel=fuel, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type != 'ALL' and transmission != 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.BodyType = '{body_type}'
            AND cars.TransmissionType = '{transmission}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(body_type=body_type, transmission=transmission, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type != 'ALL' and transmission == 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.BodyType = '{body_type}'
            AND cars.FuelType = '{fuel}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(body_type=body_type, fuel=fuel, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type == 'ALL' and transmission != 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.TransmissionType = '{transmission}'
            AND cars.FuelType = '{fuel}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(fuel=fuel, transmission=transmission, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment != 'ALL' and body_type != 'ALL' and transmission != 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.SegmentID = {segment}
            AND cars.BodyType = '{body_type}'
            AND cars.TransmissionType = '{transmission}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, body_type=body_type,
                                                         transmission=transmission, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment != 'ALL' and body_type != 'ALL' and transmission == 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.SegmentID = {segment}
            AND cars.BodyType = '{body_type}'
            AND cars.FuelType = '{fuel}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, body_type=body_type, fuel=fuel, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type != 'ALL' and transmission != 'ALL' and fuel != 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE cars.SegmentID = segment_price.SegmentID 
            AND cars.BodyType = '{body_type}'
            AND cars.TransmissionType = '{transmission}'
            AND cars.FuelType = '{fuel}'
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(transmission=transmission, body_type=body_type, fuel=fuel, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == 'ALL' and body_type == 'ALL' and transmission == 'ALL' and fuel == 'ALL':
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE segment_price.SegmentID = cars.segmentID
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, body_type=body_type, transmission=transmission, fuel=fuel, seats=seats, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    elif segment == None and body_type == None and transmission ==  None and fuel == None:
        try:
            cursor.execute('''SELECT *
            FROM segment_price, cars, cars_detail
            WHERE segment_price.SegmentID = cars.segmentID
            AND cars_detail.CarID = cars.CarID
            and cars.CarID not in (select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and orders.RentalStart BETWEEN "{pick_session}" and "{return_session}"
            UNION
            select cars.CarID from cars, cars_detail, orders 
            where cars.CarID = cars_detail.CarID 
            and orders.CarID = cars.CarID
            and ("{pick_session}" BETWEEN orders.RentalStart and orders.RentalEnd
            or "{return_session}" BETWEEN orders.RentalStart and orders.RentalEnd))'''.format(segment=segment, body_type=body_type, transmission=transmission, fuel=fuel, seats=seats, pick_session=pick_session,
                                                                                                 return_session=return_session))
            filtered = cursor.fetchall()
        except mysql.connector.Error:
            pass
    return filtered


def cars(request):
    pick_date = 0
    return_date = 0
    pick_session = 0
    return_session = 0
    if request.method == 'POST':
        pick_date = request.POST.get('pick')
        return_date = request.POST.get('return')
        print(pick_date)
        print(return_date)
        request.session['pick'] = pick_date
        request.session['return'] = return_date
        pick_session = request.session.get('pick')
        return_session = request.session.get('return')

    if request.method == "GET":
        pick_session = request.session.get('pick')
        return_session = request.session.get('return')
    segment = request.GET.get('segment')
    body_type = request.GET.get('body_type')
    transmission = request.GET.get('transmission')
    fuel = request.GET.get('fuel')
    seats = request.GET.get('seats')
    car = cars_filter(segment, body_type, transmission, fuel, seats, pick_session, return_session)
    if car:
        context = {'car': car}
        site = 'blog/cars_filtered.html/'
    else:
        messages.error(request, 'Nie znaleziono aut według podanych kryteriów')
        cursor.execute('SELECT * FROM cars')
        car = cursor.fetchall()

        cursor.execute('SELECT * FROM cars_detail')
        cars_detail = cursor.fetchall()

        cursor.execute('''SELECT segment_price.BasicPrice, segment_price.DepositPrice 
        FROM cars, segment_price
        WHERE cars.SegmentID = segment_price.SegmentID''')
        segment_price = cursor.fetchall()
        for x in range(len(car)):
            car[x] = car[x] + cars_detail[x] + segment_price[x]
        context = {'car': car}
        site = 'blog/cars.html/'
    return render(request, template_name=site, context=context)


def main(request):
    return render(request, 'blog/carrent_szablon.html/')


def contact(request):
    return render(request, 'blog/contact.html')


def faq(request):
    return render(request, 'blog/faq.html')


def rent(request):
    if request.method == 'POST':
        form = UserDataForm(request.POST)
        if form.is_valid():
            name = form.cleaned_data['name']
            surname = form.cleaned_data['surname']
            age = int(form.cleaned_data['age'])
            body = form.cleaned_data['body']


            cursor.execute("INSERT INTO blog_users VALUES (NULL, '{name}', '{surname}', '{age}', '{body}')".format(
                name=name, surname=surname, age=age, body=body))
            cnx.commit()

    form = UserDataForm()
    context = {'form': form}
    return render(request, 'blog/rent.html', context=context)


def search_by_date(request):
    pass


def order(request, link):
    context = {}
    ins = ''
    extra_seat = ''
    if_abroad = ''
    if_more_users = ''
    if request.method == 'POST':
        name = request.POST.get('name')
        surname = request.POST.get('surname')
        email = request.POST.get('email')
        phone = request.POST.get('phone')
        age = request.POST.get('age')
        sex = request.POST.get('sex')
        licence = request.POST.get('licence')
        licence_date = request.POST.get('licence-date')
        street = request.POST.get('street')
        house_number = request.POST.get('house-number')
        flat_number = request.POST.get('flat-number')
        postcode = request.POST.get('postcode')
        city = request.POST.get('city')




        cursor.execute('''INSERT INTO users VALUES (NULL    , "{name}", "{surname}", "{email}",
        "{phone}", {age}, "{sex}", "{licence}", {licence_date})'''.format(name=name, surname=surname, email=email,
                                                                phone=phone, age=age, sex=sex, licence=licence,
                                                                             licence_date=licence_date))
        cnx.commit()

        cursor.execute('''SELECT userID FROM users''')
        # dla ostatniego utworzonego [-1] użytkownika będziemy robić zamówienie
        request.session['user_id'] = cursor.fetchall()[-1][0]
        user_id = request.session.get('user_id')
        request.session['car_id'] = link
        car_id = request.session.get('car_id')
        order_number = random.randint(100000, 999999)
        tmp = datetime.datetime.now()
        when_ordered = tmp.strftime('%Y-%m-%d %H:%M:%S')
        rental_start = request.session.get('pick')
        rental_end = request.session.get('return')
        rental_days = datetime.datetime.strptime(rental_end, '%Y-%m-%d') - \
                      datetime.datetime.strptime(rental_start, '%Y-%m-%d')
        rental_days = rental_days.days
        if_abroad = request.session.get('if_abroad_price')
        if if_abroad != 0:
            if_abroad = 1
        elif if_abroad == 0:
            if_abroad = 0
        if_paid = 1
        rental_price = int(rental_days) * int(request.session.get('basic_price')) + \
                       int(request.session.get('packet-price')) + int(request.session.get('deposit_price')) + \
                       int(request.session.get('extra_seat_price')) + int(request.session.get('if_abroad_price')) + \
                       int(request.session.get('if_more_users_price'))

        cursor.execute('''INSERT INTO orders VALUES (NULL, {user_id}, {car_id}, {order_number},
        "{when_ordered}", {rental_days}, "{rental_start}", "{rental_end}", {if_abroad},
        {if_paid}, {rental_price})'''.format(user_id=user_id, car_id=car_id, order_number=order_number,
                                             when_ordered=when_ordered, rental_days=rental_days,
                                             rental_start=rental_start, rental_end=rental_end,
                                             if_abroad=if_abroad, if_paid=if_paid, rental_price=rental_price))
        cnx.commit()

        cursor.execute(f'UPDATE cars SET IfRented = 1 WHERE cars.CarID = {car_id}')
        cnx.commit()

        cursor.execute('''SELECT orderID FROM orders''')
        order_id = cursor.fetchall()[-1][0]
        request.session['order_id'] = order_id
        cursor.execute('''INSERT INTO door_to_door VALUES ({order_id}, "{street}", "{house_number}",
        "{flat_number}", "{postcode}", "{city}")'''.format(order_id=order_id, street=street,
                                                            house_number=house_number,
                                                            flat_number=flat_number, postcode=postcode,
                                                            city=city))

        cnx.commit()

        if if_abroad != 0:
            if_abroad = 1
        elif if_abroad == 0:
            if_abroad = 0

        if_child_seat = request.session.get('extra_seat_price')
        if if_child_seat != 0:
            if_child_seat = 1
        elif if_child_seat == 0:
            if_child_seat = 0
        if_more_users = request.session.get('if_more_users_price')
        if if_more_users != 0:
            if_more_users = 1
        elif if_more_users == 0:
            if_more_users = 0
        insurance_id = request.session.get('packet-id')
        cursor.execute('''INSERT INTO additional_services VALUES (
                {orderid}, {ifabroad}, {ifchildseat}, {ifmoreusers}, {insuranceid})'''.format
                       (orderid=order_id, ifabroad=if_abroad,
                        ifchildseat=if_child_seat,
                        ifmoreusers=if_more_users,
                        insuranceid=insurance_id))

        cnx.commit()

        cursor.execute('''INSERT INTO prices_for_additional_services VALUES (
        {order_id}, {using_abroad}, {child_seat}, {more_users})'''.format(order_id=order_id, using_abroad=request.session.get('if_abroad_price'),
                                                                          child_seat=request.session.get('extra_seat_price'),
                                                                          more_users=request.session.get('if_more_users_price')))

        cnx.commit()

        response = redirect('finish')

        return response

    if request.method == 'GET':
        ins_id = request.GET.get('packet-ch')
        cursor.execute('''SELECT * FROM insurance_packet WHERE InsuranceID = {ins_id}'''.format(
            ins_id=ins_id
        ))
        ins = cursor.fetchall()
        request.session['packet-id'] = ins[0][0]
        request.session['packet-name'] = ins[0][1]
        request.session['packet-price'] = ins[0][3]
        extra_seat = request.GET.get('extra_seat', 0)
        request.session['extra_seat_price'] = int(extra_seat)
        if_abroad = request.GET.get('if_abroad', 0)
        request.session['if_abroad_price'] = int(if_abroad)
        if_more_users = request.GET.get('if_more_users', 0)
        request.session['if_more_users_price'] = int(if_more_users)

    cursor.execute(f'SELECT * FROM cars WHERE CarID = {link};')
    car_fetch = cursor.fetchall()
    cursor.execute(f'SELECT image FROM cars_detail WHERE CarID = {link}')
    cars_detail_fetch = cursor.fetchall()
    cursor.execute('SELECT * FROM insurance_packet')
    insurance_fetch = cursor.fetchall()
    cursor.execute('''SELECT segment_price.Segment,  segment_price.DepositPrice, segment_price.BasicPrice 
                              FROM cars, segment_price WHERE cars.CarID = {}
                              AND cars.SegmentID = segment_price.SegmentID'''.format(link))
    segment_fetch = cursor.fetchall()
    insurance_fetch_list = [list(x) for x in insurance_fetch]
    info = []

    rental_start = request.session.get('pick')
    rental_end = request.session.get('return')
    rental_days = datetime.datetime.strptime(rental_end, '%Y-%m-%d') - \
                  datetime.datetime.strptime(rental_start, '%Y-%m-%d')
    rental_days = rental_days.days
    rental_price = int(rental_days) * int(request.session.get('basic_price')) + \
                   + int(request.session.get('packet-price')) + int(request.session.get('deposit_price')) + \
                   int(request.session.get('extra_seat_price')) + int(request.session.get('if_abroad_price')) + \
                   int(request.session.get('if_more_users_price'))

    order_details = [rental_days, request.session.get('basic_price'), request.session.get('deposit_price'),
                     request.session.get('packet-price'), request.session.get('packet-name'),
                     request.session.get('extra_seat_price'),
                     request.session.get('if_abroad_price'), request.session.get('if_more_users_price'),
                     rental_price]
    for packet in insurance_fetch_list:
        info_tmp = packet[2].split(".")
        info.append(info_tmp[0:-1])
    for i in range(len(insurance_fetch_list)):
        insurance_fetch_list[i][2] = info[i]

    context = {'car': car_fetch, 'car_detail': cars_detail_fetch, 'insurance_1': insurance_fetch_list[0],
                   'insurance_2': insurance_fetch_list[1],
                   'insurance_3': insurance_fetch_list[2], 'segment': segment_fetch,
               'details': order_details}

    return render(request, 'blog/order.html', context=context)


def order_finish(request):


    # EMAIL SENDING

    template_path = 'blog/order_print.html'

    user_id = request.session.get('user_id')
    cursor.execute('''SELECT orders.OrderNumber, users.Name, users.Surname, users.Email, door_to_door.Street, 
        door_to_door.PostCode, door_to_door.City, orders.WhenOrdered, orders.RentalStart, orders.RentalEnd,
        cars.Mark, cars.Model, segment_price.BasicPrice, segment_price.DepositPrice, orders.RentalDays,
        insurance_packet.InsuranceName, insurance_packet.InsurancePrice, 
        prices_for_additional_services.ChildSeat, prices_for_additional_services.UsingAbroad,
        prices_for_additional_services.UsedByMoreUsers, orders.RentalPrice
        FROM orders, users, door_to_door, cars, segment_price, insurance_packet, prices_for_additional_services,
        additional_services
        WHERE orders.UserID = users.UserID
        AND orders.OrderID = door_to_door.OrderID
        AND orders.CarID = cars.CarID
        AND segment_price.SegmentID = cars.SegmentID
        AND orders.OrderID = additional_services.OrderID
        AND additional_services.InsuranceID = insurance_packet.InsuranceID
        AND orders.OrderID = prices_for_additional_services.OrderID
        AND users.UserID = {user_id}'''.format(user_id=user_id))

    order_fetch = cursor.fetchall()

    context = {'order': order_fetch}
    # Create a Django response object, and specify content_type as pdf
    response = HttpResponse(content_type='application/pdf')
    # if download
    # response['Content-Disposition'] = 'attachment; filename="order.pdf"'
    # if display
    response['Content-Disposition'] = 'filename="order.pdf"'
    # find the template and render it.
    template = get_template(template_path)
    html = template.render(context)
    result = BytesIO()

    pdf = pisa.pisaDocument(BytesIO(html.encode("UTF-8")), result)

    # create a pdf
    pisa_status = pisa.CreatePDF(
        html, dest=response)

    user_id = request.session.get('user_id')

    cursor.execute('''SELECT users.Email
    FROM users
    WHERE users.UserID = {}'''.format(user_id))

    e_mail = cursor.fetchall()[0][0]
    
    
    # Enter email credentials in settings.py to send emails and uncomment code below
    #m = EmailMessage(
    #    subject='Carnet Order',
    #    body='Szczegóły zamówienia w załączniku',
    #    from_email='carnetdjango@gmail.com',
    #    to=[e_mail],
    #)
    #m.attach('zamowienie', result.getvalue(), 'application/pdf')
    #.send()

    # EMAIL SENDING

    order_id = request.session.get('order_id')

    cursor.execute('''SELECT cars.Model, cars.Mark, users.Name, users.Surname, cars_detail.image
        FROM cars, cars_detail, orders, users
        WHERE cars.CarID = orders.CarID
        AND cars.CarID = cars_detail.CarID
        AND orders.OrderID = {order_id}
        AND orders.UserID = users.UserID'''.format(order_id=order_id))

    details = cursor.fetchall()
    context = {'details': details}

    return render(request, 'blog/order_finish.html', context=context)


def insurance(request, link):

    # Zapisz do sesji cenę podstawową za auto
    cursor.execute('''SELECT segment_price.basicPrice, segment_price.depositPrice
    FROM segment_price, cars
    WHERE cars.CarId = {link}
    AND cars.segmentID = segment_price.segmentID'''.format(link=link))
    request.session['basic_price'] = int(cursor.fetchall()[0][0])
    # Zapisz do sesji cenę depozytu
    cursor.execute('''SELECT segment_price.basicPrice, segment_price.depositPrice
        FROM segment_price, cars
        WHERE cars.CarId = {link}
        AND cars.segmentID = segment_price.segmentID'''.format(link=link))
    request.session['deposit_price'] = int(cursor.fetchall()[0][1])
    cursor.execute(f'SELECT * FROM cars WHERE CarID = {link};')
    car_fetch = cursor.fetchall()
    cursor.execute(f'SELECT image FROM cars_detail WHERE CarID = {link}')
    cars_detail_fetch = cursor.fetchall()
    cursor.execute('SELECT * FROM insurance_packet')
    insurance_fetch = cursor.fetchall()
    cursor.execute('''SELECT segment_price.Segment,  segment_price.DepositPrice, segment_price.BasicPrice 
                      FROM cars, segment_price WHERE cars.CarID = {}
                      AND cars.SegmentID = segment_price.SegmentID'''.format(link))
    segment_fetch = cursor.fetchall()
    insurance_fetch_list = [list(x) for x in insurance_fetch]
    info = []
    for packet in insurance_fetch_list:
        info_tmp = packet[2].split(".")
        info.append(info_tmp[0:-1])
    for i in range(len(insurance_fetch_list)):
        insurance_fetch_list[i][2] = info[i]

    context = {'car': car_fetch, 'car_detail': cars_detail_fetch, 'insurance_1': insurance_fetch_list[0],
               'insurance_2': insurance_fetch_list[1],
               'insurance_3': insurance_fetch_list[2], 'segment': segment_fetch}
    return render(request, 'blog/insurance.html', context=context)


def flota(request):
    cursor.execute('SELECT * FROM cars')
    car = cursor.fetchall()

    cursor.execute('SELECT * FROM cars_detail')
    cars_detail = cursor.fetchall()
    for x in range(len(car)):
        car[x] = car[x] + cars_detail[x]
    context = {'car': car}

    return render(request, 'blog/flota.html', context=context)


def flota_detail(request, link):
    cursor.execute('SELECT * FROM cars')
    cars_fetch = cursor.fetchall()
    cursor.execute('SELECT * FROM cars_detail')
    cars_detail_fetch = cursor.fetchall()
    cursor.execute('''SELECT segment_price.SegmentID, segment_price.Segment, segment_price.DepositPrice, 
                      segment_price.BasicPrice FROM segment_price, cars WHERE cars.CarID = {}
                      AND cars.SegmentID = segment_price.SegmentID'''.format(link))
    segment_fetch = cursor.fetchall()
    context = ''
    for c in cars_fetch:
        if c[0] == link:
            context = {'car': c}
            break
    for c in cars_detail_fetch:
        if c[0] == link:
            context['car_detail'] = c
            break
    context['segment'] = segment_fetch
    return render(request, 'blog/flota_detail.html', context=context)


def accident(request):
    site = 'blog/accident.html'
    context = {}
    user_id = 0
    if request.method == 'GET':
        number = request.GET.get('order-number', 0)
        if number == 0 or number == '':
            pass
        else:
            number = int(number)
        cursor.execute(f'SELECT OrderNumber FROM Orders')
        order_numbers = cursor.fetchall()
        for n in order_numbers:
            if number == n[0]:
                cursor.execute('''SELECT cars.Mark, cars.Model, cars_detail.image, users.Name, users.Surname,
                                users.UserID
                                FROM orders, cars, cars_detail, users
                                WHERE cars.CarID = cars_detail.CarID
                                AND orders.UserID = users.UserID
                                AND orders.CarID = cars.CarID
                                AND orders.OrderNumber = {}'''.format(number))
                context = {'order': cursor.fetchall()}
                user_id = context['order'][0][5]
                request.session['user_id'] = user_id
                site = 'blog/accident_post.html'
    if request.method == 'POST':
        accident_date = request.POST.get('date')
        description = request.POST.get('description')
        reported = datetime.datetime.now().date()
        up_file = request.FILES['img1']
        user_id = request.session.get('user_id')
        fs = FileSystemStorage(location=f'C:/Users/Ja/car_rental/media/accidents/user_id/{user_id}/')
        fs.save(up_file.name, up_file)
        try:
            cursor.execute('''INSERT INTO accidents VALUES ({user_id}, "{date}",
            "{description}", "{reported}")'''.format(user_id=user_id, date=accident_date, description=description,
                                                 reported=reported))
            cnx.commit()
        except mysql.connector.Error:
            pass
    return render(request, site, context=context)


"""def render_pdf_view():
    template_path = 'blog/order_print.html'


    cursor.execute('''SELECT orders.OrderNumber, users.Name, users.Surname, users.Email, door_to_door.Street, 
    door_to_door.PostCode, door_to_door.City, orders.WhenOrdered, orders.RentalStart, orders.RentalEnd,
    cars.Mark, cars.Model, segment_price.BasicPrice, segment_price.DepositPrice, orders.RentalDays,
    insurance_packet.InsuranceName, insurance_packet.InsurancePrice, 
    prices_for_additional_services.ChildSeat, prices_for_additional_services.UsingAbroad,
    prices_for_additional_services.UsedByMoreUsers, orders.RentalPrice
    FROM orders, users, door_to_door, cars, segment_price, insurance_packet, prices_for_additional_services,
    additional_services
    WHERE orders.UserID = users.UserID
    AND orders.OrderID = door_to_door.OrderID
    AND orders.CarID = cars.CarID
    AND segment_price.SegmentID = cars.SegmentID
    AND orders.OrderID = additional_services.OrderID
    AND additional_services.InsuranceID = insurance_packet.InsuranceID
    AND orders.OrderID = prices_for_additional_services.OrderID
    AND users.UserID = {user_id}'''.format(user_id=user_id))

    order_fetch = cursor.fetchall()


    context = {'order': order_fetch}
    # Create a Django response object, and specify content_type as pdf
    response = HttpResponse(content_type='application/pdf')
    # if download
    # response['Content-Disposition'] = 'attachment; filename="order.pdf"'
    # if display
    response['Content-Disposition'] = 'filename="order.pdf"'
    # find the template and render it.
    template = get_template(template_path)
    html = template.render(context)
    result = BytesIO()

    pdf = pisa.pisaDocument(BytesIO(html.encode("UTF-8")), result)

    # create a pdf
    pisa_status = pisa.CreatePDF(
       html, dest=response)
    print(type(result.getvalue()))
    return result.getvalue()
    # if error then show some funy view
    # if pisa_status.err:
    #    return HttpResponse('We had some errors <pre>' + html + '</pre>')
    # return response
"""

"""def email(request):
    # send_mail('CARNET Order', 'SDSD', 'carnet_django@gmail.com', ['dajid56474@vss6.com'],
    #           fail_silently=False)
    m = EmailMessage(
        subject='Carnet2 Order',
        body='Body',
        from_email='carnetdjango@gmail.com',
        to=['votidij807@yutongdt.com'],
    )
    m.attach('zamowienie', render_pdf_view(), 'application/pdf')
    m.send()
    return HttpResponse('sent!')
"""
# -------------ADMIN-------------

def admin(request):
    return render(request, 'blog/admin.html')


def admin_additional(request):
    return render(request, 'blog/admin_additional.html')


def admin_cars(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM cars')
    cars = cursor.fetchall()
    cursor.execute('SELECT * FROM cars_detail')
    cars_details = cursor.fetchall()

    for x in range(len(cars)):
        cars[x] = cars[x] + cars_details[x]
    context = {'cars': cars}

    return render(request, 'blog/admin_cars.html', context=context)


def admin_insurance(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM insurance_packet')
    insurance = cursor.fetchall()

    context = {'insurance': insurance}

    return render(request, 'blog/admin_insurance.html', context=context)


def admin_orders(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM orders')
    orders = cursor.fetchall()




    context = {'orders': orders}

    return render(request, 'blog/admin_orders.html', context=context)


def admin_users(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM users')
    users = cursor.fetchall()

    context = {'users': users}
    return render(request, 'blog/admin_users.html', context=context)


def admin_prices(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM segment_price')
    prices = cursor.fetchall()

    context = {'prices': prices}


    return render(request, 'blog/admin_prices.html', context=context)


def admin_dtd(request):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT * FROM door_to_door')
    dtd = cursor.fetchall()

    context = {'dtd': dtd}
    return render(request, 'blog/admin_dtd.html', context=context)


def users_edit(request, link):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT MAX(UserID) FROM users')
    IDs = cursor.fetchall()
    lastID = max(IDs)

    if request.method == 'GET':
        if link == 0:
            return render(request, 'blog/users_add.html')

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM users')
        users = cursor.fetchall()
        context = ''
        for u in users:
            if u[0] == link:
                context = {'users': u}
                break

    if request.method == 'POST':
        if request.POST.get('delete', 'false') == 'true':
            try:
                cnx = mysql.connector.connect(
                    host='localhost',
                    user='root',
                    database='car_rental',
                )
                cursor = cnx.cursor(buffered=True)
                cursor.execute(
                    f'''DELETE FROM orders WHERE UserID = {link};DELETE FROM users WHERE UserID = {link};COMMIT;''')
            except mysql.connector.Error:
                pass

            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            try:
                cursor.execute('SELECT * FROM users')
                users = cursor.fetchall()
                context = {'users': users}
            except mysql.connector.Error:
                pass

            return render(request, 'blog/admin_users.html', context=context)

        if link == 0:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)



            try:
                cursor.execute(f'''INSERT INTO users (UserID, Name, Surname, Email, Phone, Age, Sex, DriverLicenceCat, SinceWhenDriverLicence)
                                    VALUES ({max(lastID)+1},'{request.POST['Name']}','{request.POST['Surname']}','{request.POST['Email']}',
                                    '{request.POST['Phone']}',{request.POST['Age']},'{request.POST['Sex']}','{request.POST['DriverLicenceCat']}',{request.POST['SinceWhenDriverLicence']});
                                    COMMIT;''')
            except mysql.connector.Error:
                pass
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',)


            cursor = cnx.cursor(buffered=True)
            cursor.execute('SELECT * FROM users')
            users = cursor.fetchall()
            context = {'users': users}

            return render(request, 'blog/admin_users.html', context=context)




        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM users
                        WHERE UserID = {link};
                        UPDATE users 
                        SET Name = '{request.POST['Name']}',
                        Surname = '{request.POST['Surname']}',
                        Email = '{request.POST['Email']}',
                        Phone = '{request.POST['Phone']}',
                        Age = {request.POST['Age']},
                        Sex = '{request.POST['Sex']}',
                        DriverLicenceCat = '{request.POST['DriverLicenceCat']}',
                        SinceWhenDriverLicence = {request.POST['SinceWhenDriverLicence']}
                        WHERE UserID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM users')
        users = cursor.fetchall()

        context = {'users': users}
        return render(request, 'blog/admin_users.html', context=context)

    return render(request, 'blog/users_edit.html', context=context)


def user_detail(request, link):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute(f'''SELECT * FROM users WHERE UserID = {link}''')
    user = cursor.fetchall()
    context = {'user': user}
    return render(request, 'blog/user_detail.html', context=context)


def orders_edit(request, link):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)
    cursor.execute('SELECT MAX(OrderID) FROM orders')
    IDs = cursor.fetchall()
    lastID = max(IDs)

    if request.method == 'GET':

        if link == 0:
            return render(request, 'blog/orders_add.html')

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM orders')
        orders = cursor.fetchall()
        context = ''
        for o in orders:
            if o[0] == link:
                context = {'orders': o}
                break

    if request.method == 'POST':
        if request.POST.get('delete', 'false') == 'true':
            try:
                cnx = mysql.connector.connect(
                    host='localhost',
                    user='root',
                    database='car_rental',
                )
                cursor = cnx.cursor(buffered=True)
                cursor.execute(f'''DELETE FROM prices_for_additional_services WHERE OrderID = {link};DELETE FROM additional_services WHERE OrderID = {link};DELETE FROM door_to_door WHERE OrderID = {link};DELETE FROM orders WHERE OrderID = {link};DELETE FROM users WHERE UserID=(SELECT orders.UserID FROM orders WHERE orders.OrderID = {link});COMMIT;''')
            except mysql.connector.Error:
                pass

            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            try:
                cursor.execute('SELECT * FROM orders')
                orders = cursor.fetchall()
                context = {'orders': orders}
            except mysql.connector.Error:
                pass

            return render(request, 'blog/admin_orders.html', context=context)

        if link == 0:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)



            try:
                cursor.execute(f'''INSERT INTO orders (OrderID, UserID, CarID, WhenOrdered, RentalDays, RentalStart, RentalEnd, IfAbroad, IfPaid, RentalPrice)
                                    VALUES ({max(lastID)+1},{request.POST['UserID']},{request.POST['CarID']},'{request.POST['WhenOrdered']}',
                                    {request.POST['RentalDays']},'{request.POST['RentalStart']}','{request.POST['RentalEnd']}',{request.POST['IfAbroad']},{request.POST['IfPaid']},{request.POST['RentalPrice']});
                                    COMMIT;''')
            except mysql.connector.Error:
                pass
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',)


            cursor = cnx.cursor(buffered=True)
            cursor.execute('SELECT * FROM orders')
            orders = cursor.fetchall()
            context = {'orders': orders}

            return render(request, 'blog/admin_orders.html', context=context)


        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM orders
                            WHERE OrderID = {link};
                            UPDATE orders 
                            SET UserID = {request.POST['UserID']},
                            CarID = {request.POST['CarID']},
                            WhenOrdered = '{request.POST['WhenOrdered']}',
                            RentalDays = {request.POST['RentalDays']},
                            RentalStart = '{request.POST['RentalStart']}',
                            RentalEnd = '{request.POST['RentalEnd']}',
                            IfAbroad = {request.POST['IfAbroad']},
                            IfPaid = {request.POST['IfPaid']},
                            RentalPrice = {request.POST['RentalPrice']}
                            WHERE OrderID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM orders')
        orders = cursor.fetchall()

        context = {'orders': orders}
        return render(request, 'blog/admin_orders.html', context=context)

    return render(request, 'blog/orders_edit.html', context=context)


def prices_edit(request, link):

    if request.method == 'GET':

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM segment_price')
        prices = cursor.fetchall()
        context = ''
        for p in prices:
            if p[0] == link:
                context = {'prices': p}
                break

    if request.method == 'POST':
        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM segment_price
                            WHERE SegmentID = {link};
                            UPDATE segment_price 
                            SET DepositPrice = {request.POST['DepositPrice']},
                            BasicPrice = {request.POST['BasicPrice']}
                            WHERE SegmentID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM segment_price')
        prices = cursor.fetchall()

        context = {'prices': prices}
        return render(request, 'blog/admin_prices.html', context=context)

    return render(request, 'blog/prices_edit.html', context=context)


def insurance_edit(request, link):
    if request.method == 'GET':

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM insurance_packet')
        insurance = cursor.fetchall()
        context = ''
        for i in insurance:
            if i[0] == link:
                context = {'insurance': i}
                break

    if request.method == 'POST':
        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM insurance_packet
                            WHERE InsuranceID = {link};
                            UPDATE insurance_packet 
                            SET InsuranceName = '{request.POST['InsuranceName']}',
                            InsuranceDescription = '{request.POST['InsuranceDescription']}',
                            InsurancePrice = {request.POST['InsurancePrice']}
                            WHERE InsuranceID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM insurance_packet')
        insurance = cursor.fetchall()

        context = {'insurance': insurance}
        return render(request, 'blog/admin_insurance.html', context=context)

    return render(request, 'blog/insurance_edit.html', context=context)


def dtd_edit(request, link):
    if request.method == 'GET':

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM door_to_door')
        dtd = cursor.fetchall()
        context = ''
        for d in dtd:
            if d[0] == link:
                context = {'dtd': d}
                break

    if request.method == 'POST':
        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM door_to_door
                            WHERE OrderID = {link};
                            UPDATE door_to_door 
                            SET Street = '{request.POST['Street']}',
                            HouseNumber = '{request.POST['HouseNumber']}',
                            FlatNumber = '{request.POST['FlatNumber']}',
                            PostCode = '{request.POST['PostCode']}',
                            City = '{request.POST['City']}'
                            WHERE OrderID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM door_to_door')
        dtd = cursor.fetchall()

        context = {'dtd': dtd}
        return render(request, 'blog/admin_dtd.html', context=context)

    return render(request, 'blog/dtd_edit.html', context=context)


def cars_edit(request, link):
    cnx = mysql.connector.connect(
        host='localhost',
        user='root',
        database='car_rental',
    )
    cursor = cnx.cursor(buffered=True)

    cursor.execute('SELECT MAX(CarID) FROM cars')
    IDs = cursor.fetchall()
    lastID = max(IDs)

    if request.method == 'GET':

        if link == 0:
            return render(request, 'blog/cars_add.html')

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)

        cursor.execute('SELECT * FROM cars')
        cars_fetch = cursor.fetchall()
        cursor.execute('SELECT * FROM cars_detail')
        cars_details = cursor.fetchall()
        context = ''
        for c in cars_fetch:
            if c[0] == link:
                context = {'cars': c}
                break
        for c in cars_details:
            if c[0] == link:
                context['cars_details'] = c
                break

    if request.method == 'POST':
        if request.POST.get('delete', 'false') == 'true':
            try:
                cnx = mysql.connector.connect(
                    host='localhost',
                    user='root',
                    database='car_rental',
                )
                cursor = cnx.cursor(buffered=True)
                cursor.execute(
                    f'''DELETE FROM cars_detail WHERE CarID = {link};DELETE FROM orders WHERE CarID = {link};DELETE FROM cars WHERE CarID = {link};COMMIT;''')
            except mysql.connector.Error:
                pass

            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute('SELECT * FROM cars')
            cars = cursor.fetchall()
            cursor.execute('SELECT * FROM cars_detail')
            cars_details = cursor.fetchall()
            for x in range(len(cars)):
                cars[x] = cars[x] + cars_details[x]

            context = {'cars': cars}

            return render(request, 'blog/admin_cars.html', context=context)

        if link == 0:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)



            try:
                cursor.execute(f'''INSERT INTO cars (Model, Mark, SegmentID, IfRented, BodyType, TransmissionType, FuelType, SeatsNumber)
                                    VALUES ('{request.POST['mark']}','{request.POST['model']}','{request.POST['segment']}',{request.POST['ifrented']},'{request.POST['bodytype']}','{request.POST['transmission']}','{request.POST['fuel']}', {request.POST['seats']});
                                    INSERT INTO cars_detail (CarID, mileage_city, mileage_road, boot_capacity, doors_number, conditioning_type, engine_capacity, engine_power, drive, air_pillow_number, electric_windows, electric_mirrors, heated_mirrors, VIN_number, image, url_to_autocentrum, description)
                                    VALUES ({max(lastID)+1},{request.POST['city']},{request.POST['road']},{request.POST['trunk']},{request.POST['doors']},'{request.POST['ac']}',{request.POST['enginecap']},{request.POST['enginepow']},'{request.POST['drive']}',{request.POST['airbags']},{request.POST['windows']},
                                    {request.POST['emirrors']},{request.POST['hmirrors']},'{request.POST['vin']}','{request.POST['image']}','{request.POST['acentrum']}','{request.POST['desc']}');COMMIT;''')
            except mysql.connector.Error:
                pass
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',)


            cursor = cnx.cursor(buffered=True)
            cursor.execute('SELECT * FROM cars')
            cars = cursor.fetchall()
            cursor.execute('SELECT * FROM cars_detail')
            cars_details = cursor.fetchall()
            for x in range(len(cars)):
                cars[x] = cars[x] + cars_details[x]

            context = {'cars': cars}

            return render(request, 'blog/admin_cars.html', context=context)

        try:
            cnx = mysql.connector.connect(
                host='localhost',
                user='root',
                database='car_rental',
            )
            cursor = cnx.cursor(buffered=True)
            cursor.execute(f'''SELECT * FROM cars
                        WHERE CarID = {link};
                        UPDATE cars 
                        SET Mark = '{request.POST['mark']}',
                        Model = '{request.POST['model']}',
                        SegmentID = '{request.POST['segment']}',
                        IfRented = {request.POST['ifrented']},
                        BodyType = '{request.POST['bodytype']}',
                        TransmissionType = '{request.POST['transmission']}',
                        FuelType = '{request.POST['fuel']}',
                        SeatsNumber = {request.POST['seats']}
                        WHERE CarID = {link};
                        SELECT * FROM cars_detail 
                        WHERE CarID = {link};
                        UPDATE cars_detail
                        SET mileage_city = {request.POST['city']},
                        mileage_road = {request.POST['road']},
                        boot_capacity = {request.POST['trunk']},
                        doors_number = {request.POST['doors']},
                        conditioning_type = '{request.POST['ac']}',
                        engine_capacity = {request.POST['enginecap']},
                        engine_power = {request.POST['enginepow']},
                        drive = '{request.POST['drive']}',
                        air_pillow_number = {request.POST['airbags']},
                        electric_windows = {request.POST['windows']},
                        electric_mirrors = {request.POST['emirrors']},
                        heated_mirrors = {request.POST['hmirrors']},
                        VIN_number = '{request.POST['vin']}',
                        image = '{request.POST['image']}',
                        url_to_autocentrum = '{request.POST['acentrum']}',
                        description = '{request.POST['desc']}'
                        WHERE CarID = {link}; COMMIT;''')
        except mysql.connector.Error:
            pass

        cnx = mysql.connector.connect(
            host='localhost',
            user='root',
            database='car_rental',
        )
        cursor = cnx.cursor(buffered=True)
        cursor.execute('SELECT * FROM cars')
        cars = cursor.fetchall()
        cursor.execute('SELECT * FROM cars_detail')
        cars_details = cursor.fetchall()
        for x in range(len(cars)):
            cars[x] = cars[x] + cars_details[x]
        context = {'cars': cars}

        return render(request, 'blog/admin_cars.html', context=context)

    return render(request, 'blog/cars_edit.html', context=context)