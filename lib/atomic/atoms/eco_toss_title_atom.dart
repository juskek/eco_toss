import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoTossTitleAtom extends StatelessWidget {
  const EcoTossTitleAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Text(
        'Eco Toss',
        textAlign: TextAlign.center,
        style: GoogleFonts.happyMonkey(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontSize: 48,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
