// import 'package:flutter/material.dart';
// import 'package:whatsapp_dm/screens/home_screen.dart';
// // import 'package:whatsapp_dm/screens/network_screen.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(
//       const Duration(seconds: 2),
//       () {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const Homescreen()),
//         );
//       },
//     );

//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: AspectRatio(
//                     aspectRatio: 0.2,
//                     child: Image.asset(
//                       "assets/images/icon48.png",
//                       fit: BoxFit.contain,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 // const SizedBox(height: 5),
//                 const Text(
//                   "Direct Chat & QR",
//                   style: TextStyle(color: Colors.green, fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
