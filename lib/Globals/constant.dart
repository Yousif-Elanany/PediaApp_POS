import 'package:flutter/material.dart';

addAllPaddingSpace({double value = 20}) {
  return EdgeInsets.all(value);
}

addSymmetricPaddingSpace({double vertical = 20, double horizontal = 20}) {
  return EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
}

addOnlyPaddingSpace(
    {double left = 20,
    double right = 20,
    double top = 20,
    double bottom = 20}) {
  return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
}

addVerticalSpace({double h = 20}) {
  return SizedBox(
    height: h,
  );
}

addHorizontalSpace({double w = 20}) {
  return SizedBox(
    width: w,
  );
}

addDivider({double height = .1}) {
  return Divider(
    height: height,
    thickness: 1,
    color: const Color(0xffD8D8E1),
  );
}

double widthContext(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightContext(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
