import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool disabled;

  const FloatingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: const ButtonStyle(),
        child: Text(text),
      ),
    );
  }
}
