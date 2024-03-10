import 'package:flutter/cupertino.dart';

Widget sizedBoxGlobal({index, height, width}) {
  switch (index) {
    case 0:
      return SizedBox(
        height: height,
      );
    case 1:
      return SizedBox(
        width: width,
      );
    default:
      return SizedBox(
        width: width,
        height: height,
      );
  }
}

Widget sizedBoxGlobalHeight20() {
  return sizedBoxGlobal(index: 0, height: 20.0);
}

Widget sizedBoxGlobalHeight10() {
  return sizedBoxGlobal(index: 0, height: 10.0);
}

Widget sizedBoxGlobalHeight30() {
  return sizedBoxGlobal(index: 0, height: 30.0);
}
