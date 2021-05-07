import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventModel {
  EventModel({
    this.title,
    this.about,
    this.location,
    this.organizer,
    this.date,
    this.xAxis,
    this.yAxis,
    this.posterUrl,
  });

  String title;
  String about;
  String location;
  String organizer;
  double xAxis;
  double yAxis;
  DateTime date;
  String posterUrl;

  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('events');

  Future<void> addEvent() {
    return _collectionReference
        .doc(title)
        .set({
          'name'     : this.title,
          'about'    : this.about,
          'date'     : this.date,
          'xAxis'    : this.xAxis,
          'yAxis'    : this.yAxis,
          'imageUrl' : this.posterUrl,
          'location' : this.location,
          'organizer': this.organizer
        })
        .then((value) => print("Event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }

  String dateFormat(Timestamp stampTime){
    var date = DateTime.fromMillisecondsSinceEpoch(stampTime.millisecondsSinceEpoch);
    var formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate;
  }

}
