
import 'package:flutter/material.dart';

import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';

import 'package:volunteer_ethiopia_mobile/lib.dart';

import 'package:go_router/go_router.dart';


class Profile extends StatelessWidget {
  final SharedPreference sharedPreference = SharedPreference();
  bool isEnabled = false;
  // String profile_name;
  List<Information> details = [
    Information(
        icon: Icon(
          Icons.support,
          color: Colors.green,
        ),
        title: Text(
          "Donation",
          style: TextStyle(fontSize: 18.7),
        ),
        goto: "myDonations"),
    //  Information(icon: Icon(Icons.edit_note, color: Colors.purple,) , title: Text("List of Posts",style: TextStyle(fontSize: 18.7),), goto: "ListOfPosts"),
    Information(
        icon: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: Text(
          "Logout",
          style: TextStyle(fontSize: 18.7, color: Colors.red),
        ),
        goto: "login"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.drafts),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          onTap:(){
            context.goNamed("home");
          },
          child: Icon(Icons.arrow_back),),
        // backgroundColor: Color.fromARGB(68, 255, 255, 255),
        title: Text("Profile"),
        // centerTitle: true,
        
      ),
      drawer:  MyDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(60, 30),
                          topRight: Radius.elliptical(60, 30)),
                    ),
                    padding: EdgeInsets.only(top: 90),
                    child: ListView.builder(
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: ListTile(
                            onTap: () {
                              print(index);
                              if (index == 1) {
                                sharedPreference.removeCatch("email");
                                sharedPreference.clearup();
                              }

                              context.goNamed(details[index].goto);
                            },
                            title: details[index].title,
                            leading: details[index].icon,
                            trailing: Icon(Icons.arrow_forward_ios_sharp),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 135,
            right: MediaQuery.of(context).size.width *
                (0.5 - (60 / MediaQuery.of(context).size.width)),
            child: Container(),
          ),
          Positioned(
            top: 260,
            right: 0,
            left: 0,
            child: Container(),
          ),
          Positioned(top: 200, right: 0, left: 60, child: Container()),
        ],
      ),
    );
  }
}
