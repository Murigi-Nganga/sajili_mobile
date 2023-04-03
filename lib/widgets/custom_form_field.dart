import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIconData,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  });

  final Function onChanged;
  final TextInputType keyboardType;
  final String labelText;
  final IconData prefixIconData;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged(value),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      textInputAction: textInputAction,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIconData,
        ),
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
