
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/auth/data_provider.dart';

import '../../../domain/auth/user_model.dart';
import 'bloc.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  UserRepository userRepository;
  RegBloc({required this.userRepository}) : super(NoAttempt()) {
    on<RegEvent>(_registerClicked);
  }

  void _registerClicked(RegEvent event, Emitter emit) async {
    emit(Registration());
    print(event.firstName);
    User user = User(
        email: event.email,
        first_name: event.firstName,
        password: event.Password,
        last_name: event.lastName,
        is_admin: true);
    print(event.Password);
    var res = null;
    try {
      res = await userRepository.createUser(user);
    } catch (e) {
      emit(NotRegisterd());
    }
    if (res == null) {
      emit(NotRegisterd());
    } else {
      print(res);
      emit(Registerd());
    }
  }
}
