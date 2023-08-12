import 'package:eco_synergy/common/buttons/custom_login_button.dart';
import 'package:eco_synergy/common/text_fields/custom_text_field.dart';
import 'package:eco_synergy/constants/constants.dart';
import 'package:eco_synergy/constants/utils.dart';
import 'package:eco_synergy/features/auth/controllers/auth_controller.dart';
import 'package:eco_synergy/features/auth/screens/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void logIn(BuildContext context) {
    AuthController controller = AuthController();

    controller.logIn(context, _emailController.text, _passController.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Welcome, Welcome! 😉 🔥🔥",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "We have to be the doctors of environment! :)",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      isObscure: false),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                      controller: _passController,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: true),

                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New to $appName?",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            moveScreen(context, SignUpScreen());
                          },
                          child: Text(
                            "\tRegister here :D",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomLoginButton(
                    text: "Login",
                    onTap: () {
                      logIn(context);
                    },
                  ),
                  //lol, I'm tireddddd
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
