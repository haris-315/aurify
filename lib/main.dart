import 'package:flutter/material.dart';

void main() {
  runApp(const Musicate());
}

class Musicate extends StatelessWidget {
  const Musicate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Text("Hello!"),
    );
  }
}
