import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../constants.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:location/location.dart';



class TheaterTrackingPage extends StatefulWidget {
  const TheaterTrackingPage({Key? key}) : super(key: key);
  
  @override
  State<TheaterTrackingPage> createState() => TheaterTrackingPageState();
}

class TheaterTrackingPageState extends State<TheaterTrackingPage> {
  int _currentIndex = 2;
  // final Completer<GoogleMapController> _controller = Completer();
  
  static const LatLng sourceLocation = LatLng(25.0412678, 121.5661076);
  static const LatLng destination = LatLng(25.0362387, 121.5650377);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then( (location) {
        currentLocation = location;
    });
  }

  // GoogleMapController googleMapController = await _controller.future;

  
  void getPolyPoints() async {
  // PolylinePoints polylinePoints = PolylinePoints();
  // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //   googleApiKey,
  //   PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //   PointLatLng(destination.latitude, destination.longitude),
  // );
  // if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  // }
}

@override
void initState() {
  getPolyPoints();
  getCurrentLocation();
  super.initState();
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
      ? const Center(child: Text("Loading"))
      :GoogleMap(
        initialCameraPosition: 
        CameraPosition(
          target: LatLng(
            currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 13.5,
        ),
        markers: {
          Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
        ),
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
        onMapCreated: (mapController) {
          // _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: const Color(0xFF7B61FF),
            width: 6,
          ),
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (_currentIndex == 2) {
              Navigator.pushNamed(context, '/maps');
            } else if (_currentIndex == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          });
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}