import 'package:filmboxd/services/auth_service.dart';
import 'package:flutter/material.dart'; // Import Flutter material package
import 'package:filmboxd/components/my_textfield.dart'; // Import custom text field component
import 'package:filmboxd/components/my_button.dart'; // Import custom button component
import 'package:filmboxd/components/my_button_light.dart'; // Import custom light button component

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passWordController = TextEditingController();
  final confirmPassWordController = TextEditingController();

  // void signUserUp() async {

  //   //show loading circle
  //   /*
  //   showDialog(context: context, builder: (context) {
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   });
  //   */

  //   //create user
  //   try {
  //     //check if password is confirmed
  //     if (passWordController.text == confirmPassWordController.text) {
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passWordController.text,
  //     );

  //     }
      
  //     // Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) { 
  //     //wrong email
  //     if(e.code== 'user-not-found') {
  //       //show error
  //     }
  //     // wrong pw
  //     else if (e.code== 'wrong-password') {
  //       //show error
  //     }

      
  //   }
    
  // }

  // void signUserInWithGoogle() {}

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
            // Add some spacing
            children: [
              // Logo
              const SizedBox(height: 100), // Add some spacing
              const Image(
                image: AssetImage("images/filmboxd-logo.png"),
                height: 90, // Adjust the height as needed
                width: 300, // Adjust the width as needed
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
                    child: Column (
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            // Back in action. We’ve missed your reviews!
                            const Text(
                              "Roll credits on lurking. Create an account!",
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
                            const SizedBox(height: 15),
                            // Password textfield
                            MyTextField(
                              controller: passWordController,
                              hintText: 'Password',
                              obscureText: true,
                              imagePath: 'images/password.png',
                            ),
                            const SizedBox(height: 15),
                            // Confirm password textfield
                            MyTextField(
                              controller: confirmPassWordController,
                              hintText: 'Confirm Password',
                              obscureText: true,
                              imagePath: 'images/password.png',
                            ),  
                            const SizedBox(height: 35),
                            // Sign up button
                            MyButton(
                              onTap: () => AuthService().signUpWithEmailAndPassword(
                                emailController.text, 
                                passWordController.text),
                              text: 'Sign up',
                            ),
                            const SizedBox(height: 15),
                            // Or continue with
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xFFF3F0E6),
                                      thickness: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'or',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF1F1516),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xFFF3F0E6),
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Google sign up
                            MyButtonLight(
                              onTap: AuthService().signInWithGoogle,
                              buttonText: 'Sign up with Google',
                              imagePath: 'images/google.png',
                            ),
                            const SizedBox(height: 130),
                            // Already have an account? Sign in
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    'Sign in ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF1F1516),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),                            
                              ],
                            )
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