import 'package:flutter/material.dart';
import 'package:eco_synergy/constants/constants.dart';
import 'package:eco_synergy/constants/utils.dart';
import 'package:eco_synergy/features/auth/screens/login/screens/login_screen.dart';
import 'package:eco_synergy/features/home/screens/home_screen.dart';
import 'package:eco_synergy/features/onboarding/screens/onboarding_screen.dart';

Widget buildStylishDrawer(BuildContext context) {
  final Color primaryGreen = Color.fromARGB(255, 170, 198, 241);
  final Color secondaryGreen = Color.fromARGB(255, 129, 115, 207);
  final Color headerGreen = Color.fromARGB(255, 74, 68, 248);

  return Drawer(
    child: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryGreen,
                secondaryGreen,
              ],
            ),
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              decoration: BoxDecoration(
                color: headerGreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://d112y698adiu2z.cloudfront.net/photos/production/challenge_thumbnails/002/022/473/datas/original.png'),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Armaan",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "armaan33000@gmail.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Colors.white), // Use a custom icon here
              title: Text("Home",
                  style:
                      TextStyle(color: Colors.white)), // Change the font here
              onTap: () =>
                  moveScreen(context, HomeScreen()), // Add an animation here
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: Colors.white), // Use a custom icon here
              title: Text("Profile",
                  style:
                      TextStyle(color: Colors.white)), // Change the font here
              onTap: () {}, // Add an animation here
            ),
            Divider(color: Colors.white),
            InkWell(
              onTap: () {}, // Add an animation here
              child: ListTile(
                // Use a custom widget here
                leading: Icon(Icons.exit_to_app,
                    color: Colors.white), // Use a custom icon here
                title: Text("Log Out",
                    style:
                        TextStyle(color: Colors.white)), // Change the font here
                onTap: () {}, // Add an animation here
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
