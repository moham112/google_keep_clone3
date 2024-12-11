import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          ),
          Spacer(),
          Icon(Icons.push_pin_outlined, color: Colors.grey.shade800),
          SizedBox(width: 20),
          Icon(Icons.add_alert_outlined, color: Colors.grey.shade800),
          SizedBox(width: 20),
          Icon(Icons.archive_outlined, color: Colors.grey.shade800),
        ],
      ),
    );
  }
}
