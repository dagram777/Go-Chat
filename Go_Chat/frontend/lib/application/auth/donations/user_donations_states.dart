import 'package:volunteer_ethiopia_mobile/lib.dart';

abstract class UserDonationState{}

class DeletingDonationState extends UserDonationState{}

class DeleteDonationSuccessfullState extends UserDonationState{}

class DeleteDonationFailed extends UserDonationState{}

class StartingState extends UserDonationState{}

class GettingDonationPost extends UserDonationState{}

class GetDonationPostSuccessfull extends UserDonationState{
  final Post post;
  GetDonationPostSuccessfull({required this.post});
}

class GetDonationPostFailed extends UserDonationState{}

class PassToTheUpdateDonationState extends UserDonationState{
  final Post post;

  PassToTheUpdateDonationState({required this.post});
  
}

class UpdatingDonationState extends UserDonationState{}

class UpdateDonationSuccessfull extends UserDonationState{}

class UpdateDonationFailed extends UserDonationState{}

class GettingUserDonationState extends UserDonationState{}

class GetUserDonationSuccessfull extends UserDonationState{
  final List<Donation> donations;
  GetUserDonationSuccessfull({required this.donations});
}

class GetUserDonationFailed extends UserDonationState{}


class GettingDonationToUpdateState extends UserDonationState{}

class GetDonationToUpdateSuccessfullState extends UserDonationState{
  final Donation donation;
  GetDonationToUpdateSuccessfullState({required this.donation});
}

class GetDonationToUpdateFailedState extends UserDonationState{}