import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;

  const StatusIndicator({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: status == 'online' ? Colors.green : Colors.red,
      child: const SizedBox(width: 15, height: 15),
    );
  }
}
