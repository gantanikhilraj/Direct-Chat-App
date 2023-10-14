import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class WhatsAppData with ChangeNotifier {
  String code = "";
  String phone = '';
  String message = '';
  String appVersion = '';

  void updateCode(String newCode) {
    code = newCode;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    phone = newPhone;
    notifyListeners();
  }

  void updateMessage(String newMessage) {
    message = newMessage;
    notifyListeners();
  }

  void clearTextFields() {
    phone = '';
    message = '';
    notifyListeners();
  }

  Future<void> loadAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion = info.version;
      notifyListeners();
    } catch (e) {
      print('Error loading app version: $e');
    }
  }
}
