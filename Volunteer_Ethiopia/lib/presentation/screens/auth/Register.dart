import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Register extends StatelessWidget {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            context.goNamed("home");
          },
        ),
        foregroundColor: Colors.black,
        title: Text("Register"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/health2.png"),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                "Join volunteerEthiopia",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: firstnameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                  labelText: "First Name",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field cannot be empty';
                                  } else if (value.contains(' ')) {
                                    return 'Please use alphabetic letters only';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: lastnameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                  labelText: "Last Name",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "joinus@volunteerEthiopia.com",
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                  labelText: "E-Mail",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field cannot be empty';
                                  } else if (!(value.contains('@') && value.contains('.'))) {
                                    return 'Invalid E-Mail';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: newPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                  labelText: "New Password",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 8) {
                                    return 'Minimum password length is 8 characters';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 8) {
                                    return 'Minimum password length is 8 characters';
                                  } else if (newPasswordController.text != confirmPasswordController.text) {
                                    return 'Passwords do not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                context.pushNamed('login');
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(115, 8, 8, 10),
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 275,
                              child: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  fixedSize: Size(275, 20),
                                ),
                                child: Text("Register"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
