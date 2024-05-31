
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  final int? id;
  final String first_name;
  final String? last_name;
  final String email;
  final String password;
  final bool? is_client;
  final bool? is_admin;

  User(
      {this.id,
      required this.first_name,
       this.last_name,
      required this.email,
     required this.password,
      this.is_client,
      this.is_admin });
  
  @override
  String toString() =>
      '{ "id": $id, "first_name": "$first_name", "last_name": "$last_name" , "email": "$email", "is_client" : $is_client, "is_admin": $is_admin }';
  @override
  List<Object?> get props =>
      [id, first_name, last_name, email,is_client, is_admin];

  static fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        first_name: json['first_name'],
        email: json['email'],
        last_name: json['last_name'],
        password: json['password'],
        is_client: json['is_client'],
        is_admin:json['is_admin']);
  }
}