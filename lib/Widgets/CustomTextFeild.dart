import 'package:flutter/material.dart';
import 'package:image_mania/colors.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
     this.title="",
     this.icon=Icons.text_fields,
     this.hint="",
     this.controller,
  });
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          label: Text(title),
          prefixIcon: Icon(icon, color: colorFeild),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: colorBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: colorBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: colorBorder),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
