import 'package:flutter/material.dart';

void main() {
  runApp(const CodeTest());
}

class CodeTest extends StatefulWidget {
  const CodeTest({super.key});

  @override
  State<CodeTest> createState() => _CodeTestState();
}

class _CodeTestState extends State<CodeTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const Drawer(
          backgroundColor: Color.fromARGB(66, 18, 26, 61),
        ),
        backgroundColor: const Color.fromARGB(255, 35, 79, 221),
        appBar: AppBar(
          title: const Text(
            "Code Test",
            selectionColor: Color.fromARGB(255, 13, 42, 167),
          ),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
