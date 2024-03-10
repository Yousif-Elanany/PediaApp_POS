// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pediaPOS/Globals/constant.dart';
import 'package:pediaPOS/theme/app_colors.dart';

Widget customElevatedButtonWithIcon(context,
        {required String title,
        required Function? function,
        bool isUpperCase = true,
        bool showSpacing = true,
        Color backGroundColor = Colors.grey,
        Color color = Colors.white,
        double? width,
        double? height,
        Widget? rightIcon,
        Widget? leftIcon,
        double radius = 10,
        bool showCustomRadius = false,
        BorderRadiusGeometry? borderRadius}) =>
    SizedBox(
      height: height ?? 50.0,
      width: width,
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: function == null ? null : () => function(),
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rightIcon ?? SizedBox.shrink(),
            showSpacing ? Spacer() : SizedBox.shrink(),
            Padding(
              padding: addSymmetricPaddingSpace(vertical: 0, horizontal: 0),
              child: AutoSizeText(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    color: color,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            showSpacing ? Spacer() : SizedBox.shrink(),
            leftIcon ?? SizedBox.shrink()
          ],
        ),
        style: ElevatedButton.styleFrom(
            foregroundColor: color,
            backgroundColor: backGroundColor,
            elevation: 0,
            textStyle: Theme.of(context).textTheme.headline6,
            shape: RoundedRectangleBorder(
                borderRadius: showCustomRadius
                    ? borderRadius ?? BorderRadius.circular(5)
                    : BorderRadius.circular(radius))),
      ),
    );

customAcceptTerms(context,
    {required ValueChanged<bool>? onChanged, required bool value}) {
  return Row(
    children: [
      Checkbox(
          activeColor: AppColor.primaryColor,
          value: value,
          onChanged: (value) => onChanged),
      InkWell(
          onTap: () {
            // NavigationRout.navigatorTo(
            //     context, TermsAndCondition("1"));
          },
          child: Row(
            children: [
              Text(
                "accept",
                style: Theme.of(context).textTheme.headline4,
              ),
              addHorizontalSpace(w: 5),
              Text(
                "terms and condition",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: AppColor.primaryColor,
                    decoration: TextDecoration.underline),
              )
            ],
          ))
    ],
  );
}

customTextOrIconButton({required function, label}) {
  return TextButton(child: label ?? Container(), onPressed: () => function());
}
