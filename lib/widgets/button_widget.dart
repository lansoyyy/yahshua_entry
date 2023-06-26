import 'package:flutter/material.dart';
import 'package:test_app/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? color;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = Colors.blue,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 300,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      onPressed: onPressed,
      child: TextWidget(
        label: label,
        fontsize: 24,
        textcolor: Colors.white,
      ),
    );
  }
}
