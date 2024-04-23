import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

//Todo
/*
1:allow the textfield to take an input - done
2:create onenter function for hiding textfield - done
3:find API for the map functionalities - done
4:create the logic for the map function to take the input in text box done
5:allow api to show routes for carpool, bus and bike fail
6:(optional) allow textfield to auto complete entered location- done
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

late final GoogleMapController mapController;

TextEditingController textController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  //final locationController = Location();
  final textController = TextEditingController();
  static const _googleplex = LatLng(7.3494412065570565, -2.3430129529877455);
  static const _googleplex2debug =
      LatLng(7.345355161899005, -2.343281173854657);
  var _defaultMarker = const LatLng(7.3494412065570565, -2.3430129529877455);

  //LatLng? currentPosition;

  Map<PolylineId, Polyline> polylines = {};

  static const googleplex = CameraPosition(
      target: LatLng(7.3494412065570565, -2.3430129529877455), zoom: 15);

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    //await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('Test')),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              //Google map stuff goes here
              SizedBox(
                height: 758,
                width: double.infinity,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  mapType: MapType.hybrid,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: googleplex,
                  markers: {
                    const Marker(
                        markerId: MarkerId('currentLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _googleplex),
                    const Marker(
                        markerId: MarkerId('secondLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _googleplex2debug)
                  },
                  polylines: Set<Polyline>.from(polylines.values),
                ),
              ),

              SizedBox(
                child: SearchMapPlaceWidget(
                  apiKey: "AIzaSyCAsma6K8826Qsj4iX9sRFc3y2_xHJhSuo",
                  bgColor: Colors.white,
                  location:
                      const LatLng(7.3494412065570565, -2.3430129529877455),
                  radius: 2000,
                  textColor: Colors.black,
                  strictBounds: true,
                  onSelected: (place) {
                    _defaultMarker = place.fullJSON['geometry']['location'];
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => mapController
              .animateCamera(CameraUpdate.newCameraPosition(googleplex)),
          child: const Icon(Icons.center_focus_strong),
        ),
        /*bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user')
          ],
          /* onTap: (int index) {
            if (index == 0) {
              setState(() {
                isRowvisible = true;
              });
            } else if (index == 1) {
              setState(() {
                isRowvisible = false;
              });
            }
          },*/
        ),*/
      ),
    );
  }

  /*Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
      }
    });
  }*/

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCAsma6K8826Qsj4iX9sRFc3y2_xHJhSuo",
        PointLatLng(_googleplex.latitude, _googleplex.longitude),
        PointLatLng(_googleplex2debug.latitude, _googleplex2debug.longitude));

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint('no points found');
      return [];
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.redAccent,
      width: 5,
      points: polylineCoordinates,
    );
    setState(() => polylines[id] = polyline);
  }
}
