import 'package:flutter/material.dart';

TextStyle textStyleS18W500(context) {
  return Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(fontWeight: FontWeight.w500);
}

TextStyle textStyleS17Bold(context) {
  return Theme.of(context).textTheme.titleLarge!;
}

TextStyle textStyleS20Bold(context) {
  return Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(fontWeight: FontWeight.w600, fontSize: 18);
}

TextStyle textStyleS17Normal(context) {
  return Theme.of(context).textTheme.headlineMedium!;
}

TextStyle textStyleS17small(context) {
  return Theme.of(context)
      .textTheme
      .headline4!
      .copyWith(fontSize: 14, fontWeight: FontWeight.w100);
}
