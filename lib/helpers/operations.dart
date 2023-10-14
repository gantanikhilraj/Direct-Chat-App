import 'dart:io';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_dm/screens/qr_screen.dart';

Future<void> shareQRCode() async {
  if (boundaryKey.currentContext == null) {
    print('Error: Unable to capture QR code.');
    return;
  }

  final boundary =
      boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 3.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final uint8List = byteData!.buffer.asUint8List();

  // Save the image to a file
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/qr_code.png');
  await file.writeAsBytes(uint8List);

  // Check if the file exists before sharing
  if (await file.exists()) {
    // For sharing:
    Share.shareFiles([file.path],
        text: 'QR Code', subject: 'QR Code', mimeTypes: ['image/png']);
  } else {
    print('Error: The QR code image file does not exist.');
  }
}

Future<void> saveQRCodeToGallery() async {
  if (boundaryKey.currentContext == null) {
    print('Error: Unable to capture QR code.');
    return;
  }

  final boundary =
      boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 3.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final uint8List = byteData!.buffer.asUint8List();

  // Save the image to the device's gallery
  final result = await ImageGallerySaver.saveImage(uint8List);

  if (result['isSuccess']) {
    print('QR code image saved to gallery.');
  } else {
    print('Error: Failed to save QR code image to gallery.');
  }
}
