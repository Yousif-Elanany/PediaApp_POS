import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pediaPOS/theme/app_colors.dart';

Widget textGlobal(
    {max,
    text,
    required BuildContext context,
    double? fontSize,
    required Color color,
    required bool bold}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        color: color,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
      maxLines: max ?? 1,
    ),
  );
}

Widget textGlobalWithoutPadding(
    {max,
    text,
    required BuildContext context,
    double? fontSize,
    required Color color,
    required bool bold}) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        color: color,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
      maxLines: max ?? 1,
    ),
  );
}

Widget textGlobalLine(
    {text,
    required BuildContext context,
    double? fontSize,
    required Color color,
    required bool bold}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.tajawal(
        color: color,
        decoration: TextDecoration.lineThrough,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
      maxLines: 2,
    ),
  );
}

textGlobalBlackBold20({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 20.0,
      color: AppColor.liteBlack,
      bold: true);
}

textGlobalWhiteBold20({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 10.0,
      color: AppColor.fillColor,
      bold: true);
}

textGlobalGreyBold15({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 15.0,
      color: AppColor.grayColor,
      bold: true);
}

textGlobalWhiteBold16({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 16.0,
      color: AppColor.fillColor,
      bold: true);
}

textGlobalBlackBold25({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 25.0,
      color: AppColor.liteBlack,
      bold: true,
      max: 2);
}

textGlobalBlackWhite25({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 25.0,
      color: AppColor.white,
      bold: true,
      max: 2);
}

textGlobalBlackBold16({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 16.0,
      color: AppColor.liteBlack,
      bold: true);
}

textGlobalBlackBold162({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      max: 2,
      context: context,
      fontSize: 14.0,
      color: AppColor.liteBlack,
      bold: true);
}

textGlobalBlackBold13({required BuildContext context, text}) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.48,
      child: Text(
        text,
        style: const TextStyle(
            color: AppColor.liteBlack,
            fontWeight: FontWeight.bold,
            fontSize: 14),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ));
}

textGlobalBlackBold18({required BuildContext context, text}) {
  return Text(
    text,
    style: const TextStyle(
        color: AppColor.liteBlack, fontWeight: FontWeight.bold, fontSize: 18),
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
  );
}

textGlobalBlackNormal6Line({required BuildContext context, text}) {
  return textGlobalLine(
      text: text,
      context: context,
      fontSize: 16.0,
      color: AppColor.liteBlack,
      bold: false);
}

textGlobalBlackBold16Line({required BuildContext context, text}) {
  return textGlobalLine(
      text: text,
      context: context,
      fontSize: 16.0,
      color: AppColor.redColor,
      bold: false);
}

textGlobalBlackNormal2Line({required BuildContext context, text}) {
  return textGlobalLine(
      text: text,
      context: context,
      fontSize: 12.0,
      color: AppColor.liteBlack,
      bold: false);
}

textGlobalBlackNormal16({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 16.0,
      color: AppColor.liteBlack,
      bold: false);
}

textGlobalBlackNormal12({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 12.0,
      color: AppColor.liteBlack,
      bold: false);
}

textGlobalBlackBold35({required BuildContext context, text}) {
  return textGlobal(
      text: text,
      context: context,
      fontSize: 35.0,
      color: AppColor.liteBlack,
      bold: true);
}
