import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;

  const MyButton({super.key, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
    onTap: onTap,
     child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1516),
        borderRadius: BorderRadius.circular(45),
      ),
      child: const Center(
        child: Text(
          'Sign In',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
     ),
   );
  }


}