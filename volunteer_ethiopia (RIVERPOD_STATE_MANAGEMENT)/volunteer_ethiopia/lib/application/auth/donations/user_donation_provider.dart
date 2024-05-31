import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class UserDonationNotifier extends StateNotifier<UserDonationState> {
  final DonationRepository donationRepo;

  UserDonationNotifier({required this.donationRepo}) : super(StartingState());

  Future<void> getUserDonations(int userId) async {
    state = GettingUserDonationState();
    try {
      final donations = await donationRepo.getDonationsByUser(userId);
      state = GetUserDonationSuccessful(donations: donations);
    } catch (e) {
      state = GetUserDonationFailed();
    }
  }

  Future<void> deleteDonation(int donationId) async {
    state = DeletingDonationState();
    try {
      await donationRepo.deleteDonation(donationId);
      state = DeleteDonationSuccessfulState();
    } catch (e) {
      state = DeleteDonationFailed();
    }
  }

  Future<void> getDonationToUpdate(int donationId) async {
    state = GettingDonationToUpdateState();
    try {
      final donation = await donationRepo.getDonation(donationId);
      state = GetDonationToUpdateSuccessfulState(donation: donation);
    } catch (e) {
      state = GetDonationToUpdateFailedState();
    }
  }

  Future<void> updateDonation(int donationId, Donation donation) async {
    state = UpdatingDonationState();
    try {
      await donationRepo.updateDonation(donationId, donation);
      state = UpdateDonationSuccessful();
    } catch (e) {
      state = UpdateDonationFailed();
    }
  }
}

final userDonationProvider = StateNotifierProvider<UserDonationNotifier, UserDonationState>((ref) {
  final donationRepo = ref.read(donationRepositoryProvider);
  return UserDonationNotifier(donationRepo: donationRepo);
});
