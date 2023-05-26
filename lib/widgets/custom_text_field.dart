import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.padding,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        enabled: enabled,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(202, 199, 199, 1000),
          labelStyle: const TextStyle(color: Colors.black),
          labelText: labelText,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    prefixIcon,
                    color: Colors.black,
                    size: 30,
                  ),
                )
              : null,
          border: defBorder(),
          focusedBorder: defBorder(),
        ),
        style: const TextStyle(fontSize: 25),
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }

  OutlineInputBorder defBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        width: 2,
      ),
    );
  }
}
