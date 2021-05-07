import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/Controllers/LocationController.dart';
import 'package:events_app/Model/EventModel.dart';
import 'package:events_app/Views/Component/EventCard.dart';
import 'package:events_app/Views/Component/Spanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Loading.dart';
import 'SomethingIsWrong.dart';

class HomePage extends StatelessWidget {
  final CollectionReference _eventsCollectionReference =
      FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: Provider.of<LocationController>(context, listen: false)
          .getCurrentLocation(),
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
                    padding: EdgeInsets.only(right: width * .05, left: width * .05),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _eventsCollectionReference.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return spanner;
                        }
                        return ListView(
                          physics: BouncingScrollPhysics(),
                          children: snapshot.data.docs.map((DocumentSnapshot document){
                            Map<String, dynamic> data = document.data();
                            String date = EventModel().dateFormat(document.data()['date']);
                            String location = data['location'];
                            String organizer =  data['organizer'];
                            String about =  data['about'];
                            String name = data['name'];
                            String imageUrl = data['imageUrl'];
                            double latitude  =  data['xAxis'];
                            double longitude = data['yAxis'];
                            return EventCard(width: width, height: height,latitude: latitude,longitude: longitude, date: date, place: location, name: name, imageUrl: imageUrl, organizer: organizer, about: about);
                          }).toList(),
                        );
                      },
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
