// some functions

import 'package:eco_synergy/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void moveScreen(BuildContext context, Widget screenName,
    {bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screenName));
  } else {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screenName));
  }
}

Widget makeAppBar(BuildContext context, {String title = "$appName"}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    backgroundColor: Colors.grey.shade100,
    centerTitle: true,
  );
}
