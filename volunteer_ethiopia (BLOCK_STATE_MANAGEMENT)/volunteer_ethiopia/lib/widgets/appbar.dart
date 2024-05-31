import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../application/auth/login/shared_preferences.dart';
import '../lib.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({Key? key ,required this.title}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Icon(Icons.drafts),
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      // backgroundColor: Color.fromARGB(68, 255, 255, 255),
      title: Text(title),
      // centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegete());
            },
            // if(await jsonDecode(sharedPreference.getCatch().toString())['is_staff'] == true){}
            icon: const Icon(Icons.search)),
        IconButton(
          onPressed: () async {
            var obj = await sharedPreference.getCatch();
            if (obj != null) {
              // var mem = (jsonDecode());
              var mem = json.decode(obj.toString());

              print(mem);
              if (await sharedPreference.isEmpty()) {
                return null;
              }
              if (mem["is_client"] == true || mem["is_admin"] == true) {
                context.pushNamed('create-post');
              } else {
                context.pushNamed('login');
              }
            }
          },
          icon: Icon(Icons.add),
        ),
        GestureDetector(
          onTap: () async {
            if (await sharedPreference.isEmpty()) {
              context.push('/login');
            } else {
              context.push('/profile');
            }
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
            maxRadius: 20,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
