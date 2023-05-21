import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;

  const Input({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        const TextField(
          keyboardType: TextInputType.text,
          // inputFormatters: [],
          // onChanged: ,
        ),
      ],
    );
  }
}
