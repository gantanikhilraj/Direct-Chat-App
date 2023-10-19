import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:whatsapp_dm/screens/home_screen.dart';
import 'package:whatsapp_dm/modals/provider_data.dart';
import 'package:whatsapp_dm/screens/qr_screen.dart';
import 'package:whatsapp_dm/screens/reportbug_screen.dart';
import 'package:whatsapp_dm/screens/splash_screen.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => WhatsAppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Homescreen.id: (context) => const Homescreen(),
        QRCodeGenerator.id: (context) => const QRCodeGenerator(),
        Reportbug.id: (context) => Reportbug(),
      },
    );
  }
}
