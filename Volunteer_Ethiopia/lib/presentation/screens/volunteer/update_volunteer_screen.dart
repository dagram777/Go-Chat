import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateVolunteerScreen extends StatelessWidget {
  final int volunteerId;

  const UpdateVolunteerScreen({Key? key, required this.volunteerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController creditController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    int postId = 0;
    int userId = 0;
    Widget body;

    // Fetch volunteer details on screen initialization
    // BlocProvider.of<UserVolunteerBloc>(context)
    //     .add(GetVolunteerUpdatedEvent(id: volunteerId));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Volunteer",
            style: TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
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
              icon: const Icon(Icons.add),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed('profile');
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
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: creditController,
                  decoration: InputDecoration(
                    labelText: 'Credit card number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter credit card number";
                    }
                    final creditCardTest = RegExp('[0-9]');
                    if (!creditCardTest.hasMatch(value)) {
                      return "Credit card number can only be digits";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is empty";
                    }
                    if (double.tryParse(value) == null) {
                      return "Amount must be a number";
                    }
                    if (double.parse(value) < 10) {
                      return "Volunteer amount must be at least 10";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: null, // Placeholder for button onPressed
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
