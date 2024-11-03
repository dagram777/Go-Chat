
import '../../lib.dart';

class CampaignState {}

class Idle extends CampaignState {}

class CreatingPost extends CampaignState {}

class CreateSuccess extends CampaignState {}

class CreateFailed extends CampaignState {}

class PickingImage extends CampaignState {}

class PickSuccess extends CampaignState {}

class PickFail extends CampaignState {}

class LoadSuccess extends CampaignState {
  final List<Post> posts;
  LoadSuccess({required this.posts});
}

class LoadFailed extends CampaignState {}

class LoadingHome extends CampaignState {}

class LoadFail extends CampaignState {}
class LoadNotFail extends CampaignState{
  Post? post;
  LoadNotFail({required this.post});
}

// class UpdateCampaignState extends CampaignState{}

class LoadingPost extends CampaignState {}

class LoadPostSuccessfull extends CampaignState {
  final Post post;
  LoadPostSuccessfull({required this.post});
}

class LoadPostFailed extends CampaignState {}

class UpdatingPost extends CampaignState{}

class UpdatePostSuccessfull extends CampaignState{}

class UpdatePostFailed extends CampaignState{}