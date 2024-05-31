
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import '../../application/admin/admin.dart';
import '../../widgets/search_delegate.dart';



class ListUsers extends StatelessWidget {
  ListUsers({Key? key}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();
  Widget _buildPopup(BuildContext context, id) {
    return AlertDialog(
      title: const Text('Delete Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Are you sure you want to delete this User?"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
           
              BlocProvider.of<AdminBloc>(context).add(DeleteUser(id));
            
            context.goNamed('home');
          },
          child: const Text('Yes'),
        ),
        TextButton(
            onPressed: () {
              context.pushNamed('listOfUsers');
              // Navigator.of(context).pop();
            },
            child: const Text("No"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = BlocProvider.of<AdminBloc>(context);
    post.add(LoadUsers());
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.drafts),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
           leading: GestureDetector(
                onTap:(){
                  context.goNamed('home');

                },
                child: Icon(Icons.arrow_back),),
          // backgroundColor: Color.fromARGB(68, 255, 255, 255),
          title: Text("List of users"),
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
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
            listener: (_, state) => {
                  if (state is DeleteSuccess) {context.pushNamed("home")}
                },
            builder: (_, state) {
              if (state is Loading) {
                var post = BlocProvider.of<AdminBloc>(context);
                post.add(LoadUsers());
              }

              if (state is UsersLoaded) {
                final posts = state.users;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: posts.length > 0 ? posts.length : 1,
                  itemBuilder: (_, index) => posts.length > 0
                      ? Card(
                          child: ListTile(
                              onTap: () {},
                              subtitle: Text("Goal: ${posts[index].first_name}"),
                              trailing: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                ),
                                onTap: () async {
                                  var obj = await sharedPreference.getCatch();
                                  if (obj != null) {
            // var mem = (jsonDecode());
            var mem = json.decode(obj.toString());

            print(mem);
            if (await sharedPreference.isEmpty()) {
              return null;
            }
            if (mem["is_admin"] != true) {

              context.goNamed('home');
            }}
          
                                  showDialog(
                                     
          
                                      context: _,
                                      builder: (_) => _buildPopup(
                                          context, posts[index].id));
                                },
                              ),
                              title: Text(posts[index].email)),
                        )
                      : Center(
                          child: Image(image: AssetImage('assets/donate.jpg'))),
                );
              } else if (state is UsersLoadFailure) {
                return Center(child: Text("Failed."));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

