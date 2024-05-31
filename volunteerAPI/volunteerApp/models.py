
from django.db import models



# Create your models here.
# fields = ['title' , 'description' , 'goal' , 'image' ] required
class Post(models.Model):
    title = models.CharField(max_length=100 , null=False , blank=False)
    description = models.TextField(null=False, blank=False)

    goal = models.IntegerField(null=False )

    donated = models.IntegerField(null=True, blank=True, default=0)
    donator_count = models.IntegerField(null=True, blank= True, default=0)
    created = models.DateTimeField(null= True , blank= True)
    image = models.ImageField(upload_to = 'uploaded')
   
    def __str__(self):
        return self.title

class Member(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100 ,blank= True, null = True)
    email = models.EmailField(max_length=100, unique=True)
    password = models.TextField()
    is_client = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    def __str__(self):
        return self.first_name


class Donation(models.Model):
    user = models.ManyToManyField(Member)
    donated_amount = models.IntegerField(null = False)
    post =  models.ManyToManyField(Post)
    account_number = models.CharField(null=False , max_length=20)

    def __str__(self):
        return str(self.account_number)



