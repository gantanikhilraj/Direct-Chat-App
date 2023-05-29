import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_dm/constants.dart';
import 'package:whatsapp_dm/drawerscreen.dart';

// ignore: camel_case_types
class Homescreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _Homescreen();
}

// ignore: camel_case_types
class _Homescreen extends State<Homescreen> {
  var phone = '';
  var message = '';
  var code = "+91";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWDM(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        backgroundColor: Colors.green,
        title: Row(
          children: const [
            Icon(
              Icons.whatsapp,
              size: 35,
            ),
            SizedBox(width: 5),
            Text("WhatsApp Direct Chat"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                hoverColor: Colors.blueGrey[300],
                splashColor: Colors.blueGrey,
                onTap: (() => launch(
                    "https:play.google.com/store/apps/details?id=com.wameapp.whatsappdmandroidapp")),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Click here to download from Playstore",
                    ),
                    Icon(Icons.link_outlined),
                  ],
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 60, top: 30),
                child: AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '" WhatsApp Direct Chat: Initiate conversations without saving contacts "',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      speed: const Duration(milliseconds: 90),
                    ),
                  ],
                ),
              ),
              CountryCodePicker(
                onChanged: (val) {
                  code = val.toString();
                },
                initialSelection: 'IN',
                showDropDownButton: true,
                closeIcon: const Icon(
                  Icons.close_outlined,
                  size: 30,
                ),
                favorite: const ['+91', 'In'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Form(
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black87,
                      ),
                      hintText: 'Phone Number',
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
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                child: Form(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      message = value;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.message, color: Colors.black87),
                      hoverColor: Colors.green,
                      hintText: 'Message(Optional)',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(150, 30)),
                onPressed: () async {
                  if (phone.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(ConstantsText.snackbarempty);
                    return;
                  } else if (phone.length < 7) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(ConstantsText.snackbarlength);
                    return;
                  } else if (phone.length > 12) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(ConstantsText.snackbaroverlength);
                    return;
                  } else {
                    code = code.replaceAll("+", "");
                    var url = "https://wa.me/$code$phone?text=$message";
                    if (await canLaunch(url)) {
                      await launch(url);
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
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
