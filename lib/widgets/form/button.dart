import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool disabled;

  const BasicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
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
        color: Theme.of(context).primaryColor,
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
