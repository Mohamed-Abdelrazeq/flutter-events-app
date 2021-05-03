import 'package:cloud_firestore/cloud_firestore.dart';

class EventData{
  CollectionReference events = FirebaseFirestore.instance.collection('events');

  Future<void> addEvent(String name,String about,String date,String xAxis,String yAxis,imageUrl,String host,) {
    return events
        .doc(date)
        .set({
      'name':name,
      'about': about ,
      'date': date,
      'xAxis': yAxis ,
      'imageUrl': imageUrl ,
      'host': host,
    })
        .then((value) => print("Event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }

}