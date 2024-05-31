

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/login/shared_preferences.dart';
import '../../lib.dart';
import 'package:volunteer_ethiopia_mobile/application/post/campaign_state.dart';
import 'package:go_router/go_router.dart';

class ListDonations extends StatelessWidget {

  final int id;
  const ListDonations({Key? key, required this.id}) : super(key: key);


  Widget _buildPopup(BuildContext context, id) {
    return BlocConsumer<UserDonationBloc, UserDonationState>(
        builder: (context, state) {
          Widget child;
          Widget wholeChild;
           if(state is DeletingDonationState) {
            child = Text("yes");
            wholeChild = CircularProgressIndicator();
          }else if(state is DeleteDonationFailed) {
            child = Text("Failed retry");
            wholeChild = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Are you sure you want to delete this donation?"),
              ],
            );
          } else {
            child = Text("Yes");
            wholeChild = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Are you sure you want to delete this donation?"),
              ],
            );
          } ;
          return AlertDialog(
            title: const Text('Delete donation'),
            content: wholeChild,
            actions: [
              TextButton(
                onPressed: () {
                  try {
                    BlocProvider.of<UserDonationBloc>(context)
                        .add(DeleteDonationEvent(id: id));
                    context.pushNamed('myDonations');
                  } catch (e) {
                    print(e);
                  }
                  // context.pushNamed('listOfPosts');
                },
                child: child,
              ),
              TextButton(
                  onPressed: () {
                    context.pushNamed('myDonations');
                    // Navigator.of(context).pop();
                  },
                  child: const Text("No"))
            ],
          );
        },
        listener: (_, __) {});
  }

  @override
  Widget build(BuildContext context) {
    final post = BlocProvider.of<UserDonationBloc>(context);
    post.add(GetUserDonation(id: id));
    Widget scafoldBody;
    return Scaffold(
        appBar: AppBar(
            title: const Text("List of Donations"),
            leading: GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  context.goNamed('home');
                })),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return BlocConsumer<UserDonationBloc, UserDonationState>(
                listener: (_, state) => {
                      if (state is DeleteSuccess) {context.pushNamed("home")}
                    },
                builder: (_, state) {
                  if (state is GettingUserDonationState) {
                    scafoldBody = Center(child: CircularProgressIndicator());
                  } else if (state is GetUserDonationSuccessfull) {
                    print(state);
                    final donations = state.donations;
                    scafoldBody = ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: donations.length > 0 ? donations.length : 1,
                      itemBuilder: (_, index) => donations.length > 0
                          ? Card(
                              child: ListTile(
                                  onTap: () {
                                    context.pushNamed('edit-donation',params: {'id':donations[index].id.toString()});
                                  },
                                  subtitle: Text(
                                      "Amout: ${donations[index].donated_amount}"),
                                  trailing: GestureDetector(
                                    child: const Icon(
                                      Icons.delete,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: _,
                                          builder: (_) => _buildPopup(
                                              context, donations[index].id));
                                    },
                                  ),
                                  title: Text(donations[index].account_number)),
                            )
                          : Center(
                              child: Image(
                                  image: AssetImage('assets/donate.jpg'))),
                    );
                  } else if (state is GetUserDonationFailed) {
                    scafoldBody = Center(child: Text("Failed."));
                  } else {
                    scafoldBody = Center(
                      child: Text("Error while fetching data"),
                    );
                  }

                  return scafoldBody;
                });
          },
        ));
  }

}
