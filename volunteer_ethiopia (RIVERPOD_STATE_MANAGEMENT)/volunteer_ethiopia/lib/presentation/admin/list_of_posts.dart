import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/admin/admin.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';

import 'package:volunteer_ethiopia_mobile/application/post/campaign_state.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/search_delegate.dart';

class ListPosts extends StatelessWidget {
  ListPosts({Key? key}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();
  Widget _buildPopup(BuildContext context, id) {
    return AlertDialog(
      title: const Text('Delete Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Are you sure you want to delete this post?"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            try {
              BlocProvider.of<AdminBloc>(context).add(DeletePost(id));
            } catch (e) {
              print(e);
            }
            // context.pushNamed('listOfPosts');
          },
          child: const Text('Yes'),
        ),
        TextButton(
            onPressed: () {
              context.pushNamed('listOfPosts');
              // Navigator.of(context).pop();
            },
            child: const Text("No"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = BlocProvider.of<AdminBloc>(context);
    post.add(LoadPost());
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
          title: Text("List of Posts"),
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
                post.add(LoadPost());
              }

              if (state is PostLoaded) {
                final posts = state.posts;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: posts.length > 0 ? posts.length : 1,
                  itemBuilder: (_, index) => posts.length > 0 ? Card(
                    child: ListTile(
                        onTap: () {
                          context.pushNamed('edit-post', params: {'id':posts[index].id.toString()});
                        },
                        subtitle: Text("Goal: ${posts[index].goal}"),
                        trailing: GestureDetector(
                          child: const Icon(
                            Icons.delete,
                          ),
                          onTap: () {
                            showDialog(
                                context: _,
                                builder: (_) =>
                                    _buildPopup(context, posts[index].id));
                          },
                        ),
                        title: Text(posts[index].title)),
                  ) : Center(child: Image(image: AssetImage('assets/creative2.png'))) ,
                );
              } else if (state is LoadFailed) {
                return Center(child: Text("Failed."));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
