import 'package:flutter/material.dart';

// class ConstantColors {
//   static const Color black = Color(0xFF010312);
// }

class Constants {
  static final snackbarempty = SnackBar(
    action: SnackBarAction(
      label: "×",
      textColor: Colors.white,
      onPressed: (() {}),
    ),
    content: const Text("Please enter mobile number"),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 1),
  );
  static final snackbarlnetwork = SnackBar(
    action: SnackBarAction(
      label: "×",
      textColor: Colors.white,
      onPressed: (() {}),
    ),
    content: const Text("Please check your network connection and try again"),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 1),
  );
  static final snackbarlength = SnackBar(
    action: SnackBarAction(
      label: "×",
      textColor: Colors.white,
      onPressed: (() {}),
    ),
    content: const Text("Please enter a valid phone number"),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 1),
  );
  static final snackbaroverlength = SnackBar(
    action: SnackBarAction(
      label: "×",
      textColor: Colors.white,
      onPressed: (() {}),
    ),
    content: const Text("please check the number and try again"),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 2),
  );
  static const snackbarfeedbacklentherror = SnackBar(
    duration: Duration(milliseconds: 1500),
    content: Text("Feedback or bug should be atleast 20 words"),
    backgroundColor: Colors.red,
  );
  static final qrCodeEmpty = SnackBar(
    action:
        SnackBarAction(label: "x", textColor: Colors.white, onPressed: (() {})),
    duration: const Duration(seconds: 2),
    content: const Text("Enter Phone Number to Generate QR Code"),
    backgroundColor: Colors.red,
  );
  static String playstoreURL = "https://directchat.openinapp.co/playstorelink";
}
