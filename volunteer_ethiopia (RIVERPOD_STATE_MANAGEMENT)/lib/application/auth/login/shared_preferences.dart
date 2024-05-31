import 'package:volunteer_ethiopia_mobile/infrastructure/auth/data_provider.dart';
import 'package:http/http.dart';

import '../../../main.dart';

class SharedPreference {
  final UserDataProvider dataProvider = UserDataProvider(client: Client());

  String? getCatch() {
    return pref.getString("email");

  }
  void clearup() async {
    pref.clear();
  }

  Future<bool> isEmpty() async {
    return !(pref.containsKey('email'));
  }

  Future removeCatch(String email) async {

    pref.remove("email");
  }
}
