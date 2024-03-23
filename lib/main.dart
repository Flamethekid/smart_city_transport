import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Smart City',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Test UI'),),
      ),
    );
  }
}