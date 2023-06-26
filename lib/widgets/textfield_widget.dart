import 'package:flutter/material.dart';
import 'package:test_app/widgets/text_widget.dart';

class TextfieldWidget extends StatelessWidget {
  var textfieldController = TextEditingController();
  final String label;
  final IconData icon;
  final bool? isObscure;

  TextfieldWidget({
    super.key,
    required this.textfieldController,
    required this.icon,
    required this.label,
    this.isObscure = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        obscureText: isObscure!,
        controller: textfieldController,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          label: TextWidget(
            label: label,
          ),
        ),
      ),
    );
  }
}
