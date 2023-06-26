import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final Color? textcolor;
  final double? fontsize;

  const TextWidget({
    super.key,
    required this.label,
    this.textcolor = Colors.black,
    this.fontsize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: fontsize, color: textcolor!),
    );
  }
}
