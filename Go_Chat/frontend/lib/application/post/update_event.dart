import 'dart:io';
import 'package:volunteer_ethiopia_mobile/lib.dart';


abstract class EditCampaignEvent extends CampaignEvent{}


class GetCampaignEvent extends EditCampaignEvent{
  final int id;

  GetCampaignEvent({required this.id});
}

class UpdateCampaignEvent extends CampaignEvent{
  final String description;
  final String title;
  final File image;
  final int goal;

  UpdateCampaignEvent({required this.description, required this.title, required this.image, required this.goal});
  
}