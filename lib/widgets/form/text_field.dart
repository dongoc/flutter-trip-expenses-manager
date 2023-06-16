import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final String initialValue;
  final TextInputType type;

  const Input({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator,
    this.initialValue = '',
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          keyboardType: type,
          onChanged: onSaved,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
