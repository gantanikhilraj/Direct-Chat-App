import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:whatsapp_dm/helpers/constants.dart';
import 'package:whatsapp_dm/helpers/operations.dart';
import 'package:whatsapp_dm/services/admob.dart';

final GlobalKey boundaryKey = GlobalKey();

class QRCodeGenerator extends StatefulWidget {
  static const String id = 'QrCodeGenerator';

  const QRCodeGenerator({super.key});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  BannerAd? _banner;

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.qrScreenBannerUnitID,
      listener: AdMobService.homescreenbannerListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose() {
    _banner?.dispose();
    _createBannerAd();
    super.dispose();
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void cleartext() {
    phoneController.clear();
    messageController.clear();
  }

  String countryCode = '+91';
  String whatsappURL = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          title: const Text('QR Code Generator'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CountryCodePicker(
                  onChanged: (val) {
                    setState(() {
                      countryCode = val.toString();
                    });
                  },
                  initialSelection: 'IN',
                  showDropDownButton: true,
                  dialogSize: const Size(500, 600),
                  closeIcon: const Icon(
                    Icons.close_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  favorite: const ['+91', 'In'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: true,
                  enabled: true,
                  dialogBackgroundColor: Colors.white,
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.black),
                    suffixIcon: Visibility(
                      visible: phoneController.text.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            phoneController.clear();
                          });
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Message (Optional)',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(Constants.qrCodeEmpty);
                    } else if (phoneController.text.length < 9 ||
                        phoneController.text.length > 12) {
                      generateWhatsAppURL();
                    } else {
                      generateWhatsAppURL();
                    }
                  },
                  child: const Text('Generate QR Code'),
                ),
                if (whatsappURL.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      GestureDetector(
                        onLongPress: () {
                          shareQRCode();
                        },
                        child: RepaintBoundary(
                          key: boundaryKey,
                          child: GestureDetector(
                            onLongPress: () {
                              shareQRCode();
                            },
                            onTap: () {
                              saveQRCodeToGallery();
                              Fluttertoast.showToast(
                                msg: 'QR code saved to the gallery',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                              );
                            },
                            child: QrImageView(
                              // embeddedImage:
                              //     const AssetImage("assets/images/icon48.png"),
                              // embeddedImageStyle: const QrEmbeddedImageStyle(
                              //   size: Size(40, 40),
                              // ),
                              errorCorrectionLevel: QrErrorCorrectLevel.H,
                              backgroundColor: Colors.white,
                              data: whatsappURL,
                              version: QrVersions.auto,
                              size: MediaQuery.of(context).size.width - 150,
                              padding: const EdgeInsets.all(30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Visibility(
                  visible: phoneController.text.isNotEmpty,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        whatsappURL = '';
                        cleartext();
                      });
                    },
                    child: const Text("Clear the data"),
                  ),
                ),
                Visibility(
                    visible: whatsappURL.isNotEmpty,
                    child: const Text(
                        "Press on the QR code to save it to the gallery")),
                Visibility(
                    visible: whatsappURL.isNotEmpty,
                    child: const Text("Long Press on the QR code to share it")),
                // Visibility(
                //   visible: whatsappURL.isNotEmpty,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       TextButton(
                //         style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all(Colors.lightGreen),
                //         ),
                //         onPressed: () {
                //           shareQRCode();
                //         },
                //         child: const Row(
                //           children: [
                //             Icon(Icons.share, color: Colors.black, size: 24),
                //             Text(
                //               'Share QR',
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       const SizedBox(width: 16),
                //       // Visibility(
                //       //   visible: whatsappURL.isNotEmpty,
                //       //   child: TextButton(
                //       //     style: ButtonStyle(
                //       //       backgroundColor:
                //       //           MaterialStateProperty.all(Colors.lightGreen),
                //       //     ),
                //       //     onPressed: () {
                //       //       saveQRCodeToGallery();
                //       //     },
                //       //     child: Row(
                //       //       children: [
                //       //         const Icon(Icons.download_rounded,
                //       //             color: Colors.black, size: 24),
                //       //         GestureDetector(
                //       //           onTap: () {
                //       //             Fluttertoast.showToast(
                //       //               msg: 'QR code saved to the gallery',
                //       //               toastLength: Toast.LENGTH_SHORT,
                //       //               gravity: ToastGravity.BOTTOM,
                //       //               backgroundColor: Colors.grey,
                //       //               textColor: Colors.white,
                //       //             );
                //       //           },
                //       //           child: const Text(
                //       //             'Save to Gallery',
                //       //             style: TextStyle(
                //       //               color: Colors.black,
                //       //               fontSize: 16,
                //       //               fontWeight: FontWeight.bold,
                //       //             ),
                //       //           ),
                //       //         ),
                //       //       ],
                //       //     ),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _banner == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                width: MediaQuery.of(context).size.width,
                child: AdWidget(ad: _banner!),
              ),
      ),
    );
  }

  void generateWhatsAppURL() {
    final phone = phoneController.text;
    final message = messageController.text;
    whatsappURL =
        'https://wa.me/$countryCode$phone?text=${Uri.encodeComponent(message)}';
    setState(() {
      whatsappURL = whatsappURL;
    });
  }
}
