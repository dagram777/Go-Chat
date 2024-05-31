import 'dart:convert';

import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_ethiopia_mobile/main.dart';
import 'package:go_router/go_router.dart';
import 'home.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();
  Future<bool> checkEmpty() async {
    return await sharedPreference.isEmpty();
  }

  @override
  Widget build(BuildContext context) {
    var obj = pref.getString("email");
    var mem = json.decode(obj.toString());

    var listofpost = mem == null ? SizedBox(height: 2,) : mem['is_admin'] == true
        ? GestureDetector(
            onTap: () async {
              context.pushNamed('ListOfPosts');
            },
            child: ListTile(
                leading: Icon(Icons.file_copy), title: Text('List Of Posts')))
        :  SizedBox(
                height: 2,
              );
    var listofuser = mem == null
        ?  SizedBox(height: 2,)
        : mem['is_admin'] == true
        ? GestureDetector(
            onTap: () async {
              context.pushNamed('ListOfUsers');
            },
            child: ListTile(
                leading: Icon(Icons.people), title: Text('List Of Users')))
        : SizedBox(height: 2,);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            // width: 17,
            height: 250,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: AssetImage("assets/gada_logo.jpg"),
                    fit: BoxFit.fitWidth)),
          ),
          const Divider(),
          const NavItem(title: 
          "Home", icon: Icons.home, widget: 'home'),
          listofuser,
          // const NavItem(
          //     title: "List Of Users",
          //     icon: Icons.people_alt,
          //     widget: 'ListOfUsers'),
          listofpost,
          NavItem(title: "Login/register", icon: Icons.login, widget: 'Login'),
        ],
      ),
    );
  }
}
