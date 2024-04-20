import 'dart:io';
import 'package:flutter/material.dart';

class VolunteerContainer extends StatelessWidget {
  File imageFile;
  int goal;
  int? raised;
  String title;
  int? volunteerCount;
  DateTime created;

  VolunteerContainer({
    required this.imageFile,
    required this.goal,
    this.raised,
    required this.created,
    this.volunteerCount,
    required this.title,
  });

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
                  "http://192.168.56.1:3000/images/uploaded/${imageFile.uri.toString().split("/").last}",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  child: Icon(Icons.timelapse_rounded),
                ),
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
                    child: Text(
                      '${volunteerCount.toString()}+ people volunteered',
                    ),
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
                      'Goal: ${goal.toString()} birr',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Raised ${raised.toString()} birr (${((raised! / goal) * 100).floor()}%)',
                      style: TextStyle(
                        color: Colors.green[700],
                 
