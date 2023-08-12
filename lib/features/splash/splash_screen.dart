import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eco_synergy/constants/constants.dart';
import 'package:eco_synergy/features/home/screens/home_screen.dart';
import 'package:eco_synergy/features/onboarding/screens/onboarding_screen.dart';
import 'package:eco_synergy/utils/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: GradientText(
        "Ecoly",
        const LinearGradient(colors: [
          Colors.blue,
          Colors.redAccent,
        ]),
        style: GoogleFonts.poppins(
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black12,
      animationDuration: const Duration(seconds: 5),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.theme,
      nextScreen: firebaseAuth.currentUser != null
          ? const HomeScreen()
          : const OnboardingScreen(),
    );
  }
}
