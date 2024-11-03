

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/domain.dart';
import '../../../infrastructure/infrastracture.dart';
import '../../../main.dart';
import 'loginState.dart';
import 'package:http/http.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final SharedPreference sharedPreference = SharedPreference();
  final UserDataProvider dataProvider = UserDataProvider(client: Client());
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(NoAttempt()) {
    on<LoginEvent>(_loginAttempt);
  }

  void _loginAttempt(LoginEvent event, Emitter emit) async {
    emit(Logingin());
    User user =
        User(first_name: '', email: event.email, password: event.password);

    var res = null;
    try {
      res = await userRepository.searchUser(user);
    } catch (e) {
      emit(LoginFailed());
    }
    if (res == null) {
      emit(LoginFailed());
    } else {
      print(event.email);
      pref.clear();
      User user = await dataProvider.getUser(event.email);
      pref.setString("email", user.toString());
      emit(LoginSuccesful());
    }
  }
}
