import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/registration/bloc.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class Register extends StatelessWidget {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool _isObscure = true;
  final SharedPreference sharedPreference = SharedPreference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.drafts),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child:Icon(Icons.arrow_back),
          onTap:(){
            context.goNamed("home");
          }
        ),
        foregroundColor: Colors.black,
        // backgroundColor: Color.fromARGB(68, 255, 255, 255),
        title: Text("Register"),
        // centerTitle: true,
        
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
            SizedBox(
              height: 5,
            ),
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/health2.png"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "Join GADA ",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //      topRight: Radius.elliptical(200,100),
                  //  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0),
                                  labelText: "First Name",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This filed can not be empty';
                                  } else if (value.contains(' ')) {
                                    return 'Please use alphabetic letters only ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: lastnameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0),
                                  labelText: "Last Name",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: (){},
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "joinus@gada.com",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0),
                                  labelText: "E-Mail",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field can not be empty ';
                                  } else if (!((value.contains('@') &&
                                      value.contains('.')))) {
                                    return 'Invalid E-MAIL';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: newPasswordController,
                                obscureText: true,
                                // BlocProvider.of<PassBloc>(context)
                                //     .isObscure,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0),
                                  labelText: "New Password",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 8) {
                                    return 'minimum password length 8 ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 275,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                obscureText: true,
                                // BlocProvider.of<PassBloc>(context)
                                //     .isObscure,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0),
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 8) {
                                    return 'minimum password length 8 ';
                                  } else if (newPasswordController.text !=
                                      confirmPasswordController.text) {
                                    return 'Unmatching confirmation password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                  onTap: () {
                                    context.pushNamed('login');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(115,8,8,10),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                            BlocConsumer<RegBloc, RegState>(
                              listenWhen: (_, current) {
                                return current is Registerd;
                              },
                              listener: (_, RegState state) {
                                context.pushNamed("login");
                              },
                              builder: (_, RegState state) {
                                Widget buttonChild = Text("Register");
                                if (state is NoAttempt) {
                                  buttonChild = Text(
                                    "Register",
                                  );
                                }
                                if (state is Registration) {
                                  buttonChild = Text("Registering");
                                }
                                if (state is NotRegisterd) {
                                  buttonChild = Text(
                                    "Registration Failed",
                                    style: TextStyle(color: Colors.red),
                                  );
                                }

                                return ElevatedButton(
                                  onPressed: state is Registration
                                      ? null
                                      : () {
                                          final formValid =
                                              formKey.currentState!.validate();
                                          if (!formValid) return;
                                          final regbloc =
                                              context.read<RegBloc>();
                                          regbloc.add(RegEvent(
                                              firstnameController.text,
                                              lastnameController.text,
                                              emailController.text,
                                              newPasswordController.text));
                                        },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    fixedSize: Size(275, 20),
                                  ),
                                  child: buttonChild,
                                );
                              },
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
