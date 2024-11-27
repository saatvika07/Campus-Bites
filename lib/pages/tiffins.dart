import 'package:flutter/material.dart';

class TiffinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fast Food"),
      ),
      body: Center(
        child: Text(
          "Welcome to the Fast Food Page!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
