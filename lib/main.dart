import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:whatsapp_dm/features.dart';
import 'package:whatsapp_dm/homescreen.dart';
import 'package:whatsapp_dm/reportbugscreen.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const Homescreen(),
      routes: {
        // Homescreen.id: (context) => const Homescreen(),
        Features.id: (context) => Features(),
        Reportbug.id: (context) => Reportbug(),
      },
    );
  }
}
