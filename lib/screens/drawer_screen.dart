import 'package:flutter/material.dart';
import 'package:whatsapp_dm/screens/qr_screen.dart';

import 'package:whatsapp_dm/screens/reportbug_screen.dart';

class DrawerWDM extends StatelessWidget {
  static const String id = 'AboutScreen';

  const DrawerWDM({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const SingleChildScrollView(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "@Direct Chat for WhatsApp",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text("By Nikhil Raj"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 28,
              ),
              title: const Text('Home', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, Homescreen.id);
              },
            ),
            const Divider(
              height: 0.1,
              color: Colors.black,
              thickness: 0.1,
            ),
            ListTile(
              leading: const Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
                size: 26,
              ),
              title: const Text('Qr Code', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, QRCodeGenerator.id);
              },
            ),
            const Divider(
              height: 0.1,
              color: Colors.black,
              thickness: 0.1,
            ),
            ListTile(
              leading: const Icon(
                Icons.bug_report_outlined,
                color: Colors.black,
                size: 26,
              ),
              title:
                  const Text('Send Feedback', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, Reportbug.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
