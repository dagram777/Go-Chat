import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(VolunteerEthiopia());
}

class VolunteerEthiopia extends StatelessWidget {
  VolunteerEthiopia({Key? key}) : super(key: key);

  final _router = GoRouter(
    initialLocation: '/posts',
    routes: [
      GoRoute(
        path: '/posts',
        name: 'home',
        builder: (context, state) => MyHomePage(),
        routes: [
          GoRoute(
            path: ':id',
            name: "post-detail",
            builder: (context, state) {
              final pid = int.parse(state.params['id']!);
              return PostDetail(id: pid);
            },
          ),
          GoRoute(
            path: 'donate/:post',
            name: 'donate',
            builder: (context, state) {
              final pid = int.parse(state.params['id']!);
              final post = state.params['post']!;
              return VolunteerScreen(pid: pid, post: post);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/thanks',
        name: 'thankYou',
        builder: (context, state) => ThankYouScreen(),
      ),
      GoRoute(
        path: '/create-post',
        name: 'create-post',
        builder: (context, state) => CreateCampaign(),
      ),
      GoRoute(
        path: '/users-list',
        name: 'ListOfUsers',
        builder: (context, state) => ListUsers(),
      ),
      GoRoute(
        path: '/posts-list',
        name: 'ListOfPosts',
        builder: (context, state) => ListPosts(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'edit-post',
            builder: (context, state) {
              final pid = int.parse(state.params['id']!);
              return UpdateCampaign(id: pid);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/signup',
        name: 'register',
        builder: (context, state) => Register(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => Profile(),
        routes: [
          GoRoute(
            path: 'volunteers',
            name: 'myVolunteers',
            builder: (context, state) {
              return ListVolunteers();
            },
          ),
          GoRoute(
            path: ':id',
            name: 'edit-volunteer',
            builder: (context, state) {
              final vid = int.parse(state.params['id']!);
              return UpdateVolunteerScreen(volunteerId: vid);
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Volunteer Ethiopia',
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to Volunteer Ethiopia!'),
      ),
    );
  }
}

class PostDetail extends StatelessWidget {
  final int id;

  PostDetail({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Center(
        child: Text('Post ID: $id'),
      ),
    );
  }
}

class VolunteerScreen extends StatelessWidget {
  final int pid;
  final String post;

  VolunteerScreen({required this.pid, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer for $post'),
      ),
      body: Center(
        child: Text('Volunteer Screen for Post ID: $pid'),
      ),
    );
  }
}

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Text('Thank you for your support!'),
      ),
    );
  }
}

class CreateCampaign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Campaign'),
      ),
      body: Center(
        child: Text('Create a new campaign here.'),
      ),
    );
  }
}

class ListUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users'),
      ),
      body: Center(
        child: Text('Displaying list of users.'),
      ),
    );
  }
}

class ListPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Posts'),
      ),
      body: Center(
        child: Text('Displaying list of posts.'),
      ),
    );
  }
}

class UpdateCampaign extends StatelessWidget {
  final int id;

  UpdateCampaign({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Campaign'),
      ),
      body: Center(
        child: Text('Update campaign with ID: $id'),
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login screen'),
      ),
    );
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Text('Registration screen'),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('User Profile'),
      ),
    );
  }
}

class ListVolunteers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Volunteers'),
      ),
      body: Center(
        child: Text('Displaying my volunteers.'),
      ),
    );
  }
}

class UpdateVolunteerScreen extends StatelessWidget {
  final int volunteerId;

  UpdateVolunteerScreen({required this.volunteerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Volunteer'),
      ),
      body: Center(
        child: Text('Update volunteer with ID: $volunteerId'),
      ),
    );
  }
}
