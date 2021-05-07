import 'package:events_app/Views/Screens/EventScreen.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    @required this.width,
    @required this.height,
    @required this.date,
    @required this.place,
    @required this.name,
    @required this.imageUrl,
    @required this.organizer,
    @required this.about,
    @required this.latitude,
    @required this.longitude,
  });

  final double width;
  final double height;
  final double latitude;
  final double longitude;
  final String date;
  final String place;
  final String name;
  final String imageUrl;
  final String about;
  final String organizer;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventScreen(date: date,longitude: longitude,latitude: latitude, place: place, organizer: organizer, about: about, name: name, imageUrl: imageUrl)),
        );
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
                      image: NetworkImage(imageUrl),
                  fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: height * .022),
                ),
                Text(
                  name,
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
                      place,
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
