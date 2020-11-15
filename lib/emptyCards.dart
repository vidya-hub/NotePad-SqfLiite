import 'package:flutter/material.dart';

class EmptyCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:
          // Icon(
          //   Icons.hourglass_empty_sharp,
          //   color: Colors.white,
          //   size: 60,
          // ),
          Text(
        "There is Nothing Here",
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
