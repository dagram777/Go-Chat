import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:volunteer_ethiopia_mobile/lib.dart';

class DonationDataProvider {
  final _baseUri = 'http://192.168.56.1:3000/';
  final Client client;
  // final MultipartRequest request;

  DonationDataProvider({required this.client});

  Future<Donation?> createDonation(Donation donation) async {
    try {
      var response = await client.post(Uri.parse("${_baseUri}donations"),
          headers: {"content-type": "application/json"},
          body: jsonEncode({
            'donated_amount': donation.donated_amount,
            'account_number': donation.account_number,
            'post': [donation.post],
            'user': [donation.user],
          }));

      if (response.statusCode == 201) {
        print("good");

        return Donation.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create Donation.');
      }
    } catch (e) {
      print(e.toString() + "the exception is here");
      rethrow;
    }
  }

  Future<Donation> getDonation(int id) async {
    var response = await client.get(Uri.parse("${_baseUri}donationDetail/$id"));
    if (response.statusCode == 200) {
      final donation = Donation.fromJson(json.decode(response.body));
      return donation;
    } else {
      throw Exception('Failed to get donation');
    }
  }

  Future<void> deleteDonation(int id) async {
    final Response response = await client.delete(
      Uri.parse('${_baseUri}donations/$id'),
      headers: <String, String>{
        'Type': 'application/json; charset = UTF-8',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('deletion failed');
    }
  }

  Future<List<Donation>> getDonationsByUser(int userId) async {
    final Response response =
        await client.get(Uri.parse('${_baseUri}donations/$userId'));
    if (response.statusCode == 200) {
      print("here i am chlling" + response.body);
      List<Donation> donations = [];
      final responseFromJson = jsonDecode(response.body);
      print("after chilling");
      for (var donation in responseFromJson) {
        donations.add(Donation.fromJson(donation));
      }
      print(donations);
      return donations;
    } else {
      throw Exception("could not get donations");
    }
  }

  Future<Donation> updateDonation(int id, Donation donation) async {
    print(donation);
    final response = await http.put(Uri.parse("${_baseUri}donations/$id"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "id": donation.id,
          "donated_amount": donation.donated_amount,
          "account_number": donation.account_number,
          "user": [donation.user],
          "post": [donation.post]
        }));
    print("this is this");
    if (response.statusCode == 201 || response.statusCode == 204) {
      return Donation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("could not update donation");
    }
  }
}
