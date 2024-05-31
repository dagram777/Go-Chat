import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';

import 'package:volunteer_ethiopia_mobile/lib.dart';

import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();
  @override
  Widget build(BuildContext context) {
    var launch = BlocProvider.of<CampaignBloc>(context);
    launch.add(GetPosts());
    var myListDict = [];
    List<Widget> postsList = [];
    // final String cache = jsonDecode(sharedPreference.getCatch().toString());
    dynamic icon = SizedBox(
      width: 0.001,
    );
    var obj = pref.getString("email");
    if (obj != null) {
      var mem = json.decode(obj.toString());

      if (mem["is_client"] == true || mem["is_admin"] == true) {
        icon = Icon(Icons.add);
      }
    }

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        // leading: Icon(Icons.drafts),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        // backgroundColor: Color.fromARGB(68, 255, 255, 255),
        title: Text("Home"),
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
              if (obj != null) {
                var mem = json.decode(obj.toString());

                print(mem);

                if (mem["is_client"] == true || mem["is_admin"] == true) {
                  context.pushNamed('create-post');
                } else {
                  context.pushNamed('login');
                }
              }
            },
            icon: icon,
          ),
          GestureDetector(
            onTap: () async {
              var obj = await sharedPreference.getCatch();
              print(json.decode(obj.toString()));
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
      body: SingleChildScrollView(
        child: BlocConsumer<CampaignBloc, CampaignState>(
            listener: ((_, state) {}),
            builder: (_, state) {
              // if (statee) {
              //   var launch = BlocProvide is LoadingHomr.of<CampaignBloc>(context);
              //   launch.add(GetPosts());
              // }
              if (state is LoadFailed) {
                return Center(
                  child: Image(image: AssetImage('assets/ngoImage.png')),
                );
              }
              if (state is LoadSuccess) {
                for (var post in state.posts) {
                  postsList.add(GestureDetector(
                    onTap: () {
                      context.pushNamed('post-detail',
                          params: {'id': post.id.toString()});
                    },
                    child: MyContainer(
                        pic: post.image,
                        goal: post.goal,
                        raised: post.donated,
                        created: post.created,
                        donatorCount: post.donator_count,
                        title: post.title),
                  ));
                  myListDict.add(post);
                }
                myListDict = myListDict.reversed.toList();

                // postsList = MyContainer(pic: pic, goal: goal, raised: raised, category: category, created: created, donatorCount: donatorCount, title: title);
                return Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'User, Welcome to Gada',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: Text(
                      'Trending Campaigns',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    width: double.maxFinite,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: myListDict.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            context.goNamed('post-detail', params: {
                              'id': myListDict[index].id.toString()
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 300,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "http://192.168.56.1:3000/images/uploaded/${myListDict[index].image.uri.toString().split("/").last}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Total Raised'),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          myListDict[index].donated.toString() +
                                              ' birr(' +
                                              ((myListDict[index].donated! /
                                                          myListDict[index]
                                                              .goal) *
                                                      100)
                                                  .floor()
                                                  .toString() +
                                              '%)',
                                          style: TextStyle(
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'All Campaigns',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: postsList,
                  )
                ]);
              } else {
                return Container(
                    height: 500,
                    child: Center(
                      child: ElevatedButton(
                          child: Text("Reload"),
                          onPressed: () {
                            context.goNamed('home');
                          }),
                    ));
              }
            }),
      ),
    );
  }
}
