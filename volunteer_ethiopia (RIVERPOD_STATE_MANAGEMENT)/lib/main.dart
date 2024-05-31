import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/auth/login/bloc.dart';
import 'lib.dart';
import 'presentation/donation/update_donation_screen.dart';

late final SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();

  runApp(Gada());
}

class Gada extends StatelessWidget {
  Gada({Key? key}) : super(key: key);
  // final postRepo = PostRepository(dataProvider: dataProvider)
  final _router = GoRouter(initialLocation: '/posts', routes: [
    GoRoute(
        path: '/posts',
        name: 'home',
        builder: (context, state) => MyHomePage(),
        routes: [
          GoRoute(
              path: ':id',
              name: "post-detail",
              builder: (context, state) {
                final pid = int.parse(state.params['id']!);
                return PostDetail(id: pid);
              },
              routes: [
                GoRoute(
                  path: 'donate/:post',
                  name: 'donate',
                  builder: (context, state) {
                    final pid = (int.parse(state.params['id']!));
                    final post = state.params['post']!;
                    return Donation_screen(pid: pid, post: post);
                  },
                )
              ]),
        ]),
    GoRoute(
        path: '/thanks',
        name: 'thankYou',
        builder: (context, state) => Thankyou_Screen()),
    GoRoute(
        path: '/create-post',
        name: 'create-post',
        builder: (context, state) => CreateCampaign()),
    GoRoute(
        path: '/users-list',
        name: 'ListOfUsers',
        builder: (context, state) => ListUsers()),
    GoRoute(
        path: '/posts-list',
        name: 'ListOfPosts',
        builder: (context, state) => ListPosts(),
        routes: [
          GoRoute(
              path: ':id',
              name: 'edit-post',
              builder: (context, state) {
                final pid = int.parse(state.params['id']!);
                return UpdateCampaign(
                  id: pid,
                );
              })
        ]),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/signup',
      name: 'register',
      builder: (context, state) => Register(),
    ),
    GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => Profile(),
        routes: [
          GoRoute(
              path: 'donations',
              name: 'myDonations',
              builder: (context, state) {
                var theid = 1;
                var obj = pref.getString("email");
                if (obj != null) {
                  var mem = json.decode(obj.toString());
                  theid = mem['id'];
                }
                return ListDonations(
                  id: theid,
                );

                //the _dependents.isEmpty
              },
              routes: [
                GoRoute(
                    path: ':id',
                    name: 'edit-donation',
                    builder: (context, state) {
                      final did = int.parse(state.params['id']!);
                      return Update_Donation_Screen(
                        donationId: did,
                      );
                    })
              ]
              
              ),
        ]),
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => (CampaignBloc(
              postRepository: PostRepository(
                dataProvider: PostDataProvider(
                  request: MultipartRequest(
                      "Post", Uri.parse('http://192.168.56.1:3000/posts')),
                  // "Post", Uri.parse('http://192.168.56.1:3000/posts')),
                  client: Client(),
                ),
              ),
            )),
          ),
          BlocProvider(
              create: (BuildContext context) => RegBloc(
                  userRepository: UserRepository(
                      dataProvider: UserDataProvider(client: Client())))),
          BlocProvider(
              create: (BuildContext context) => LoginBloc(
                  userRepository: UserRepository(
                      dataProvider: UserDataProvider(client: Client())))),
          BlocProvider(create: (BuildContext context) => PassBloc()),
          BlocProvider(
              create: (BuildContext context) => UserDonationBloc(
                    donationRepo: DonationRepository(
                        dataProvider: DonationDataProvider(client: Client())),
                  )),
          BlocProvider(
              create: (BuildContext context) => AdminBloc(
                  postRepo: PostRepository(
                      dataProvider: PostDataProvider(
                          request: MultipartRequest("Post",
                              Uri.parse('http://192.168.56.1:3000/posts')),
                          client: Client())),
                  userRepo: UserRepository(
                      dataProvider: UserDataProvider(client: Client())))),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Gada Ethipoia',
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
        ));
  }
}
