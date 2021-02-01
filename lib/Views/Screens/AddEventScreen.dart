import 'package:events_app/Controllers/DateProvider.dart';
import 'package:events_app/Views/Component/MyTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatelessWidget {
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children:[
          Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * .04),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Event',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .05,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * .2),
                child: Divider(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                'Title',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .04,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * .02,
              ),
              MyTextField(
                  myColor: Colors.blue,
                  myController: titleController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'Event Title',
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                'About',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .04,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * .02,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * .02)),
                child: Center(
                  child: TextField(
                    controller: summaryController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'About Your Event',
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 30, top: 30, right: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                'Date',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .04,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * .02,
              ),
              FlatButton(
              onPressed: () {
                   DatePicker.showDatePicker(context,
                       showTitleActions: true,
                       minTime: DateTime(2021, 1, 1),
                       maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                         Provider.of<DateProvider>(context,listen: false).dateSetter(date);
                       }, onConfirm: (date) {
                         Provider.of<DateProvider>(context,listen: false).dateSetter(date);
                       }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                width: width,
                height: height*.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text(
                    Provider.of<DateProvider>(context).eventDate.toString().replaceRange(10, 23, ''),
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),),
              SizedBox(
                height: height * .02,
              ),
              Text(
                'Location',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .04,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * .02,
              ),
              FlatButton(
                onPressed: () {
                  //TODO Pick location
                },
                child: Container(
                  width: width,
                  height: height*.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      'Pick Place',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),),
              SizedBox(
                height: height * .12,
              ),
            ],
          ),
        ),
          Positioned(
            top: height*.87,
            width: width,
            child: FlatButton(
              onPressed: () {
                //TODO Add Event
                //TODO check fields
              },
              child: Container(
                width: width*.8,
                height: height*.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text(
                    'Add Event',
                    style: TextStyle(color: Colors.black54,fontSize: height*.03),
                  ),
                ),
              ),),
          ),
        ],
      ),
    );
  }
}
