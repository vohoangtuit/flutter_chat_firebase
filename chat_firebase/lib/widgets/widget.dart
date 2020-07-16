import 'package:flutter/material.dart';

Widget materialApp(BuildContext context, String title) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
  );
}

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/images/logo.png',
      height: 45,
    ),
  );
}

Widget appBarWithTitle(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: titleTextWhite()),
    centerTitle: true,
  );
}

InputDecoration inputDecoration(
    String labelText, String hintText, String errorText) {
  return InputDecoration(
    // labelText: labelText ,
    hintText: hintText,
    // errorText: errorText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}
TextStyle smallTextWhite() {
  return TextStyle(color: Colors.white, fontSize: 13);
}
TextStyle normalTextWhite() {
  return TextStyle(color: Colors.white, fontSize: 14);
}

TextStyle mediumTextWhite() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle titleTextWhite() {
  return TextStyle(color: Colors.white, fontSize: 18);
}

TextStyle normalTextStyleButton(Color color) {
  return TextStyle(color: color, fontSize: 17);
}

BoxDecoration decorationButton(Color color, double borderRadius) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
