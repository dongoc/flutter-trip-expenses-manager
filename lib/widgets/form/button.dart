import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;
  final Color backgroundColor;

  const BasicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.backgroundColor = const Color.fromRGBO(56, 96, 255, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: disabled ? Colors.black26 : backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: const ButtonStyle(),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
