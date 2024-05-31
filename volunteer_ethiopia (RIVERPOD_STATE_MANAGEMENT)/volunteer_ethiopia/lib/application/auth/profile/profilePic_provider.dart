import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicNotifier extends StateNotifier<ProfilePicState> {
  ProfilePicNotifier() : super(NotClicked());

  File? profileImage;

  Future<void> pickProfile() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      state = NotClicked();
      return;
    }
    profileImage = File(image.path);
    state = Clicked();
  }
}

final profilePicProvider = StateNotifierProvider<ProfilePicNotifier, ProfilePicState>((ref) {
  return ProfilePicNotifier();
});
