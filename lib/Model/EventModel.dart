import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  EventModel({
    @required this.title,
    @required this.about,
    @required this.date,
    @required this.xAxis,
    @required this.yAxis,
    @required this.posterUrl,
  });

  String title;
  String about;
  DateTime date;
  double xAxis;
  double yAxis;
  String posterUrl;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent() {
    return _collectionReference
        .doc(title)
        .set({
          'name'    : this.title,
          'about'   : this.about,
          'date'    : this.date,
          'xAxis'   : this.xAxis,
          'yAxis'   : this.yAxis,
          'imageUrl': this.posterUrl,
        })
        .then((value) => print("Event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }
}
