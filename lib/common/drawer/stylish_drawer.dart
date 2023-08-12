import 'package:eco_synergy/constants/constants.dart';
import 'package:eco_synergy/constants/utils.dart';
import 'package:eco_synergy/features/auth/screens/login/screens/login_screen.dart';
import 'package:eco_synergy/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Widget buildstylishDrawer(BuildContext context) {
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
                        'https://d112y698adiu2z.cloudfront.net/photos/production/challenge_thumbnails/002/491/831/datas/original.png'),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${userName}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${userName}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, HomeScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            InkWell(
              onTap: () {
                firebaseAuth.signOut();
                moveScreen(context, SigninScreen());
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  "LogOut",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  firebaseAuth.signOut();
                  moveScreen(context, SigninScreen());
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
