
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'Loading.dart';
import 'SomethingIsWrong.dart';

class HomePage extends StatelessWidget {

  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    var currentCoordinates = await Geolocator.getCurrentPosition();
    return await _getLocationName(Coordinates(currentCoordinates.latitude.toDouble(),currentCoordinates.longitude.toDouble()));
  }

  Future<String> _getLocationName(Coordinates coordinates) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first.countryName;
    return first;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return SomethingWentWrong();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: height*.3,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(height*.3),
                        bottomRight: Radius.circular(height*.3)
                      ),
                      image: DecorationImage(
                        image: AssetImage('images/party.png')
                      )
                    ),
                  ),
                ),
                Positioned(
                  top: height*.25,
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            snapshot.data,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: height*.05
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                Positioned(
                  top: height*.37,
                  width: width,
                  height: height*.55,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*.05),
                    child: ListView(
                      children: [
                        Container(
                          width: width,
                          height: height*.15,
                          padding: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.01),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 1.0,
                                ),
                              ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)

                          ),
                          child: Row(
                            children: [
                              Container(
                                height:height,
                                width: width*.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage('images/partyposter.jpg')
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Loading();
      },
    );
  }
}
