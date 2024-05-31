import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class NavItem extends StatelessWidget {
  const NavItem({Key? key, required this.title, required this.icon,required this.widget}) : super(key: key);
  final String title;
  final IconData icon;
  final String widget;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
       context.pushNamed(widget);   
      },
    );
  }
}