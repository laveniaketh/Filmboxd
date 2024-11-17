import 'package:flutter/material.dart';
import 'package:filmboxd/components/my_textfield.dart';
import 'package:filmboxd/components/my_button.dart';
import 'package:filmboxd/components/my_button_light.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  // sign in user method 
  void signUserIn() {}
  void signUserInWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when the keyboard appears
      body: Center(
        child: Container(
          
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            
            // Image set to background of the body
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/SplashScreen BG.png")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Add some spacing
            children: [
              //logo
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
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            //Back in action. We’ve missed your reviews!
                            const Text(
                              "Back in action. We’ve missed your reviews!",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFf1F1516),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
      
                            const SizedBox(height: 30),
      
                            //email textfield
                            MyTextField(
                              controller: userNameController,
                              hintText: 'Email',
                              obscureText: false,
                              imagePath: 'images/email.png',
                            ),
                            const SizedBox(height: 15),
      
                            //password textfield
                            MyTextField(
                              controller: passWordController,
                              hintText: 'Password',
                              obscureText: true,
                              imagePath: 'images/password.png',
                            ),
      
                            const SizedBox(height: 15),

                            //forgot password
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Forgot Password?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF1F1516),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
      
                            const SizedBox(height: 15),
      
                            //sign in button
                            MyButton(
                              onTap: signUserIn,
                            ),
      
                            const SizedBox(height: 15),
      
                            //or continue with
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

                            //google sign in
                            MyButtonLight(
                              onTap: signUserInWithGoogle,
                              buttonText: 'Sign in with Google',
                              imagePath: 'images/google.png',
                            ),

                            

                            // const SizedBox(height: 130),

                            const SizedBox(height:190),

                            //dont have an account? sign up
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account? ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // SizedBox(width: ),
                                Text(
                                  'Sign up ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
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
              )
      
              
      
              
      
              
      
              
      
              //dont have an account? sign up
            ],
          ),
        ),
      ),
    );
  }
}
