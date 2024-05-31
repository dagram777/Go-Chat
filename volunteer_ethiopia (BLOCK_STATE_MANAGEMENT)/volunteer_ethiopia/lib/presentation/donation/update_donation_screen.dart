import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';
import 'package:http/http.dart';

class Update_Donation_Screen extends StatelessWidget {
  final int donationId;
  const Update_Donation_Screen({Key? key, required this.donationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController creditController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    int postId = 0;
    int userId = 0;
    Widget body;
    BlocProvider.of<UserDonationBloc>(context)
        .add(GetDonationUpdatedEvent(id: donationId));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update donation",
            style: TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back_rounded)),
          foregroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegete());
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  context.pushNamed('create-post');
                },
                icon: const Icon(Icons.add)),
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
        body: BlocConsumer<UserDonationBloc, UserDonationState>(
          builder: ((_, state) {
            print(state);
            if (state is GettingDonationToUpdateState) {
              body = CircularProgressIndicator();
            } else if (state is GetDonationToUpdateFailedState) {
              body = Center(
                child: Text("Failed to get donation"),
              );
            } else {
              if (state is GetDonationToUpdateSuccessfullState) {
                creditController =
                    TextEditingController(text: state.donation.account_number);
                amountController = TextEditingController(
                    text: state.donation.donated_amount.toString());
                userId = state.donation.user;
                postId = state.donation.post;
              }
              body = Center(
                  child: Form(
                key: formKey,
                child: Column(children: [
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
                    child: BlocConsumer<UserDonationBloc, UserDonationState>(
                      listener: (_, state) {
                        if (state is UpdateDonationSuccessfull) {
                          context.goNamed("home");
                        }
                      },
                      builder: (_, UserDonationState state) {
                        Widget buttonChild = const Text("Update");

                        if (state is UpdatingDonationState) {
                          buttonChild = const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (state is UpdateDonationSuccessfull) {
                          buttonChild = const Text("Update Successful");
                        }

                        if (state is UpdateDonationFailed) {
                          buttonChild = const Text("Update failed retry");
                        }

                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              primary: Colors.green),
                          onPressed: state is UpdatingDonationState
                              ? null
                              : () {
                                  final formValid =
                                      formKey.currentState!.validate();
                                  if (!formValid) return;

                                  final authBloc =
                                      BlocProvider.of<UserDonationBloc>(
                                          context);
                                  authBloc.add(
                                    UpdateDonationEvent(
                                        donation: Donation(
                                            donated_amount: int.parse(
                                                amountController.text
                                                    .toString()),
                                            user: userId,
                                            post: postId,
                                            account_number: creditController
                                                .text
                                                .toString()),
                                        id: donationId),
                                  );
                                },
                          child: buttonChild,
                        );
                      },
                    ),
                  ),
                ]),
              ));
            }
            return body;
          }),
          listener: (_, __) {},
        ),
      ),
    );
  }
}
