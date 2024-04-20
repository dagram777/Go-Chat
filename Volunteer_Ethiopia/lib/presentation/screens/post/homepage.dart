import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final SharedPreference sharedPreference = SharedPreference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> myListDict = [];
    List<Widget> postsList = [];

    dynamic icon = SizedBox(width: 0.001);
    var obj = pref.getString("email");

    if (obj != null) {
      var mem = json.decode(obj.toString());

      if (mem["is_client"] == true || mem["is_admin"] == true) {
        icon = Icon(Icons.add);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              if (obj != null) {
                var mem = json.decode(obj.toString());

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
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'User, Welcome to volunteerEthiopia',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
              child: Text(
                'Trending Campaigns',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        'id': myListDict[index].id.toString(),
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
                                  "http://192.168.56.1:3000/images/uploaded/${myListDict[index].image.uri.toString().split("/").last}",
                                ),
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
                                const SizedBox(width: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${myListDict[index].donated.toString()} birr(${((myListDict[index].donated! / myListDict[index].goal) * 100).floor().toString()}%)',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
            const SizedBox(height: 5),
            const Text(
              'All Campaigns',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              children: postsList,
            ),
          ],
        ),
      ),
    );
  }
}


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }


class MyContainer extends StatelessWidget {
  final String pic;
  final int goal;
  final int raised;
  final DateTime created;
  final int donatorCount;
  final String title;

  const MyContainer({
    required this.pic,
    required this.goal,
    required this.raised,
    required this.created,
    required this.donatorCount,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Your custom container UI here
    );
  }
}
