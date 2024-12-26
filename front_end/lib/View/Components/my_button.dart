import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onTap;
  const MyButton({
    super.key,
    required this.text,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.06,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.022,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
