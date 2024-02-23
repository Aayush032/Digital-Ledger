import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController editingController;
  final bool isPass;
  final TextInputType type;
  final String? Function(String?)? validator;
  const CustomTextField(
    {
      super.key,
       required this.label,
        required this.icon,
         required this.editingController, 
         this.isPass = false,
          required this.type, 
          required this.validator,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 56, 29, 29),
        filled: true,
        label: Text(label),
        labelStyle: const TextStyle(color: Colors.white60),
        suffixIcon: Icon(icon, color: Colors.white60,),
        focusColor: Colors.blue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
      obscureText: isPass,
      keyboardType: type,
      validator: validator,
    );
  }
}