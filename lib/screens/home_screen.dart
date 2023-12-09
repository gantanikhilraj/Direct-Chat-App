import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_dm/modals/provider_data.dart';
import 'package:whatsapp_dm/screens/qr_screen.dart';
import 'package:whatsapp_dm/helpers/constants.dart';
import 'package:whatsapp_dm/screens/drawer_screen.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_dm/services/admob.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {
  BannerAd? _banner;
  late InterstitialAd interstitialAd;
  bool isAdloaded = false;
  bool adShown = false;
  initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.homeShareInter,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isAdloaded = true;
          });
        },
        onAdFailedToLoad: ((error) {
          interstitialAd.dispose();
        }),
      ),
    );
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.homescreenBannerUnitID,
      listener: AdMobService.homescreenbannerListener,
      request: const AdRequest(),
    )..load();
  }

  bool isListTileVisible = true;
  final textfieldphone = TextEditingController();
  final textfieldtext = TextEditingController();
  String errortextfield = '';

  void cleartext() {
    textfieldphone.clear();
    textfieldtext.clear();
  }

  @override
  void initState() {
    super.initState();
    final whatsappData = Provider.of<WhatsAppData>(context, listen: false);
    whatsappData.loadAppVersion();
    // Timer(const Duration(seconds: 45), () {
    //   setState(() {
    //     isListTileVisible = false;
    //   });
    // });
    _createBannerAd();
    initInterstitialAd();
  }

  @override
  void dispose() {
    _banner?.dispose();
    interstitialAd.dispose();
    _createBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final whatsappData = Provider.of<WhatsAppData>(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        drawer: const DrawerWDM(),
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, QRCodeGenerator.id);
              },
              icon: const Icon(Icons.qr_code),
            ),
            IconButton(
              onPressed: () async {
                if (!adShown) {
                  if (isAdloaded) {
                    await interstitialAd.show();
                    adShown = true;
                  }
                } else {
                  await Share.share(
                    '${ConstantsText.shareText} ${ConstantsText.playstoreURL}',
                  );
                }
              },
              icon: const Icon(Icons.share),
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.green[400],
          ),
          backgroundColor: Colors.green,
          title: Text(
            ConstantsText.appTitle,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   margin: EdgeInsets.all(screenHeight * 0.02),
                  //   padding: const EdgeInsets.all(16.0),
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.black)),
                  //   child: const Text(
                  //     "The app or website does not store any of the phone numbers or personal information entered by the user, providing an additional layer of privacy protection.",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      ConstantsText.mainScreenTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: CountryCodePicker(
                      onChanged: (val) {
                        whatsappData.updateCode(val.toString());
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      autofocus: false,
                      controller: textfieldphone,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          if (value.contains(' ') ||
                              value.contains('-') ||
                              value.contains('.')) {
                            errortextfield = 'Don\'t use blank spaces';
                          } else {
                            errortextfield = '';
                            whatsappData.updatePhone(value);
                          }
                        });
                      },
                      decoration: InputDecoration(
                        errorText:
                            errortextfield.isEmpty ? null : errortextfield,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        suffixIcon: Visibility(
                          visible: textfieldphone.text.isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                textfieldphone.clear();
                                whatsappData.phone = '';
                              });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        hintText: 'Phone Number',
                        hintTextDirection: TextDirection.ltr,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      autofocus: false,
                      controller: textfieldtext,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        whatsappData.updateMessage(value);
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        hintTextDirection: TextDirection.ltr,
                        prefixIcon: Icon(
                          Icons.message,
                          color: Colors.black,
                        ),
                        hintText: 'Message (Optional)',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          Constants.showToastMessage('No Internet Connection');
                        } else if (whatsappData.phone.isEmpty) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(Constants.snackbarempty);
                          return;
                        } else if (whatsappData.phone.length < 9) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(Constants.snackbarlength);
                          return;
                        } else if (whatsappData.phone.length > 12) {
                          // Constants.showToastMessage(
                          //     'please check the number and try again');
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(Constants.snackbaroverlength);
                          return;
                        } else if (textfieldphone.text.contains(' ')) {
                          return;
                        } else {
                          String code = whatsappData.code.replaceAll("+", "");
                          var url =
                              "https://wa.me/${code}${whatsappData.phone}?text=${whatsappData.message}";
                          if (await canLaunch(url)) {
                            await launch(url);
                            cleartext();
                            whatsappData.clearTextFields();
                          } else {
                            throw "Could not launch $url";
                          }
                        }
                      },
                      child: const Text(
                        "Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Center(
                      child: Text(
                        'App Version: ${whatsappData.appVersion}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        '© 2023 Direct Chat',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Visibility(
                  //   visible: isListTileVisible,
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     height: MediaQuery.of(context).size.height * 0.15,
                  //     color: Colors.grey[400],
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(12),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "New Feature Alert!!!",
                  //             style: TextStyle(
                  //               fontFamily: AutofillHints.birthdayDay,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           Text(
                  //             "Get your personalized QR code for easy mobile number sharing – generate, scan, and connect hassle-free!",
                  //             style: TextStyle(
                  //               fontFamily: AutofillHints.birthdayDay,
                  //               fontSize: 18,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
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
}
