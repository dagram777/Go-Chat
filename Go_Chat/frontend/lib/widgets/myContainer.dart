import 'dart:io';

import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  File pic;
  int goal;
  int? raised;
  String title;
  int? donatorCount;
  DateTime created;
  MyContainer(
      {required this.pic,
      required this.goal,
      this.raised,
      required this.created,
      this.donatorCount,
      required this.title});

  // Image convertFileToImage(File picture) {
  // List<int> imageBase64 = picture.readAsBytesSync();
  // String imageAsString = base64Encode(imageBase64);
  // Uint8List uint8list = base64.decode(imageAsString);
  // Image image = Image.memory(uint8list);
  // return image;
// }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "http://192.168.56.1:3000/images/uploaded/${pic.uri.toString().split("/").last}"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 30,
            child: Stack(
              children: [
                const Positioned(top: 5, child: Icon(Icons.timelapse_rounded)),
                Positioned(
                  left: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(created.toString()),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(donatorCount.toString() + '+ person donated'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Goal: ' + goal.toString() + ' birr',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Raised ' +
                          raised.toString() +
                          ' birr(' +
                          ((raised! / goal) * 100).floor().toString() +
                          '%)',
                      style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
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
