import 'package:filmboxd/components/my_button.dart';
import 'package:filmboxd/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Show error
        print('No user found for that email.');
      }
    }
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent resizing when the keyboard appears
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const SizedBox(height: 100), 
              const Image(
                image: AssetImage("images/filmboxd-logo.png"),
                height: 90, 
                width: 300, 
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Center(
                          child: Column(
                            children: [
                              // enter email to reset password
                              const Text(
                                "Enter your email to reset your password",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFf1F1516),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Email textfield
                              MyTextField(
                                controller: emailController,
                                hintText: 'Email',
                                obscureText: false,
                                imagePath: 'images/email.png',
                              ),
                              const SizedBox(height: 35),
                              //Reset password button
                              MyButton(
                                onTap: () {},
                                text: 'Reset Password',
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



