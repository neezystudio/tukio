//check your message chat
import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../widgets/calendar_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditEventForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EditEventFormState();

  final void Function(Map<String, dynamic>) _submitFormCallback;
  final Map _startingData;
  EditEventForm(this._submitFormCallback, this._startingData);
}

class EditEventFormState extends State<EditEventForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // Image Picker
  //List<File> _images = [];
  File _image;
  final picker = ImagePicker(); // Used only if you need a single picture

  Future getImage(bool gallery) async {
    //ImagePicker picker = ImagePicker();
    final PickedFile pickedFile = gallery
        ? await picker.getImage(
            source: ImageSource.gallery,
          )
        : await picker.getImage(
            source: ImageSource.camera,
          );

    setState(() {
      if (pickedFile != null) {
        // _images.add(File(pickedFile.path));
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = _image.path;
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  num _latitude;
  num _longitude;
  final TextEditingController _startTimeController =
      new TextEditingController();
  final TextEditingController _endTimeController = new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  final TextEditingController _latitudeController = new TextEditingController();
  final TextEditingController _longitudeController =
      new TextEditingController();

  @override
  void initState() {
    if (!(widget._startingData == null)) {
      _startTimeController.text = DateFormat(CalendarPickerState.timeFormat)
          .format(widget._startingData["start-time"]);
      _endTimeController.text = DateFormat(CalendarPickerState.timeFormat)
          .format(widget._startingData["end-time"]);
      _titleController.text = widget._startingData["name"];
      _descriptionController.text = widget._startingData["description"];
      _latitudeController.text =
          widget._startingData["location"].latitude.toString();
      _longitudeController.text =
          widget._startingData["location"].longitude.toString();
    }
    super.initState();
  }

  ///Submits the form
  ///
  /// The form fields are first validated, and then the event details are based
  /// to a the [widget._submitFormCallback]
  void submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      widget._submitFormCallback(<String, dynamic>{
        "name": _titleController.text,
        "description": _descriptionController.text,
        "location": new GeoPoint(_latitude, _longitude),
        "start-time":
            CalendarPickerState.stringToDate(_startTimeController.text),
        "end-time": CalendarPickerState.stringToDate(_endTimeController.text)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Form(
          //autovalidate: true,
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new TextFormField(
                  controller: _titleController,
                  decoration: new InputDecoration(
                    labelText: "Event Name",
                    border: new OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val.length < 5 ? "Event name is too short" : null,
                  //onSaved: (val) => _eventName = val,
                ),
              ),
              new TextFormField(
                controller: _descriptionController,
                decoration: new InputDecoration(
                  labelText: "Description",
                  border: new OutlineInputBorder(),
                ),
                validator: (val) => val.isEmpty
                    ? "Event description should not be empty"
                    : null,
                maxLines: 6,
                //onSaved: (val) => _description = val,
              ),
              new CalendarPicker(_startTimeController),
              new CalendarPicker(_endTimeController),
              new Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: new TextFormField(
                  controller: _latitudeController,
                  decoration: new InputDecoration(
                    labelText: "Lattitude",
                    icon: new Icon(Icons.place),
                    border: new OutlineInputBorder(),
                  ),
                  // ignore: deprecated_member_use
                  validator: (val) => double.parse(val, (e) => null) == null
                      ? "Invalid lattitude. Should be number."
                      : null,
                  // ignore: deprecated_member_use
                  onSaved: (val) => _latitude = double.parse(val, (e) => null),
                ),
              ),
              new TextFormField(
                controller: _longitudeController,
                decoration: new InputDecoration(
                  labelText: "Longitude",
                  icon: new Icon(Icons.place),
                  border: new OutlineInputBorder(),
                ),
                validator: (val) => double.parse(val) == null
                    ? "Invalid longitude. Should be number."
                    : null,
                onSaved: (val) => _longitude = double.parse(val),
              ),
              RawMaterialButton(
                fillColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Colors.white,
                ),
                elevation: 8,
                onPressed: () {
                  getImage(true);
                },
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
              ),
              // Container(child: Image.file(File(_image))),
              Container(
                alignment: Alignment.bottomCenter,
                child: _image == null
                    ? Text("Image not loaded")
                    : Image.file((_image)),
              ),
              new MaterialButton(
                onPressed: () => [submitForm(), uploadImageToFirebase(context)],
                child: new Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
