import 'package:volunteer_ethiopia_mobile/lib.dart';

class DonationRepository {
  final DonationDataProvider dataProvider;

  DonationRepository({required this.dataProvider});

  Future<Donation?> createDonation(Donation donation) async {
    return await dataProvider.createDonation(donation);
  }

 
  Future<void> deleteDonation(int id) async {
    return await dataProvider.deleteDonation(id);
  }

  Future<List<Donation>> getDonationsByUser(int id) async {
    return await dataProvider.getDonationsByUser(id);
  }

  Future<Donation> updateDonation(int id, Donation donation) async {
    return await dataProvider.updateDonation(id, donation);
  }

  Future<Donation> getDonation(int id) async {
    return await dataProvider.getDonation(id);
  }
}
