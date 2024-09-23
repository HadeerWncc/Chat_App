import 'package:flutter/material.dart';

class ShowSnackbar{
   ShowSnackbar({Key? key});
static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}