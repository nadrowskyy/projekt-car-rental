from django import forms

# własnoręczne renderowanie pól https://docs.djangoproject.com/en/3.1/topics/forms/#rendering-fields-manually

SEX_CHOICES =(
    (" ", " "),
    ("mężczyzna", "Mężczyzna"),
    ("kobieta", "Kobieta"),
)

class UserDataForm(forms.Form):
    name = forms.CharField(label="Imię", max_length=100, required=True)
    surname = forms.CharField(label="Nazwisko", max_length=100, required=True)
    email = forms.EmailField(label="Email", max_length=100, required=True)
    phone = forms.IntegerField(label="Numer kontaktowy", required=True)
    age = forms.IntegerField(label="Wiek", max_value=140, required=True)
    sex = forms.ChoiceField(label= "Płeć", choices= SEX_CHOICES)
    drive_cat = forms.CharField(label="Kategoria prawa jazdy", required=True)
    experience = forms.DateField(label="Od kiedy posiadasz prawo jazdy", required=True)
