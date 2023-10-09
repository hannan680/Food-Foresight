import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final String hintText;
  final Color cursorColor;
  final String? errorText;
  final bool isObsureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value)? onChange;

  const CustomFormField({
    required this.label,
    this.prefixIcon,
    required this.hintText,
    this.cursorColor = Colors.black,
    this.errorText,
    this.onChange,
    this.controller,
    this.isObsureText = false,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isObsureText,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
          cursorColor: cursorColor,
          decoration: InputDecoration(
            errorText: errorText,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
