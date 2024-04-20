import 'package:flutter/material';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  final List<Information> details = [
    Information(
      icon: Icon(
        Icons.support,
        color: Colors.green,
      ),
      title: Text(
        "Volunteer",
        style: TextStyle(fontSize: 18.7),
      ),
      goto: "myVolunteer",
    ),
    Information(
      icon: Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: Text(
        "Logout",
        style: TextStyle(fontSize: 18.7, color: Colors.red),
      ),
      goto: "login",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            context.goNamed("home");
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Profile"),
      ),
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
                        topRight: Radius.elliptical(60, 30),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 90),
                    child: ListView.builder(
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ListTile(
                            onTap: () {
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
        ],
      ),
    );
  }
}

class Information {
  final Icon icon;
  final Text title;
  final String goto;

  Information({
    required this.icon,
    required this.title,
    required this.goto,
  });
}
