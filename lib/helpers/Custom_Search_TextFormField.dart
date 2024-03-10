import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class customSearchTextField extends StatelessWidget {
  customSearchTextField(
      {super.key,
      required this.hintText,
      required this.mycontroller,
      this.onsub,
      this.textDirection,
      required this.tybe});
  TextEditingController? mycontroller = TextEditingController();
  void Function(String)? onsub;
  TextInputType? tybe;
  String? hintText;
  TextDirection? textDirection;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: textDirection,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Opacity(
              opacity: .8,
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 22,
              ),
            ),
          ),
        ),
      ),
      onSubmitted: onsub,
      controller: mycontroller,
      keyboardType: tybe,
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(
        12,
      ),
    );
  }
}
