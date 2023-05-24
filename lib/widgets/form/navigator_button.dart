import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  final Widget destinationScreen;
  final String text;

  const NavigatorButton({
    super.key,
    required this.destinationScreen,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(56, 96, 255, 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(238, 240, 249, 0.7),
              offset: Offset(5, 5),
              blurRadius: 30,
            )
          ]),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destinationScreen,
              ));
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(56, 96, 255, 1)),
        ),
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
