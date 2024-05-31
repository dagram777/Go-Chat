import 'package:bloc/bloc.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class UserDonationBloc extends Bloc<UserDonationEvent, UserDonationState> {
  final DonationRepository donationRepo;
  // final PostRepository postRepository;
  UserDonationBloc({required this.donationRepo}) : super(StartingState()) {
    on<UserDonationEvent>(onUserDonation);
  }

  Future<void> onUserDonation(UserDonationEvent event, Emitter emit) async {
    if (event is GetUserDonation) {
      try {
        emit(GettingUserDonationState());
        List<Donation> donations =
            await donationRepo.getDonationsByUser(event.id);
        emit(GetUserDonationSuccessfull(donations: donations));
      } catch (e) {
        print(e);
        print("error here");
        emit(GetUserDonationFailed());
      }
    }
    if (event is DeleteDonationEvent) {
      try {
        emit(DeletingDonationState());
        await donationRepo.deleteDonation(event.id);
        emit(DeleteDonationSuccessfullState());
      } catch (e) {
        emit(DeleteDonationFailed());
      }
    }
    if (event is GetDonationUpdatedEvent) {
      try {
        emit(GettingDonationToUpdateState());
        final donation = await donationRepo.getDonation(event.id);
        emit(GetDonationToUpdateSuccessfullState(donation: donation));
      } catch (e) {
        print('the error is' + e.toString());
        emit(GetDonationToUpdateFailedState());
      }
    }
    if (event is UpdateDonationEvent) {
      try {
        emit(UpdatingDonationState());
        await donationRepo.updateDonation(event.id, event.donation);
        emit(UpdateDonationSuccessfull());
      } catch (e) {
        print(e);
        emit(UpdateDonationFailed());
      }
    }
  }
}
