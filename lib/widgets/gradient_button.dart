import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class BlueGradientButton extends StatelessWidget {
  final String buttonText;
  const BlueGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(200, 132, 220, 1),
          Color.fromRGBO(29, 157, 197, 1),
        ]),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            minimumSize: const Size(350, 55),
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
