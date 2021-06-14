### CONTRIBUTORS:
https://github.com/nadrowskyy/
https://github.com/rabarbartek
https://github.com/mrudawski


HOW DOES THIS WORK?

*	After downloading project we need to create virtaul env and install dependencies from requirements.txt using command: `pip install -r requirements.txt`
##### Important thing is to put database file called car_rental.sql on localhost so mysql connector can connect to it:
      cnx = mysql.connector.connect(
      host='localhost',
      user='root',
      database='car_rental',
      )
	
##### Of course we have to install MySQL first if we don’t have it on our computer, you can 	find it here: https://dev.mysql.com/downloads/installer/
##### car_rental.sql can be imported to mysql workbench or xampp so our program will 	connect to a database
* Then we have to activate virtual env, go to project directory and run it through command: `python manage.py runserver`
* And here is what we see when we type http://localhost:8000/ in our browser: 


 ![image](https://user-images.githubusercontent.com/70075401/106351268-90b3e280-62db-11eb-8f43-d631dea9ef38.png)


*	We can choose date and click SZUKAJ SAMOCHODÓW:

![image](https://user-images.githubusercontent.com/70075401/106351281-a2958580-62db-11eb-9734-61c5087f318c.png)

*	Filter cars and click WIĘCEJ:

![image](https://user-images.githubusercontent.com/70075401/106351286-ab865700-62db-11eb-9bfc-233ac3639e19.png)

*	Rent a car by clicking WYNAJMIJ and choose interesting us options the click DALEJ:

![image](https://user-images.githubusercontent.com/70075401/106351290-b2ad6500-62db-11eb-9c48-ff31ac65745f.png)

*	Fill formula and last click – WYNAJMIJ:

![image](https://user-images.githubusercontent.com/70075401/106351297-bb05a000-62db-11eb-82fb-487c2b1a94eb.png)

*	Congratulations! You rented fake car:

 ![image](https://user-images.githubusercontent.com/70075401/106351300-c2c54480-62db-11eb-8d7e-6eec0f0b8347.png)


##### We can see here info that we received an email on typed earlier address but this option works if we configure it in app settings. 
  - to do this go to settings.py file and edit this lines of code:

    EMAIL_HOST = ‘smtp.gmail.com’
    EMAIL_PORT = 587
    EMAIL_HOST_USER = ‘’
    EMAIL_HOST_PASSWORD = ‘’
    EMAIL_USE_TLS = True

    More info here: https://data-flair.training/blogs/django-send-email/

  - then go to views.py in blog folder and uncomment this code:

    ```# Enter email credentials in settings.py to send emails and uncomment code below
    #m = EmailMessage(
    #    subject='Carnet Order',
    #    body='Szczegóły zamówienia w załączniku',
    #    from_email='carnetdjango@gmail.com',
    #    to=[e_mail],
    #)
    #m.attach('zamowienie', result.getvalue(), 'application/pdf')
    #.send()```
	
   #### IMPORTANT! Instead of `from_email='carnetdjango@gmail.com'` type email that you passed in settings.py file.

*	To see admin panel go to http://localhost:8000/admin/ in your browser

 ![image](https://user-images.githubusercontent.com/70075401/106351306-c8228f00-62db-11eb-8747-c0590ec1720c.png)

