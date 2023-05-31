import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;

  const Input({
    super.key,
    required this.label,
    required this.onSaved,
    required this.validator,
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
          keyboardType: TextInputType.text,
          onSaved: onSaved,
          validator: validator,
          // inputFormatters: [],
          // onChanged: ,
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
