import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({required this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('register'),
          ElevatedButton(
              onPressed: () {
                widget.toggleview();
              },
              child: Text('login'))
        ],
      ),
    );
  }
}
