import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Todo
/*
1:allow the textfield to take an input - half done
2:create onenter function for hiding textfield - done
3:find API for the map functionalities - done
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

bool isRowvisible = true;

class _MyHomePageState extends State<MyHomePage> {
  static const googleplex = LatLng(7.3494412065570565, -2.3430129529877455);
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('Test')),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Stack(children: [
                  //Google map stuff goes here
                  const SizedBox(
                    height: 500,
                    child: GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: googleplex, zoom: 13)),
                  ),

                  //this Row is to be hidden when map opens
                  Visibility(
                    visible: isRowvisible,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          heightFactor: 9.00,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Icon(Icons.add_location_alt),
                          ),
                        ),
                        const Center(
                          heightFactor: 9.00,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              constraints: BoxConstraints(maxWidth: 200),
                              hintText: "Enter location",
                            ),
                          ),
                        ),
                        Center(
                          heightFactor: 9.00,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isRowvisible = false;
                                });
                              },
                              child: const Icon(Icons.arrow_circle_right)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user')
          ],
          onTap: (int index) {
            if (index == 0) {
              setState(() {
                isRowvisible = true;
              });
            } else if (index == 1) {
              setState(() {
                isRowvisible = false;
              });
            }
          },
        ),
      ),
    );
  }
}
