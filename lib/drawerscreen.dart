import 'package:flutter/material.dart';
import 'package:whatsapp_dm/features.dart';
import 'package:whatsapp_dm/homescreen.dart';
import 'package:whatsapp_dm/reportbugscreen.dart';

class DrawerWDM extends StatelessWidget {
  static const String id = 'AboutScreen';

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: Drawer(
        child: ListView(
          children: [
            const SingleChildScrollView(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "@WhatsAppDM :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text("Direct Message for WhatsApp"),
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
                Navigator.pushNamed(context, Homescreen.id);
              },
            ),
            const Divider(
              height: 0.1,
              color: Colors.black,
              thickness: 0.1,
            ),
            ListTile(
              leading: const Icon(
                Icons.add_card,
                color: Colors.black,
                size: 26,
              ),
              title: const Text('About', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pushNamed(context, Features.id);
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
