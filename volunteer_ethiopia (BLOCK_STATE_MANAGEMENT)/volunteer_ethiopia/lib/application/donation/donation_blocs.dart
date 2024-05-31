import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class DonationBloc extends Bloc<DonationEvents, DonationStates> {
  final DonationRepository donationRepo;
  DonationBloc({required this.donationRepo}) : super(Normal()) {
    on<Donate>(onDonate);
  }
  onDonate(Donate event, Emitter emit) async {
    emit(Donating());
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
      emit(DonationSuccessfull());
      await Future.delayed(Duration(seconds: 1));
      emit(Normal());
    } catch (e) {
      print(e);
      emit(DonationFailed());
    }
  }
}
