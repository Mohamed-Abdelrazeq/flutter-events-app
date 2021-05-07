import 'package:events_app/Views/Component/MyButton.dart';
import 'package:events_app/Views/Screens/MapDirections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {

  const EventScreen({
    @required this.date,
    @required this.place,
    @required this.organizer,
    @required this.about,
    @required this.name,
    @required this.imageUrl,
    @required this.latitude,
    @required this.longitude,
  });

  final String date;
  final String place;
  final String organizer;
  final String about;
  final String name;
  final String imageUrl;
  final double latitude;
  final double longitude;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * .4,
                width: width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 50.0,
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
              ),
              Container(
                height: height * .6,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ////////////Title
                          SizedBox(
                            height: height * .02,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: height * .06,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          ////////////////About
                          Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * .04,
                            ),
                          ),
                          Container(
                            width: width * .2,
                            child: Divider(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Text(
                            about,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: height * .025,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          Container(
                            width: width * .7,
                            child: Divider(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          /////////////////
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * .05,
                                    vertical: height * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white,
                                  size: width * .07,
                                )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                date,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height * .03,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          ////////////////
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * .05,
                                    vertical: height * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: width * .07,
                                )),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                place,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height * .03,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          ////////////
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * .05,
                                    vertical: height * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Icon(
                                  Icons.account_circle,
                                  size: width * .07,
                                      color: Colors.white,
                                )),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                organizer,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height * .03,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .13,
                          ),
                          ////////////
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: height * .9,
            child: Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      width: width*.4,
                      height: height,
                      myText: 'GO NOW!',
                      myFunc: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapDirections(latitude: latitude, longitude: longitude)),
                        );
                      },
                      horizontalPadding: 0,
                      verticalPadding: height * .02,
                      myTextColor: Colors.white,
                      myButtonColor: Colors.blue),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
