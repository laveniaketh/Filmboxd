// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:filmboxd/components/my_button.dart';
// import 'login_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool _showButton = false;

//   @override
//   void initState() {
//     super.initState();
//     // Delay the appearance of the button by 3 seconds
//     Timer(Duration(seconds: 3), () {
//       setState(() {
//         _showButton = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             // Image set to background of the body
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage("images/SplashScreen BG.png"),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               //logo
//               const SizedBox(height: 210), // Add some spacing
//               const Image(
//                 image: AssetImage("images/filmboxd-logo.png"),
//                 height: 90, // Adjust the height as needed
//                 width: 300, // Adjust the width as needed
//               ),

//               const Spacer(), // Pushes the button to the bottom

//               //get started button
//               if (_showButton)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 25.0), // Add some padding at the bottom
//                   child: MyButton(
//                     onTap: 
//                     text: 'Get Started',
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }