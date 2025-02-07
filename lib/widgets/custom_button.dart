import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  const CustomButton({
    super.key,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(260.sp, 48.sp), // Adjusted button size
        backgroundColor: Colors.black87, // Retained background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r), // Radius applied
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 16.sp, // Adjusted font size
        ),
      ),
    );
  }
}
