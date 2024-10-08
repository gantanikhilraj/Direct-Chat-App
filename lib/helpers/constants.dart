import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  static final snackbarfeedbacklentherror = SnackBar(
    action: SnackBarAction(
      label: "×",
      textColor: Colors.white,
      onPressed: (() {}),
    ),
    duration: const Duration(milliseconds: 1500),
    content: const Text("Feedback or bug should be atleast 20 words"),
    backgroundColor: Colors.red,
  );
  static final qrCodeEmpty = SnackBar(
    action:
        SnackBarAction(label: "x", textColor: Colors.white, onPressed: (() {})),
    duration: const Duration(seconds: 2),
    content: const Text("Enter Phone Number to Generate QR Code"),
    backgroundColor: Colors.red,
  );
  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
    );
  }
}

class ConstantsText {
  static String playstoreURL = "https://directchat.openinapp.co/playstorelink";
  static String shareText =
      "Unlock Seamless Conversations on WhatsApp 🚀: Start Chats without Adding Contacts First! 📲💬 Try this App Today! 🔥👉";
  static String appTitle = "Direct Chat & QR";
  static String mainScreenTitle =
      "Direct Chat & QR :\nInitiate conversations without saving contacts";
}
