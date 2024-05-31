import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class NoAttempt extends RegisterState {}

class Registration extends RegisterState {}

class Registered extends RegisterState {}

class NotRegistered extends RegisterState {}
