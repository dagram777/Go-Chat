import 'package:equatable/equatable.dart';


class Donation extends Equatable {
  final int donated_amount;
  final int user;
  final String account_number;
  final int post;
  final id;

  Donation(
      {this.id,
      required this.donated_amount,
      required this.user,
      required this.account_number,
      required this.post});

  @override
  List<Object?> get props =>
      [donated_amount, user, account_number, post.toString()];

  static fromJson(Map<String, dynamic> json) {
    return Donation(
        id: json["id"],
        donated_amount: json["donated_amount"],
        user: json["user"][0],
        account_number: json["account_number"],
        post: json["post"][0]);
  }
}
