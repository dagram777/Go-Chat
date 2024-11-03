import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:volunteer_ethiopia_mobile/lib.dart';

import 'package:go_router/go_router.dart';

import '../../application/auth/login/shared_preferences.dart';

class PostDetail extends StatelessWidget {
  final int id;
  PostDetail({Key? key, required this.id}) : super(key: key);
  final SharedPreference sharedPreference = SharedPreference();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampaignBloc, CampaignState>(
      builder: (_, CampaignState state) {
        if ((state is! LoadNotFail)) {
          final pos = BlocProvider.of<CampaignBloc>(context);
          pos.add(FindPost(id: id));
        }
        if (state is LoadNotFail) {
          return Scaffold(
            appBar: AppBar(
              // leading: Icon(Icons.drafts),
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
              leading: GestureDetector(
                  onTap: () {
                    context.goNamed('home');
                  },
                  child: Icon(Icons.arrow_back)),
              // backgroundColor: Color.fromARGB(68, 255, 255, 255),
              title: Text(state.post!.title),
              // centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MySearchDelegete());
                    },
                    // if(await jsonDecode(sharedPreference.getCatch().toString())['is_staff'] == true){}
                    icon: const Icon(Icons.search)),
                IconButton(
                  onPressed: () async {
                    var obj = await sharedPreference.getCatch();
                    print(json.decode(obj.toString()));
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
                  icon: Icon(Icons.add),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width,
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://192.168.56.1:3000/images/uploaded/${state.post!.image.path.split('/').last}"),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(children: [
                              Icon(
                                Icons.info_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Created ${(-state.post!.created.difference(DateTime.now()).inDays).toString()} days ago',
                                style: TextStyle(color: Colors.white),
                              )
                            ]))
                      ],
                    ),
                    Align(
                        heightFactor: 2,
                        alignment: Alignment.centerLeft,
                        child: Text(state.post!.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                    Align(
                        alignment: Alignment.centerLeft,
                        heightFactor: 2,
                        child: Text(
                          "${state.post!.donator_count} people donated so far.",
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        )),
                    // LinearPercentIndicator(
                    //   width: MediaQuery.of(context).size.width - 40,
                    //   animation: true,
                    //   lineHeight: 15.0,
                    //   animationDuration: 2500,
                    //   percent: 0.8,
                    //   center: const Text("80.0%"),
                    //   barRadius: const Radius.circular(10),
                    //   progressColor: Colors.green,
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Goal: ${state.post!.goal} birr",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          Text(
                            "Raised: ${state.post!.donated} birr",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    const Align(
                        heightFactor: 2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Organizer",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: CircleAvatar(
                              child: Icon(Icons.person),
                            )),
                        Column(
                          children: [
                            Text("MOnika Islam"),
                            SizedBox(height: 5),
                            Text(
                              "Dhaka Organir",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(children: [
                      Align(
                          heightFactor: 3,
                          alignment: Alignment.centerLeft,
                          child: Text("Description",
                              style: TextStyle(color: Colors.green))),
                      Text("${state.post!.description}")
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          fixedSize: const Size(1000, 40),
                        ),
                        onPressed: () {
                          if (pref.containsKey("email")) {
                            context.pushNamed('donate', params: {
                              'id': state.post!.id.toString(),
                              'post': state.post.toString()
                            });
                          } else {
                            context.pushNamed("login");
                          }
                        },
                        child: Text(
                          "Donate Now",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      listener: (context, state) {},
    );
  }
}
