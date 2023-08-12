import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoginButton extends StatefulWidget {
  final Color hoverColor; // New property for hover color
  final double borderWidth; // New property for border width
  final Color borderColor; // New property for border color

  const CustomLoginButton({
    Key? key,
    this.hoverColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<CustomLoginButton> createState() => CustomLoginButtonState();
}

class CustomLoginButtonState extends State<CustomLoginButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {},
      onTapDown: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        width: double.infinity,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _isHovered ? widget.hoverColor : widget.borderColor,
            width: widget.borderWidth,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.green,
              _isHovered ? widget.hoverColor : Colors.green.shade300,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          "Login",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
