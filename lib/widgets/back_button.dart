import 'package:flutter/material.dart';

class BackButttonWidget extends StatelessWidget {
  final Color color;
  final Color bgColor;
  const BackButttonWidget({
    Key? key,
    required this.color,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: bgColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back_ios, color: color),
        ),
      ),
    );
  }
}
