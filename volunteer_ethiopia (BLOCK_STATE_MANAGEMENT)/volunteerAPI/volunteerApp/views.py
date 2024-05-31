

from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse , JsonResponse


from rest_framework.parsers import JSONParser , MultiPartParser , FormParser
from django.views.decorators.csrf import csrf_exempt
import json
from rest_framework.views import APIView
from .serializers import DonationSerializer, PostSerializer, MemberSerializer

from .models import Donation, Post, Member
from django.contrib.auth.models import User

class DonationSingle(APIView):
    serializer_class = DonationSerializer
    parser_classes = [JSONParser]
    def get(self, request , pk):
      
        try:
            users = Donation.objects.get(id = pk)
        except:
            return HttpResponse(status = 404)

        serializer = self.serializer_class(instance=users)
        return JsonResponse(serializer.data , status = 200 )

        
class PostViewCreate(APIView):
    serializer_class = PostSerializer
    parser_classes = [MultiPartParser, FormParser]
    # header = http.header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept")
    def get(self, request):
        posts = Post.objects.all()
        serializer = self.serializer_class(instance=posts , many = True)
        return JsonResponse(serializer.data , status = 200 , safe=False)
       
    def post(self, request, format=None):
        data = request.data
        serialized = PostSerializer(data=data)
        if serialized.is_valid():
            serialized.save()
            
            return JsonResponse(serialized.data, status=201)
        
        return JsonResponse(serialized.errors, status=400)
    
class DetailPost(APIView):
    serializer_class = PostSerializer
    parser_classes = [MultiPartParser, FormParser]
    def get(self , request , pk):
        try:
            post = Post.objects.get(pk = pk)
        except:

            return HttpResponse(status = 404)

        serializer = self.serializer_class(instance= post)

        return JsonResponse(serializer.data , status = 200)

    def put(self , request , pk):
        data = request.data
        tit = data["title"]
        print(data["donated"])
        print(data["donator_count"])
        print(data["image"])
        print(data["goal"])
        print(data["description"])
        try:
            post = Post.objects.get(pk = pk)
            image = post.data.i
        except:

            return HttpResponse(status = 400)
        serialized = PostSerializer(instance = post , data=data)
        if serialized.is_valid():
            serialized.save()
            
            return JsonResponse(serialized.data, status=201)
        print(serialized.errors)

        print("or here")
        return JsonResponse(serialized.errors, status=400)
        

    def delete(self , request , pk):
        try:
            post = Post.objects.get(pk = pk)
        except:
            return HttpResponse(status = 204)
        post.delete()
        return HttpResponse(status = 200)
        


class ViewUser(APIView):
    serializer_class = MemberSerializer

    # parser_classes = [JSONParser]

    def get(self , request):
        print("users?")
        users = Member.objects.all()

        serializer = self.serializer_class(instance=users, many = True)
        return JsonResponse(serializer.data , status = 200 , safe=False)

    def post(self,request):
        data = request.data
        serialized = MemberSerializer(data=data)
        if serialized.is_valid():
            serialized.save()
            return JsonResponse(serialized.data, status= 201)
        return JsonResponse(serialized.errors, status=400)


class MemberDetail(APIView):
    serializer_class = MemberSerializer
    parser_classes = [JSONParser]
    def get(self, request , pk):
        try:
            users = Member.objects.get(email = pk)
        except:
            return HttpResponse(status = 404)

        serializer = self.serializer_class(instance=users)
        return JsonResponse(serializer.data , status = 200 )

    def put(self , request, pk):
        data = request.data
        try:
            mem = Member.objects.get(pk = pk)
        except:
            return HttpResponse(status = 400)

        serialized = MemberSerializer(instance = mem , data=data)
        if serialized.is_valid():
            serialized.save()
            
            return JsonResponse(serialized.data, status=201)
        
        return JsonResponse(serialized.errors, status=400)

    def delete(self , request , pk):
        print("hehe")
        try:
            user = Member.objects.get(id = pk)
        except:
            return HttpResponse(status = 204)
        user.delete()
        return HttpResponse(status = 200)



class DonationCreate(APIView):
    parser_classes = [JSONParser]
    def get(self, request):
        print("here")
        donations = Donation.objects.all()
        serializer = DonationSerializer(instance = donations, many = True)
        return JsonResponse(serializer.data, status = 200, safe=False)

    def post(self,request):
        data = request.data
        print(data , "what???")
    
        serialized = DonationSerializer(data=data)
        
        if serialized.is_valid():
            
            serialized.save()
            print(serialized)
            try:
                post = Post.objects.get(id = serialized.data['post'][0])
                Post.objects.filter(id = serialized.data['post'][0]).update(donated = post.donated + serialized.data['donated_amount'],donator_count = post.donator_count + 1 )
                return JsonResponse(serialized.data, status= 201)
            except:
                return HttpResponse(status = 400)
           
        return JsonResponse(serialized.errors, status=400)

class DonationDetail(APIView):
    def get(self,request, pk):
        donation = Donation.objects.all()
        print(donation, "donation")
        li = []
        for i in donation:
            print(Member.objects.get(pk = pk),  i.user.all , "##")
            if Member.objects.get(pk = pk) in list(i.user.all()):
                li.append(i)
        
        serializer = DonationSerializer(li, many = True )
        return JsonResponse(serializer.data, status = 200,safe= False )

    def put(self, request, pk):
        data = request.data
        try:
            mem = Donation.objects.get(pk = pk)
        except:
            return HttpResponse(status = 400)

        serialized = DonationSerializer(instance = mem , data=data)
        if serialized.is_valid():
            serialized.save()
            
            return JsonResponse(serialized.data, status=201)
        
        return JsonResponse(serialized.errors, status=400)

    def delete(self, request, pk):
        print("hehe")
        try:
            user = Donation.objects.get(id = pk)
        except:
            return HttpResponse(status = 204)
        user.delete()
        return HttpResponse(status = 200)

class Verify(APIView):
    def post(self , request):
        email = request.data['email']
        password = request.data['password']
        mem = None
        try:
            mem = Member.objects.get(email = email , password = password)
        except:
            return HttpResponse(status = 404)
        if mem: 
            return HttpResponse(status = 200)




