import 'package:flutter/material.dart';

class ConstantColors {
  static const Color black = Color(0xFF010312);
}

class ConstantsText {
  static const snackbarempty = SnackBar(
    content: Text("Please enter mobile number"),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 1500),
  );
  static const snackbarlnetwork = SnackBar(
    content: Text("Please check your network connection and try again"),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 1500),
  );
  static const snackbarlength = SnackBar(
    content: Text("Please enter a valid phone number"),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 1500),
  );
  static const snackbarfeedbacklentherror = SnackBar(
    duration: Duration(milliseconds: 1500),
    content: Text("Feedback or bug should be atleast 20 words"),
    backgroundColor: Colors.red,
  );
}
