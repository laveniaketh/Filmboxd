import 'package:flutter/material.dart';

class MyButtonLight extends StatelessWidget {
  final String buttonText;
  final String? imagePath;

  final Function()? onTap;

  const MyButtonLight({
    super.key,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
  });

  
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 30),
     child: GestureDetector(
      onTap: onTap,
       child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0E6),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Image(
                  image: AssetImage(imagePath!),
                  height: 30,
                  width: 30,
                ),
              ),
            Text(
              buttonText,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF1F1516),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
     
        
       ),
     ),
   );
  }


}