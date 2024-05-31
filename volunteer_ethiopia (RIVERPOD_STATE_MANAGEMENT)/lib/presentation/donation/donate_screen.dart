import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../application/auth/login/shared_preferences.dart';

class Donation_screen extends StatelessWidget {
  final donationBloc = DonationBloc(
      donationRepo: DonationRepository(
          dataProvider: DonationDataProvider(client: Client())));
  final int pid;
  final String post;
  Donation_screen({Key? key, required this.post, required this.pid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => donationBloc,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DonationScafold(pid, jsonDecode(post))),
    );
  }
}

class DonationScafold extends StatelessWidget {
  final SharedPreference sharedPreference = SharedPreference();
  final post;
  final int post_id;

  final formKey = GlobalKey<FormState>();
  final creditController = TextEditingController();
  final amountController = TextEditingController();

  DonationScafold(this.post_id, this.post, {Key? key}) : super(key: key);

  // final postt = jsonDecode(post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.drafts),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        // backgroundColor: Color.fromARGB(68, 255, 255, 255),
        title: Text("Home"),
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
                                    "http://192.168.56.1:3000/images/uploaded/${post['image'].split('/').last.split("'").first}"),
                                fit: BoxFit.cover)),
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
                              color: Colors.white),
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
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.blue),
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
                  "Donation Amount",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    validator: (String? amount) {
                      if (amount == null || amount.isEmpty) {
                        return "field is empty";
                      }
                      if (double.tryParse(amount) == null) {
                        return "amount must be number";
                      }
                      if (double.tryParse(amount)! < 10) {
                        return "donation amount must be atleast 10";
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
                  child: BlocConsumer<DonationBloc, DonationStates>(
                    listenWhen: (p, c) {
                      return c is DonationSuccessfull;
                    },
                    listener: (_, DonationStates state) {
                      context.pushNamed('thankYou');
                    },
                    builder: (_, DonationStates state) {
                      Widget buttonChild = const Text("Donate");

                      if (state is Donating) {
                        buttonChild = const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }

                      if (state is DonationSuccessfull) {
                        buttonChild = const Text("Donation Successful");
                      }

                      if (state is DonationFailed) {
                        buttonChild = const Text("Donation failed retry");
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            primary: Colors.green),
                        onPressed: state is Donating
                            ? null
                            : () async {
                                if ((await sharedPreference.isEmpty())) {
                                  return context.pushNamed("login");
                                }

                                final formValid =
                                    formKey.currentState!.validate();

                                if (!formValid) return;
                                var obj = await sharedPreference.getCatch();

                                if (obj == null) {
                                  return context.pushNamed("login");
                                }
                                // var mem = (jsonDecode());
                                var mem = json.decode(obj.toString());

                                print(mem);

                                final authBloc =
                                    BlocProvider.of<DonationBloc>(context);
                                authBloc.add(
                                  Donate(
                                    creditController.text.toString(),
                                    int.parse(amountController.text.toString()),
                                    mem['id'],
                                    post_id,
                                  ),
                                );
                              },
                        child: buttonChild,
                      );
                    },
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
