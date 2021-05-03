import 'dart:async';

import 'package:events_app/Controllers/MyLocationController.dart';
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
      target: LatLng(Provider.of<MyLocationController>(context).x,Provider.of<MyLocationController>(context).y),
      zoom: 1,
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MapPicker(
              // pass icon widget
              iconWidget: Icon(
                Icons.location_pin,
                size: 50,
              ),
              //add map picker controller
              mapPickerController: mapPickerController,
              child: GoogleMap(
                zoomControlsEnabled: true,
                // hide location button
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving();
                },
                onCameraMove: (nCameraPosition) {
                  cameraPosition = nCameraPosition;
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving();
                  //get address name from camera position
                  List<Address> addresses = await Geocoder.local
                      .findAddressesFromCoordinates(Coordinates(
                      cameraPosition.target.latitude,
                      cameraPosition.target.longitude));
                  // update the ui with the address
                  textController.text = '${addresses.first?.addressLine ?? ''}';
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: GestureDetector(
          onTap: (){
            print(cameraPosition.target.latitude);
            print(cameraPosition.target.longitude);
            Provider.of<MyLocationController>(context,listen: false).selectionStateSetter(true);
            Provider.of<MyLocationController>(context,listen: false).partyLocationSetter(cameraPosition.target.latitude, cameraPosition.target.longitude);
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