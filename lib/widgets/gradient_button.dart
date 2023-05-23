import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

// ignore: must_be_immutable
class BlueGradientButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPress;

  BlueGradientButton(
      {super.key, required this.buttonText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.8;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(200, 132, 220, 1),
          Color.fromRGBO(29, 157, 197, 1),
        ]),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            minimumSize: Size(buttonWidth, 55),
            backgroundColor: Colors.transparent),
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PurpleGradientButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPress;
  PurpleGradientButton(
      {super.key, required this.buttonText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.8;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(152, 129, 220, 1),
          Color.fromRGBO(197, 29, 150, 1),
        ]),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            minimumSize: Size(buttonWidth, 55),
            backgroundColor: Colors.transparent),
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
