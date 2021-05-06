import 'package:events_app/Controllers/LocationController.dart';
import 'package:events_app/Views/Component/EventCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Loading.dart';
import 'SomethingIsWrong.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: Provider.of<LocationController>(context,listen: false).getCurrentLocation(),
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
                          organizer: 'John Smith',
                          about:'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec,',
                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Metal Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partyposter2.jpg',
                          organizer: 'John Smith',
                          about:'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec,',

                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Pop Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partposter3.jpg',
                          organizer: 'John Smith',
                          about:'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec,',

                        ),
                        EventCard(
                          width: width,
                          height: height,
                          name: 'Rock Party',
                          date: '1 Feb,2021',
                          place: 'Alexandria Great hall',
                          imageUrl: 'images/partposter4.jpg',
                            organizer: 'John Smith',
                            about:'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec,',

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

