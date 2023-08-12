import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  const CustomButton({super.key, required this.text});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.065,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.lime.shade400,
      ),
      child: Text(
        widget.text,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
