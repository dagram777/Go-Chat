import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define an enum to represent the two states of the password visibility
enum PasswordVisibility { obscured, visible }

// Define a provider to manage the state of the password visibility
final passwordVisibilityProvider = StateProvider<PasswordVisibility>((ref) => PasswordVisibility.obscured);

// Define a function to toggle the state of the password visibility
void togglePasswordVisibility(Reader read) {
  final state = read(passwordVisibilityProvider);
  state.state = state.state == PasswordVisibility.obscured
      ? PasswordVisibility.visible
      : PasswordVisibility.obscured;
}
