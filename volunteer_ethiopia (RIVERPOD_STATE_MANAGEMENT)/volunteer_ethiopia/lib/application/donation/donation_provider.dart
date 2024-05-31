import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class DonationNotifier extends StateNotifier<DonationState> {
  final DonationRepository donationRepo;

  DonationNotifier({required this.donationRepo}) : super(Normal());

  Future<void> donate(Donate event) async {
    state = Donating();
    print(event.account_number.toString() +
        "- account num amount -" +
        event.donated_amount.toString() +
        " " +
        event.post.toString() +
        " " +
        event.user.toString());
    try {
      await donationRepo.createDonation(Donation(
          donated_amount: event.donated_amount,
          user: event.user,
          account_number: event.account_number,
          post: event.post));
      state = DonationSuccessful();
      await Future.delayed(Duration(seconds: 1));
      state = Normal();
    } catch (e) {
      print(e);
      state = DonationFailed();
    }
  }
}

final donationProvider = StateNotifierProvider<DonationNotifier, DonationState>((ref) {
  final donationRepo = ref.read(donationRepositoryProvider);
  return DonationNotifier(donationRepo: donationRepo);
});
