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
    return await _getLocationName(Coordinates(
        currentCoordinates.latitude.toDouble(),
        currentCoordinates.longitude.toDouble()));
  }

  Future<String> _getLocationName(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
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
                    height: height * .3,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(height * .3),
                            bottomRight: Radius.circular(height * .3)),
                        image: DecorationImage(
                            image: AssetImage('images/party.png'))),
                  ),
                ),
                Positioned(
                  top: height * .25,
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
                                fontSize: height * .05),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height * .36,
                  width: width,
                  height: height * .58,
                  child: Padding(
                    padding: EdgeInsets.only(right: width * .05,left: width * .05),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Rock Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partyposter.jpg',
                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Rock Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partyposter.jpg',
                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Rock Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partyposter.jpg',
                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Rock Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partyposter.jpg',
                        ),
                        SizedBox(height: 20,),
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

class EventCard extends StatelessWidget {
  const EventCard({
    @required this.width,
    @required this.height,
    @required this.date,
    @required this.place,
    @required this.name,
    @required this.imageUrl,
  });

  final double width;
  final double height;
  final String date;
  final String place;
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/EventScreen');
      },
      child: Container(
        width: width,
        height: height * .18,
        margin: EdgeInsets.only(bottom: 12),
        padding:
            EdgeInsets.symmetric(horizontal: width * .02, vertical: height * .01),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 1.0,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              height: height,
              width: width * .3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage('images/partyposter.jpg'))),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 Feb, 2021',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: height * .022),
                ),
                Text(
                  'Rock Party',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: height * .03),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.blue,
                    ),
                    Text(
                      'Alexandria Great hall',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w300,
                          fontSize: height * .022),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
