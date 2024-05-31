import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_ethiopia_mobile/application/post/post.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/auth/login/shared_preferences.dart';

class CreateCampaign extends StatelessWidget {
  final SharedPreference sharedPreference = SharedPreference();
  CreateCampaign({Key? key}) : super(key: key);

  final form_key = GlobalKey<FormState>();
  final title_ct = TextEditingController();
  final description_ct = TextEditingController();
  final goal_ct = TextEditingController();
  final account_ct = TextEditingController();
  File? uploaded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.drafts),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        // backgroundColor: Color.fromARGB(68, 255, 255, 255),
        // title: Text("ጋዳ"),
        // centerTitle: true,
        
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {}) ,
      //   final posts3 = {
      //   'pic': 'profile_picture.jpg',
      //   'goal': 1000000,
      //   'raised': 40000,
      //   'title': 'fund the NGO',
      //   // 'category': 'NGO',
      //   'donatorCount': 37888,
      //   'created': '40 days'
      // };
      body: Center(
        child: Form(
          key: form_key,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: title_ct,
                    decoration: const InputDecoration(
                        hintText: "Title",
                        focusColor: Colors.green,
                        prefixIcon: Icon(Icons.title_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (String? title) {
                      if (title == null || title.isEmpty) {
                        return "Title is required!";
                      }
                      if (title.length > 100) {
                        return "Title Must be less than 100 characters!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: description_ct,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      focusColor: Colors.green,
                      // prefixIcon: Icon(Icons.title_sharp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (String? desc) {
                      if (desc == null || desc.isEmpty) {
                        return "Description is required!";
                      }
                      if (desc.length < 10) {
                        return "Minimum discription lengt of 10 letters!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: goal_ct,
                    decoration: const InputDecoration(
                        hintText: "Goal",
                        focusColor: Colors.green,
                        prefixIcon: Icon(Icons.sports_basketball_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (String? goal) {
                      if (goal == null || goal.isEmpty) {
                        return "Goal is required!";
                      }
                      if (int.parse(goal) < 50) {
                        return "Minimum amount 50";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  BlocConsumer<CampaignBloc, CampaignState>(
                    // builder: (_, CampaignState s) => Text("a"),
                    builder: (_, CampaignState state) {
                      Widget buttonState = const Text("Create");
                      Widget imagePlace = const Text("Choose an image");

                      if (state is CreatingPost) {
                        buttonState = const CircularProgressIndicator(
                          backgroundColor: Colors.green,
                          color: Colors.white,
                          strokeWidth: 3,
                        );
                      }
                      if (state is CreateSuccess) {
                        buttonState = const Text('Create Successful');
                      }
                      if (state is CreateFailed) {
                        buttonState = const Text(
                          "Create Faild",
                        );
                      }
                      if (state is PickSuccess || uploaded != null) {
                        imagePlace = Text("image Uploaded $uploaded");
                      }
                      if (state is PickFail) {
                        imagePlace = const Text("Image not uploaded");
                      }
                      return Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image == null) {
                                return;
                              }
                              uploaded = File(image.path);
                              final im = BlocProvider.of<CampaignBloc>(context);
                              im.add(PickImage(image: File(image.path)));
                            },
                            icon: const Icon(Icons.image_outlined),
                            label: imagePlace,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              if (state is CreatingPost) {
                                return;
                              }

                              final bool isValid =
                                  form_key.currentState!.validate();
                              if (isValid) {
                                final post =
                                    BlocProvider.of<CampaignBloc>(context);

                                post.add(CreatePost(
                                    title: title_ct.text,
                                    description: description_ct.text,
                                    goal: int.parse(goal_ct.text),
                                    image: File(uploaded!.path)));
                              } else {
                                return;
                              }
                            },
                            child: buttonState,
                          ),
                        ],
                      );
                    },
                    listenWhen: (previous, current) =>
                        (current is CreateSuccess),
                    listener: (_, CampaignState state) {
                      context.pushNamed('home');
                    },
                  ),

                  // TextFormField(),
                  // TextFormField(),
                  // TextFormField(),
                  //imagefield
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
