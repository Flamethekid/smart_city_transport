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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('Test')),
        ),
        bottomNavigationBar: BottomNavigationBar(items:
          const[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'user'

            )
          ]),
      ),
    );
  }
}