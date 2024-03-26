import 'package:flutter/material.dart';

//TODO
/*
1:allow the textfield to take an input
2:create onenter function for hiding textfield
3:find API for the map functionalities
4:create the logic for the map function to take the input in text box
5:allow api to show routes for carpool, bus and bike
6:(optional) allow textfield to auto complete entered location
*/

void main() {
  runApp(const MaterialApp(
    title: 'Smart City',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('Test')),
        ),
        body: const Center(
          child: Stack(children: [
            /*The whole section with the Image is a placeholder, 
            this will be removed when the API for the map app 
            is ready to be used*/
            Image(
              image: AssetImage('images/map.png'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  constraints: BoxConstraints(maxWidth: 200.0),
                  hintText: "Enter location",
                ),
              ),
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user')
        ]),
      ),
    );
  }
}
