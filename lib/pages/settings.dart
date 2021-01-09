import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/widgets/avatar.dart';
import 'package:tukio/widgets/locator.dart';
import 'package:tukio/widgets/user_controller.dart';
import 'package:tukio/widgets/user_model.dart';

class ProfileView extends StatefulWidget with NavigationStates {
  static String route = "profile-view";
  final Function onMenuTap;

  const ProfileView({Key key, this.onMenuTap}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserModel _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    avatarUrl: _currentUser?.avatarUrl,
                    onTap: () async {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);

                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image);

                      setState(() {});
                    },
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                          child: Icon(Icons.menu, color: Colors.black),
                          onTap: widget.onMenuTap),
                      SizedBox(
                        width: 250.0,
                      ),
                      Text(
                          "Hi ${_currentUser.displayName ?? 'nice to see you here.'}!\nLet's Set up a few things here"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Manage Password",
                            style: Theme.of(context).textTheme.display1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Password"),
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "New Password"),
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Repeat Password"),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // TODO: Save somehow
                        Navigator.pop(context);
                      },
                      child: Text("Save Profile"),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
