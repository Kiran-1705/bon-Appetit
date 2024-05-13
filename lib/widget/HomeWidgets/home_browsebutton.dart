import 'package:flutter/material.dart';

class BrowseButton extends StatelessWidget {
  final String buttonText;
  final Widget destination;
  final double width;

  const BrowseButton({
    Key? key,
    required this.buttonText,
    required this.destination,
    this.width = 345,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => destination));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Colors.black),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 23,
              fontFamily: 'RalewayVariableFont',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
