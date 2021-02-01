import 'dart:io';

import 'package:events_app/Controllers/AddEventProvider.dart';
import 'package:events_app/Views/Component/MyTextField.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();

}

class _AddEventScreenState extends State<AddEventScreen> {

  @override
  void initState() {
    summaryController.clear();
    titleController.clear();
    _image = null;
    super.initState();
  }

  final TextEditingController summaryController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  final flushBarColor = Colors.blue;

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void submissionFunction(var context) async {
    //Close Keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    //Check textfields
    if (summaryController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your About",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (titleController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your Title",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (_image == null) {
      Flushbar(
        title: "Warning",
        message: "Pick Poster",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    }
    else if(Provider.of<AddEventProvider>(context,listen: false).eventDate == DateTime.now()){
      Flushbar(
        title: "Warning",
        message: "Enter your Date",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    }//else if (){
    //  print('blu');
    //  todo add place check
    //}
    //else if (){
    //  print('blu');
    //  todo add poster
    //}
    else{
      //todo add to firebase
      Provider.of<AddEventProvider>(context,listen: false).dateSetter(DateTime.now());
      summaryController.clear();
      titleController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Stack(
          children:[
            Container(
            padding: EdgeInsets.only(
                left: width * .05,right: width * .05),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: height*.05,),
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
                           Provider.of<AddEventProvider>(context,listen: false).dateSetter(date);
                         }, onConfirm: (date) {
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
                      Provider.of<AddEventProvider>(context).eventDate.toString().replaceRange(10,Provider.of<AddEventProvider>(context).eventDate.toString().length, ''),
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
                  height: height * .02,
                ),
                Text(
                  'Poster',
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
                    getImage();
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
                        _image == null ? 'Pick Poster' : 'Image Selected',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),),
                SizedBox(
                  height: height * .16,
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
                  submissionFunction(context);
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
                      style: TextStyle(color: Colors.blue,fontSize: height*.03),
                    ),
                  ),
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
