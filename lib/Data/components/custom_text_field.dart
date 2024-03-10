import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textField({hintText, icon, controller}) {
  return TextField(
    controller: controller,
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      //prefixIcon:Icon( Icons.search),
      hintText: hintText,
      hintTextDirection: TextDirection.rtl,
      fillColor: Colors.white,
      hintStyle: GoogleFonts.tajawal(
        color: Colors.grey[500],
        fontSize: 18.0,
      ),

      prefixIcon: IconButton(
        padding: const EdgeInsets.only(left: 10),
        icon: Icon(
          icon,
          size: 18,
        ),
        onPressed: () => print("clear"),
      ),
      contentPadding: const EdgeInsets.all(20),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
