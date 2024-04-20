import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var obj = json.decode(""); // Placeholder, update with actual logic
    var isAdmin = obj != null ? obj['is_admin'] ?? false : false;

    Widget listTile(bool condition, IconData icon, String title, String routeName) {
      return condition
          ? GestureDetector(
              onTap: () async {
                context.pushNamed(routeName);
              },
              child: ListTile(
                leading: Icon(icon),
                title: Text(title),
              ),
            )
          : SizedBox(height: 2);
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                image: AssetImage("assets/volunteer_logo.jpg"), // Placeholder image asset
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Divider(),
          NavItem(title: "Home", icon: Icons.home, widget: 'home'),
          listTile(isAdmin, Icons.people, 'List Of Users', 'ListOfUsers'),
          listTile(isAdmin, Icons.file_copy, 'List Of Posts', 'ListOfPosts'),
          NavItem(title: "Login/register", icon: Icons.login, widget: 'Login'),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String widget;

  const NavItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        context.goNamed(widget);
      },
    );
  }
}
