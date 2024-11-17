import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? imagePath;
  

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: const BorderSide(
              color: Color(0xFFF3F0E6),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: const BorderSide(
              color: Color(0xFF1F1516),
            ),
          ),
          prefixIcon: imagePath != null
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image(
                    image: AssetImage(imagePath!),
                    height: 30,
                    width: 30,
                  ),
                )
              : null,
          fillColor: const Color(0xFFF3F0E6),
          filled: true,
          
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF1F1516),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ), 
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF1F1516),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}