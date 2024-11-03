import 'dart:convert';
// import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:gada_ethiopia_mobile/lib.dart';
import '../../domain/auth/user_model.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class UserDataProvider {
  // final _baseUri = 'http://192.168.56.1:3000/';
// class UserDataProvider {
  final _baseUri = 'http://192.168.56.1:3000/';
  final http.Client client;

  UserDataProvider({required this.client});

  Future<User?> createUser(User user) async {
    var response = await client.post(Uri.parse("${_baseUri}users"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'first_name': user.first_name,
          'last_name': user.last_name,
          'email': user.email,
          'password': user.password,
          'is_admin': true,
        }));
    // ))

    if (response.statusCode == 201) {
      return user;
    } else {
      throw Exception("user create failed");
    }

    
  }

  Future<List<User>> getUsers() async {
    var response = await http.get(Uri.parse("${_baseUri}users"), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside');
      final users = jsonDecode(response.body) as List;
      List<User> ret = [];

      for (var user in users) {
        ret.add(User.fromJson(user));
      }

      return ret;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUser(int id) async {
    print("came to delete");
    try {
      final http.Response response = await client.delete(
        Uri.parse("${_baseUri}usersDetail/$id"),
        headers: <String, String>{
          'Type': 'application/json; charset = UTF-8',
        },
      );
    } catch (e) {
      print(e);
    }
    var response;
    if (response.statusCode != 204 || response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future<void> updateUser(User user) async {
    final http.Response response = await client.put(
      Uri.parse('${_baseUri}users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': user.first_name,
        'last_name': user.last_name,
        'email': user.email,
        'password': user.password,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Operation Failed.');
    }
  }

  Future<User?> searchUser(User user) async {
    print("search usr");
    var response = await client.post(Uri.parse("${_baseUri}email-password"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': user.email,
          'password': user.password,
        }));
    // ))
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("finally");
      return user;
    } else {
      return null;
    }
  }

  Future<User> getUser(String email) async {
    final response =
        await client.get(Uri.parse("${_baseUri}usersDetail/$email"));
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return User.fromJson(user);
    } else {
      throw Exception('Post not found.');
    }
  }
}
