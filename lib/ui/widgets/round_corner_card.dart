import 'package:flutter/material.dart';

class RoundCornerCard extends StatelessWidget {
  const RoundCornerCard({super.key, required this.height, required this.label,
  required this.borderCorner, required this.cardColor, required this.labelColor});
  final double height;
  final String label;
  final Color cardColor;
  final Color labelColor;
  final double borderCorner;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      decoration: BoxDecoration(
          color:  cardColor,
          //  Color.fromARGB(128, 246, 239, 239),
          borderRadius: BorderRadius.circular(borderCorner)
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color:labelColor,
              fontSize: 20,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
