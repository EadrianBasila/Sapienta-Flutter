import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _image;
  String _userName;
  String _userAge;
  String _userAddress;
  String _userNumber;
  String _userPosition;
  String _userSalary;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: CustomColors.menuBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.menuBackgroundColor.withOpacity(0.9),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 45.0,
              backgroundImage: _imageFile == null
                  ? AssetImage('images/profile-default.png')
                  : FileImage(File(_imageFile.path)),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _buildSheet()),
                );
              },
              child: Icon(Icons.camera_alt_rounded,
                  color: Colors.white, size: 25.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFF2D2F41)),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text("Choose Profile Image",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera_rounded, color: Colors.white),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
              ),
              SizedBox(
                width: 15,
              ),
              TextButton.icon(
                icon: Icon(Icons.image_rounded, color: Colors.white),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _buildUsername() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 24),
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Name';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.face_unlock_rounded,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userName = value;
        },
      ),
    );
  }

  Widget _buildAge() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 24),
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Age';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Age',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userAge = value;
        },
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Home Address';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Home',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userAddress = value;
        },
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter a valid Phone Number';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Phone',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userNumber = value;
        },
      ),
    );
  }

  Widget _buildPosition() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Position';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Position',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.badge,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userPosition = value;
        },
      ),
    );
  }

  Widget _buildSalary() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CustomColors.menuBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.menuBackgroundColor.withOpacity(0.9),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter your salary';
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: 'Salary',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
            focusColor: Colors.white,
            isDense: true,
            prefixIcon: Icon(
              Icons.attach_money_rounded,
              color: Colors.white,
              size: 24,
            )),
        onSaved: (String value) {
          _userSalary = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildImage(),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'User Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primaryTextColor,
                                fontSize: 22),
                          ),
                          Text(
                            'Position',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primaryTextColor,
                                fontSize: 16),
                          ),
                          Text(
                            'Salary Grade',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primaryTextColor,
                                fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  _buildUsername(),
                  _buildAge(),
                  _buildAddress(),
                  _buildNumber(),
                  _buildPosition(),
                  _buildSalary(),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          print("Profile Saved");
                        },
                        child: Text(
                          'Save Profile',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            primary: Colors.orange[700],
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'On-Premise DB',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white24,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ]);
  }
}
