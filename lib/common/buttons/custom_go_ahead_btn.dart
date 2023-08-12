import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGoAheadButton extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  final Color hoverColor; // New property for hover color
  final double borderWidth; // New property for border width
  final Color borderColor; // New property for border color

  const CustomGoAheadButton({
    Key? key,
    required this.bgColor,
    required this.text,
    required this.onTap,
    required this.textColor,
    this.hoverColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<CustomGoAheadButton> createState() => CustomGoAheadButtonState();
}

class CustomGoAheadButtonState extends State<CustomGoAheadButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
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
        height: size.height * 0.07,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? widget.hoverColor : widget.borderColor,
            width: widget.borderWidth,
          ),
          gradient: LinearGradient(
            colors: [
              widget.bgColor,
              _isHovered ? widget.hoverColor : widget.bgColor,
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
          widget.text,
          style: GoogleFonts.poppins(
            color: widget.textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
