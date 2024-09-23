import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xff27445e), fontSize: 19),
          ),
        ),
      ),
    );
  }
}
