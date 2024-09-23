import 'package:flutter/material.dart';

class CustomFormInput extends StatelessWidget {
  CustomFormInput({Key? key, this.onChange, required this.hintText,this.secure = false})
      : super(key: key);
  final String hintText;
  final Function(String)? onChange;
  bool secure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secure,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
