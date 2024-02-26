import 'package:flutter/material.dart';

Color credit = const Color.fromARGB(255, 2, 97, 5);
// Color credit = Color.fromARGB(255, 2, 53, 4);
// Color debit = const Color.fromARGB(255, 154, 3, 3);
Color debit = const Color.fromARGB(255, 166, 15, 15);
Color textSmall = const Color(0XffB6B6B6);
Color black = const Color.fromARGB(255, 42, 42, 42);

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(16),
      content: Text(content, style: const TextStyle(fontSize: 20, color: Color.fromARGB(215, 255, 255, 255)),),
      backgroundColor: content == "success"?const Color.fromARGB(255, 51, 120, 86):const Color.fromARGB(255, 167, 54, 54),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
    ),
  );
}
