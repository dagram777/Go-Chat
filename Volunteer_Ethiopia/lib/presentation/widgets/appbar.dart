import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VolunteerEthiopiaAppBar extends StatelessWidget {
  VolunteerEthiopiaAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            // Add logic for user authorization if needed
            // For example:
            // if (userIsAuthorized) {
            //   context.pushNamed('create-post');
            // } else {
            //   context.pushNamed('login');
            // }
            context.pushNamed('create-post'); // Example direct navigation
          },
          icon: Icon(Icons.add),
        ),
        GestureDetector(
          onTap: () {
            // Add logic for checking user authentication
            // For example:
            // if (userIsAuthenticated) {
            //   context.push('/profile');
            // } else {
            //   context.push('/login');
            // }
            context.push('/profile'); // Example direct navigation
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
            maxRadius: 20,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search result for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = ['Result 1', 'Result 2', 'Result 3'];

    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionsList[index]),
          onTap: () {
            query = suggestionsList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Center(
        child: Text('Create Post Screen'),
      ),
    );
  }
}
