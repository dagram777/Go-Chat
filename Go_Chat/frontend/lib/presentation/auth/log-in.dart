import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:volunteer_ethiopia_mobile/application/auth/login/bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/auth/login/shared_preferences.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
        title: Text("Login"),
        // centerTitle: true,
        
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.blue,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/donate.jpg"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Login ",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            SingleChildScrollView(
              child: Container(
                // height: 1500,
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 250,
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.green),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  label: Text("Email"),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: (username) {
                                  if (username == null ||
                                      !(username.contains('@') ||
                                          username.contains('.'))) {
                                    return "invalid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  //  BlocProvider.of<PassBloc>(context)
                                  //      .isObscure,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.red),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    labelStyle: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    label: Text("Password"),
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length < 8) {
                                      return 'minimum password length 8 ';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed('register');
                      },
                      child: Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listenWhen: (_, current) {
                        return current is LoginSuccesful;
                      },
                      listener: (_, LoginState state) {
                      context.goNamed("home");
                      },
                      builder: (_, LoginState state) {
                        Widget buttonChild = Text("Login");
                        if (state is Logingin) {
                          buttonChild = Text("Loging in ...");
                        } else if (state is LoginFailed) {
                          buttonChild = Text(
                            "Login Failed",
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return ElevatedButton(
                          onPressed: state is Logingin
                              ? null
                              : () {
                                  final formstate =
                                      formKey.currentState!.validate();
                                  if (!formstate) return;
                                  final loginBloc =
                                      BlocProvider.of<LoginBloc>(context);
                                  loginBloc.add(LoginEvent(emailController.text,
                                      passwordController.text));
                                },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              fixedSize: Size(200, 20)),
                          child: buttonChild,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
