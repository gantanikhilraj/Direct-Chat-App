// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_dm/constants.dart';
import 'package:whatsapp_dm/drawerscreen.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {
  final textfeildphone = TextEditingController();
  final textfeildtext = TextEditingController();

  void cleartext() {
    textfeildphone.clear();
    textfeildtext.clear();
  }

  var phone = '';
  var message = '';
  var code = "+91";
  String errortextfeile = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textfeildphone.dispose();
    textfeildtext.dispose();
    super.dispose();
  }

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
        drawer: const DrawerWDM(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: (() async {
                const url = 'https://wa.openinapp.co/ygufb';
                await Share.share(
                    'Unlock Seamless Conversations on WhatsApp 🚀: Start Chats without Adding Contacts First! 📲💬 Try this App Today! 🔥👉 $url');
              }),
              icon: const Icon(Icons.share),
            ),
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
          backgroundColor: Colors.green,
          title: const Row(
            children: [
              // Icon(
              //   Icons.whatsapp,
              //   size: 35,
              // ),
              SizedBox(width: 5),
              Text(
                "Direct Chat for WhatsApp",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: const Text(
                    "The app or website does not store any of the phone numbers or personal information entered by the user, providing an additional layer of privacy protection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    bottom: 5,
                    top: 5,
                    right: 40,
                  ),
                  child: Text(
                    "Direct Chat for WhatsApp :\nInitiate conversations without saving contacts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  // AnimatedTextKit(
                  //   repeatForever: false,
                  //   totalRepeatCount: 1,
                  //   animatedTexts: [
                  //     TypewriterAnimatedText(
                  //       textAlign: TextAlign.center,
                  //       'WhatsAppDM :\nInitiate conversations without saving contacts',
                  //       textStyle: TextStyle(
                  //         fontSize: 22,
                  //         color: Colors.black,
                  //       ),
                  //       speed: Duration(milliseconds: 90),
                  //     ),
                  //   ],
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CountryCodePicker(
                    onChanged: (val) {
                      code = val.toString();
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Form(
                    child: TextFormField(
                      autofocus: false,
                      controller: textfeildphone,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(
                          () {
                            if (value.contains(' ')) {
                              errortextfeile = 'Don\'t use blank spaces';
                            } else {
                              errortextfeile = '';
                              phone = value;
                            }
                          },
                        );
                      },
                      decoration: InputDecoration(
                        errorText:
                            errortextfeile.isEmpty ? null : errortextfeile,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Form(
                    child: TextFormField(
                      autofocus: false,
                      controller: textfeildtext,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        message = value;
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(200, 30)),
                    onPressed: () async {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.none) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(Constants.snackbarlnetwork);
                      } else if (phone.isEmpty) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(Constants.snackbarempty);
                        return;
                      } else if (phone.length < 10) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(Constants.snackbarlength);
                        return;
                      } else if (phone.length > 11) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(Constants.snackbaroverlength);
                        return;
                      } else if (textfeildphone.text.contains(' ')) {
                        return;
                      } else {
                        code = code.replaceAll("+", "");
                        var url = "https://wa.me/$code$phone?text=$message";
                        if (await canLaunch(url)) {
                          await launch(url);
                          cleartext();
                          phone = '';
                          message = '';
                          // code = '';
                        } else {
                          throw "Could not launch $url";
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: const Text(
                        "Message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
