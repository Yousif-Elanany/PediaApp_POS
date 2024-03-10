import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {this.hintText,
      this.LabelText,
      this.textdirection,
      this.onChanged,
      this.obscureText = false,
      this.controller});
  Function(String)? onChanged;
  String? hintText;
  TextEditingController? controller;
  bool? obscureText;
  TextDirection? textdirection;
  String? LabelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText!,
        textDirection: textdirection,
        textAlign: TextAlign.right,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: LabelText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
