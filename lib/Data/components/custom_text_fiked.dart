// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pediaPOS/Globals/constant.dart';

// import 'package:nadamarket/helper/costant/constant.dart';

class CustomTextForm1 extends StatefulWidget {
  final TextInputType inputType;
  final String label;
  final int? maxLength;
  final ValueChanged<String>? onChange;
  final Color colorBorder;
  final Function? onTap;
  final double padding;
  final double height;
  final int maxLines;
  final ValueChanged<bool>? valid;
  final String? setInitial;
  final icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final BorderSide? borderSide;

  CustomTextForm1({
    this.inputType = TextInputType.text,
    this.setInitial,
    this.maxLength,
    this.valid,
    this.onChange,
    this.obscureText = false,
    this.readOnly = false,
    this.height = 50,
    required this.label,
    // this.svgColor = const Color(0xffBFBFBF),
    this.padding = 5,
    this.colorBorder = const Color(0xff707070),
    this.icon,
    required this.controller,
    this.onTap,
    this.maxLines = 1,
    this.suffixIcon,
    this.borderSide,
  });

  @override
  _CustomTextForm1State createState() => _CustomTextForm1State();
}

class _CustomTextForm1State extends State<CustomTextForm1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: addSymmetricPaddingSpace(vertical: 10, horizontal: 0),
        child: TextFormField(
          readOnly: widget.readOnly,
          onChanged: widget.onChange,
          obscureText: widget.obscureText,
          onTap: widget.onTap == null ? null : () => widget.onTap!(),
          controller: widget.controller,
          // formControlName: widget.formControlName,
          // validationMessages: (control) => {
          //   ValidationMessage.required: "",
          //   ValidationMessage.email: "",
          // },
          keyboardType: widget.inputType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          autofocus: false,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            errorMaxLines: 1,
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: widget.icon,
                  ),
            suffixIcon: widget.suffixIcon,
            hintText: widget.label,
            hintStyle: Theme.of(context).textTheme.caption,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10, vertical: widget.padding),
            border: Theme.of(context)
                .inputDecorationTheme
                .border!
                .copyWith(borderSide: widget.borderSide),
            enabledBorder: Theme.of(context)
                .inputDecorationTheme
                .border!
                .copyWith(borderSide: widget.borderSide),
          ),
        ));
  }
}

class CustomTextForm extends StatefulWidget {
  final TextInputType inputType;
  final String label;
  final int? maxLength;
  final Color colorBorder;
  final Function? onTap;
  final double padding;
  final double height;
  final int maxLines;
  final ValueChanged<bool>? valid;
  final String? setInitial;
  final icon;
  final String formControlName;
  final bool obscureText;
  final Widget? suffixIcon;
  final BorderSide? borderSide;

  CustomTextForm({
    this.inputType = TextInputType.text,
    this.setInitial,
    this.maxLength,
    this.valid,
    this.obscureText = false,
    this.height = 50,
    required this.label,
    // this.svgColor = const Color(0xffBFBFBF),
    this.padding = 5,
    this.colorBorder = const Color(0xff707070),
    this.icon,
    required this.formControlName,
    this.onTap,
    this.maxLines = 1,
    this.suffixIcon,
    this.borderSide,
  });

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: addSymmetricPaddingSpace(vertical: 10, horizontal: 0),
        child: TextField(
          obscureText: widget.obscureText,
          onTap: widget.onTap == null ? null : () => widget.onTap!(),
          keyboardType: widget.inputType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          autofocus: false,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            errorMaxLines: 1,
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: widget.icon,
                  ),
            suffixIcon: widget.suffixIcon,
            hintText: widget.label,
            hintStyle: Theme.of(context).textTheme.caption,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10, vertical: widget.padding),
            border: Theme.of(context)
                .inputDecorationTheme
                .border!
                .copyWith(borderSide: widget.borderSide),
            enabledBorder: Theme.of(context)
                .inputDecorationTheme
                .border!
                .copyWith(borderSide: widget.borderSide),
          ),
        ));
  }
}
