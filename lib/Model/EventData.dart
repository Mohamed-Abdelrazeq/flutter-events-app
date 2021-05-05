import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  EventModel({
    @required this.name,
    @required this.about,
    @required this.date,
    @required this.xAxis,
    @required this.yAxis,
    @required this.imageUrl,
    @required this.host,
  });

  String name;
  String about;
  String date;
  String xAxis;
  String yAxis;
  String imageUrl;
  String host;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent() {
    return _collectionReference
        .doc(date)
        .set({
          'name'    : this.name,
          'about'   : this.about,
          'date'    : this.date,
          'xAxis'   : this.xAxis,
          'yAxis'   : this.yAxis,
          'imageUrl': this.imageUrl,
          'host'    : this.host,
        })
        .then((value) => print("Event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }
}
