import 'package:volunteer_ethiopia_mobile/lib.dart';

abstract class UserDonationEvent {}

class DeleteDonationEvent extends UserDonationEvent {
  final int id;
  DeleteDonationEvent({required this.id});
}

class UpdateDonationEvent extends UserDonationEvent {
  final int id;
  final Donation donation;
  UpdateDonationEvent({required this.donation, required this.id});
}

class GetDonationPostEvent extends UserDonationEvent {
  final int id;

  GetDonationPostEvent({required this.id});
}

class GetUserDonation extends UserDonationEvent {
  final int id;
  GetUserDonation({required this.id});
}

class GetDonationUpdatedEvent extends UserDonationEvent{
  final int id;
  GetDonationUpdatedEvent({required this.id});
}