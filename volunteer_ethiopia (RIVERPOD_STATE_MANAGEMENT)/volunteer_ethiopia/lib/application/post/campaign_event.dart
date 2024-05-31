import 'dart:io';


abstract class CampaignEvent {}

class CreatePost extends CampaignEvent {
  final String title;
  final String description;
  final int goal;
  
  File image;
  CreatePost(
      {required this.title,
      required this.description,
      required this.goal,
      required this.image});
}

class PickImage extends CampaignEvent {
  final File image;
  PickImage({required this.image});
}
class GetPosts extends CampaignEvent {}

class FindPost extends CampaignEvent {
  int id;
  FindPost({required this.id});
}
class GetCampaignEvent extends CampaignEvent{
  final int id;

  GetCampaignEvent({required this.id});
}

class UpdateCampaignEvent extends CampaignEvent{
  final String description;
  final String title;
  final File image;
  final int goal;
  final int id;
  final int donated;
  final int donator_count;


  UpdateCampaignEvent({required this.donated, required this.donator_count, required this.id, required this.description, required this.title, required this.image, required this.goal});
  
}