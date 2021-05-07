import 'dart:async';

import 'package:events_app/Controllers/LocationController.dart';
import 'package:flutter/material.dart';
import 'package:map_pin_picker/map_pin_picker.dart';

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyMapPicker extends StatefulWidget {
  @override
  _MyMapPickerState createState() => _MyMapPickerState();
}

class _MyMapPickerState extends State<MyMapPicker> {
  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();

  Address address;

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(Provider.of<LocationController>(context).getCurrentLocationXAxis,Provider.of<LocationController>(context).getCurrentLocationYAxis),
      zoom: 1,
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MapPicker(
              iconWidget: Icon(
                Icons.location_pin,
                size: 50,
              ),
              mapPickerController: mapPickerController,
              child: GoogleMap(
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  //Camera Started Moving
                  mapPickerController.mapMoving();
                },
                onCameraMove: (nCameraPosition) {
                  cameraPosition = nCameraPosition;
                },
                onCameraIdle: () async {
                  //Camera Stopped
                  mapPickerController.mapFinishedMoving();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: (){
            Provider.of<LocationController>(context,listen: false).setSelectionBool = true;
            Provider.of<LocationController>(context,listen: false).setSelectedPartyLocationXAxis = cameraPosition.target.latitude;
            Provider.of<LocationController>(context,listen: false).setSelectedPartyLocationYAxis = cameraPosition.target.longitude;
            Provider.of<LocationController>(context,listen: false).setPartyLocationName = 'Alexandria';
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            color: Colors.blue,
            width: 150,
            height: 70,
            child: Center(
              child: Text(
                'Confirm Location',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            // icon: Icon(Icons.directions_boat),
          ),
        ),
      ),
    );
  }
}