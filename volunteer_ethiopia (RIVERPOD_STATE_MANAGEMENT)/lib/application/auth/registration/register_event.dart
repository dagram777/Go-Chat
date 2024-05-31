import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  const RegisterEvent({required this.email, required this.firstName, required this.lastName, required this.password});

  @override
  List<Object> get props => [email, firstName, lastName, password];
}
