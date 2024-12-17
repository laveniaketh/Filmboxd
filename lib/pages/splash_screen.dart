import 'package:filmboxd/pages/login_or_register_page.dart';
import 'package:flutter/material.dart';
import 'package:filmboxd/components/my_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

//initially show login page
  bool showLoginPage = true;

  //toggle between the login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            // Image set to background of the body
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/SplashScreen BG.png"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //logo
              const SizedBox(height: 210),
              const Image(
                image: AssetImage("images/filmboxd-logo.png"),
                height: 90,
                width: 300,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: MyButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginOrRegisterPage()),
                    );
                  },
                  text: 'Get Started',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
