import 'package:eco_synergy/common/buttons/custom_go_ahead_btn.dart';
import 'package:eco_synergy/constants/utils.dart';
import 'package:eco_synergy/features/onboarding/screens/onboarding_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
                    'https://images.unsplash.com/photo-1572202808998-93788f6d39da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZWNvfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Greener Living Awaits',
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
                  'Empower your journey towards sustainability with our innovative features.',
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
            CustomGoAheadButton(
                bgColor: const Color.fromARGB(255, 64, 131, 2),
                text: "Go Ahead!",
                onTap: () {
                  moveScreen(context, const OnboardingScreen2());
                },
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
