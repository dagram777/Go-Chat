import 'package:flutter/material.dart';
import 'package:VolunteerEthiopia_mobile/lib.dart';
import 'package:go_router/go_router.dart';

class VolunteerPostDetail extends StatelessWidget {
  final int id;
  VolunteerPostDetail({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.goNamed('home');
          },
          child: Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        title: Text('Post Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://192.168.56.1:3000/images/uploaded/post_image.jpg", // Replace with actual image URL
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Created X days ago', // Update with actual creation date
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Post Title',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'X people volunteered so far.', // Update with actual number of volunteers
                style: TextStyle(fontSize: 13, color: Colors.green),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goal: X birr', // Update with actual goal amount
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Text(
                    'Raised: X birr', // Update with actual raised amount
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 20),
              Text(
                'Organizer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Organizer Name'),
                      SizedBox(height: 5),
                      Text(
                        'Organizer Location',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consequat enim eget urna rhoncus, a fringilla eros tincidunt. Integer et nulla nec leo ultrices tempus. Vivamus hendrerit scelerisque ante, non vulputate magna efficitur in.',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle button press here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  fixedSize: Size(double.infinity, 40),
                ),
                child: Text(
                  'Volunteer Now',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
