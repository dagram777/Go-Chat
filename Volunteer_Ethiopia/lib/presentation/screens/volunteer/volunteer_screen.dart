import 'package:flutter/material.dart';
import 'package:VolunteerEthiopia_mobile/lib.dart';
import 'package:go_router/go_router.dart';

class VolunteerScreen extends StatelessWidget {
  final int postId;
  final String postJson;

  VolunteerScreen({Key? key, required this.postJson, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VolunteerScaffold(postId, postJson),
    );
  }
}

class VolunteerScaffold extends StatelessWidget {
  final post;
  final int postId;

  final formKey = GlobalKey<FormState>();
  final creditController = TextEditingController();
  final amountController = TextEditingController();

  VolunteerScaffold(this.postId, this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.pushNamed('create-post');
            },
            icon: Icon(Icons.add),
          ),
          GestureDetector(
            onTap: () {
              context.push('/profile');
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
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  alignment: AlignmentDirectional.topCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "http://192.168.56.1:3000/images/uploaded/${post['image'].split('/').last.split("'").first}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${post['title']}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Credit card",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFormField(
                    controller: creditController,
                    decoration: InputDecoration(
                      labelText: 'Credit card number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (String? creditCardNo) {
                      if (creditCardNo == null || creditCardNo.isEmpty) {
                        return "Enter credit card number";
                      }
                      final creditCardTest = RegExp('[0-9]');
                      if (creditCardTest.hasMatch(creditCardNo) == false) {
                        return "Credit card number can only be digits";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Volunteer Amount",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (String? amount) {
                      if (amount == null || amount.isEmpty) {
                        return "Field is empty";
                      }
                      if (double.tryParse(amount) == null) {
                        return "Amount must be a number";
                      }
                      if (double.tryParse(amount)! < 10) {
                        return "Volunteer amount must be at least 10";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.green,
                    ),
                    onPressed: null, // No action defined
                    child: const Text("Volunteer"),
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
