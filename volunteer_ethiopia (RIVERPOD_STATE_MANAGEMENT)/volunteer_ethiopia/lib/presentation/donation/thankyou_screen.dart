import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/login/shared_preferences.dart';

class Thankyou_Screen extends StatelessWidget {
  final SharedPreference sharedPreference = SharedPreference();
  String name = "this donation";
  String num = "100";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          
          appBar: AppBar(
            // leading: Icon(Icons.drafts),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
            // backgroundColor: Color.fromARGB(68, 255, 255, 255),
            title: Text("Thank you"),
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
          drawer: MyDrawer(),
          body: ListView(
            children: [
              Column(
                  // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/thankyou.png"),
                              fit: BoxFit.contain)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 20),
                      child: Text(
                        "You have successfully donated thank you"
                         ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              primary: Colors.green),
                          child: Text("Return Home"),
                          onPressed: () {
                            context.go('/posts');
                          },
                        ),
                      ),
                    )
                  ]),
            ],
          ),
        ));
  }
}
