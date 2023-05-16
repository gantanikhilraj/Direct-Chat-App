import 'package:flutter/material.dart';

class ConstantColors {
  static const Color black = Color(0xFF010312);
}

class ConstantsText {
  static const snackbarempty = SnackBar(
    content: Text("Please enter mobile number"),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
  static const snackbaroverlength = SnackBar(
    content: Text("Please check the number and try again"),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
  static const snackbarlength = SnackBar(
    content: Text("Please enter a valid phone number"),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
  static const snackbarfeedbacklentherror = SnackBar(
    duration: Duration(seconds: 3),
    content: Text("Feedback or bug should be atleast 20 characters"),
    backgroundColor: Colors.red,
  );
}
