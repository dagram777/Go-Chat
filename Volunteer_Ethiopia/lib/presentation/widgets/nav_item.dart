import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VolunteerNavItem extends StatelessWidget {
  const VolunteerNavItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.routeName,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        context.pushNamed(routeName);
      },
    );
  }
}

class VolunteerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("volunteerEthiopia"),
      ),
      body: Center(
        child: Text(
          "Welcome to volunteerEthiopia!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class VolunteerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Center(
        child: Text(
          "This is your volunteerEthiopia profile.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp.router(
    routerDelegate: GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => VolunteerHomePage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => VolunteerProfilePage(),
        ),
        // Add more routes as needed
      ],
    ).routerDelegate,
    routeInformationParser: GoRouter().routeInformationParser,
  ));
}
