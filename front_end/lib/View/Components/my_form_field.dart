import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  const MyFormField({
    super.key,
    required this.text,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null) {
            return 'This Field can not be empty!';
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
