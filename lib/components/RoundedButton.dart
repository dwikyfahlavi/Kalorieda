import 'package:flutter/material.dart';
import 'package:kalorieda/components/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onpressed;

  RoundedButtonWidget({
    required this.buttonText,
    required this.width,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            createMaterialColor(Color.fromARGB(136, 73, 202, 81)),
            createMaterialColor(Color(0xff27A52F)),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(0, 255, 255, 255)),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: () {
          onpressed();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
