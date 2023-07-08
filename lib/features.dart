import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  static const String id = 'Features';

  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('About'),
        // elevation: 0.0,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 30, top: 50, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "➡ Users can access the app/website and enter the phone number of the person they want to communicate with.\n\n➡ The app/website will then redirect the user to a WhatsApp chat window with the corresponding phone number.\n\n➡ This can be particularly useful when communicating with someone for a short period.\n\n➡ It can also help users to maintain privacy by not adding unnecessary contacts to their phone's address book.\n\n➡ This app/website can be particularly useful when users want to initiate communication with someone quickly.\n\n➡ This app/website may be especially useful for businesses or professionals who frequently communicate with new clients or customers but do not want to add every contact to their phone's address book.\n\n➡ Users can communicate or chat with individuals who have a mobile number from any country, as long as they have a valid WhatsApp account associated with that number.\n\n➡ Additionally, users should ensure they have the correct phone number before sending a message, as there is no saved contact to verify the information.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
