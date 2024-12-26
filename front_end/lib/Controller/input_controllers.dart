import 'package:flutter/material.dart';

class InputControllers {
  //  text input controllers
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  //  loading value
  bool loading = false;
  //  form state key
  final formKey = GlobalKey<FormState>();
}
