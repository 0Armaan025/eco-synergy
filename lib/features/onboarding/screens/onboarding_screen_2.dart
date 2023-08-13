import 'package:eco_synergy/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/screens/home_screen.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: makeAppBar(context)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1483201075/photo/ecopath-in-the-forest-vdnkh-moscow.webp?s=1024x1024&w=is&k=20&c=N8BJJK8MBVOv2JeMmZVnx7fpM2kpAXXBhMVqZ66S_UM='),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Craft Your EcoPath',
                style: GoogleFonts.poppins(
                  color: Colors.purple,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Optimize energy, water, waste, and consumption for a harmonious life.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_right_alt,
                  size: 58,
                  color: Colors.white,
                ),
                onPressed: () {
                  moveScreen(context, HomeScreen(), isPushReplacement: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
