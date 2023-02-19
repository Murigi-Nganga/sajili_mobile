import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIconData,
    required this.onChanged,
    required this.validator,
    this.errorText,
    this.autoFocus = false,
    this.obscureText = false,
    this.capitalizeText = false,
  });

  final Function onChanged;
  final TextInputType keyboardType;
  final String labelText;
  final IconData prefixIconData;
  final bool obscureText;
  final bool capitalizeText;
  final bool autoFocus;
  final String? Function(String?) validator;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged(value),
      keyboardType: keyboardType,
      obscureText: obscureText,
      autofocus: autoFocus,
      validator: validator,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIconData),
        labelText: labelText,
        errorText: errorText,
      ),
      textCapitalization:
          capitalizeText ? TextCapitalization.words : TextCapitalization.none,
    );
  }
}
