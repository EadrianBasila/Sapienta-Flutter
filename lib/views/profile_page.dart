import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PickedFile _imageFile;
  static ImagePicker _picker = ImagePicker();
  static final TextEditingController textName = TextEditingController();
  static final TextEditingController textAge = TextEditingController();
  static final TextEditingController textAddress = TextEditingController();
  static final TextEditingController textNumber = TextEditingController();
  static final TextEditingController textPosition = TextEditingController();
  static final TextEditingController textSalary = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPref sharedPref = SharedPref();
  ProfileInfo userSave = ProfileInfo();
  ProfileInfo userLoad = ProfileInfo();
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   textName.dispose();
  //   textAge.dispose();
  //   textAddress.dispose();
  //   textNumber.dispose();
  //   textNumber.dispose();
  //   textPosition.dispose();
  //   textSalary.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      ProfileInfo user = ProfileInfo.fromJson(await sharedPref.read("user"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("Data Loaded!"),
          duration: const Duration(milliseconds: 500)));
      setState(() {
        userLoad = user;
      });
    } catch (Excepetion) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text("No Data Available"),
          duration: const Duration(milliseconds: 500)));
    }
  }

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
                    color: CustomColors.menuBackgroundColor,
                    blurRadius: 4,
                    spreadRadius: 4,
                    offset: Offset(1, 1)),
              ],
            ),
            child: CircleAvatar(
              radius: 45.0,
              backgroundImage: userLoad.imagePath == null
                  ? AssetImage('images/profile-default.png')
                  : FileImage(File(userLoad.imagePath)),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _buildSheet()),
                );
              },
              child: Icon(Icons.camera_alt_rounded,
                  color: Colors.deepPurple[900], size: 20.0),
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
        gradient: LinearGradient(
          colors: GradientColors.fresco,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        //borderRadius: BorderRadius.only( topRight: Radius.circular(20),
        //topLeft: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text("Choose Profile Image",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 5),
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
      userSave.imagePath = _imageFile.path;
    });
    Navigator.of(context).pop();
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
          controller: textName,
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userName = value;
            });
          }),
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
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
          controller: textAge,
          keyboardType: TextInputType.number,
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userAge = value;
            });
          }),
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
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
          controller: textAddress,
          style: TextStyle(color: Colors.white, fontSize: 24),
          validator: (String value) {
            if (value.isEmpty) {
              return userLoad.userAddress ?? 'Enter Home Address';
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userAddress = value;
            });
          }),
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
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
          controller: textNumber,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white, fontSize: 24),
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userNumber = value;
            });
          }),
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
              spreadRadius: 2,
              offset: Offset(
                1,
                1,
              )),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
          controller: textPosition,
          style: TextStyle(color: Colors.white, fontSize: 24),
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userPosition = value;
            });
          }),
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
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextFormField(
          controller: textSalary,
          style: TextStyle(color: Colors.white, fontSize: 24),
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
                color: Colors.deepPurple[900],
                size: 24,
              )),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              userSave.userSalary = value;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 42),
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                              userLoad.userName ?? "User",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[900],
                                  fontSize: 22),
                            ),
                            Text(
                              userLoad.userPosition ?? "Position",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primaryTextColor,
                                  fontSize: 16),
                            ),
                            Text(
                              userLoad.userAddress ?? "Home",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primaryTextColor,
                                  fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),                    
                    SizedBox(height: 20.0),              
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

                            sharedPref.save("user", userSave);
                            print("Profile Saved");
                            loadSharedPrefs();
                          },
                          child: Text(
                            'Save Profile',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              primary: Colors.deepPurple[900],
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ),
                        SizedBox(width: 10),
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
            ),
          )
        ]);
  }
}

class ProfileInfo {
  // static String userName = "User Name";
  // static String userAge = "Age";
  // static String userAddress = "Home Address";
  // static String userNumber = "09-XXXXX";
  // static String userPosition = "Work Position";
  // static String userSalary = "150";

  //  ProfileInfo.createProfile(String userName, String userAge, String userAddress,
  //     String userNumber, String userPosition, String userSalary) {
  //   ProfileInfo.userName = userName;
  //   ProfileInfo.userAge = userAge;
  //   ProfileInfo.userAddress = userAddress;
  //   ProfileInfo.userNumber = userNumber;
  //   ProfileInfo.userPosition = userPosition;
  //   ProfileInfo.userSalary = userSalary;
  // }
  // ProfileInfo();

  var imagePath;
  String userName;
  String userAge;
  String userAddress;
  String userNumber;
  String userPosition;
  String userSalary;

  ProfileInfo.createProfile(
      var imagePath,
      String userName,
      String userAge,
      String userAddress,
      String userNumber,
      String userPosition,
      String userSalary) {
    imagePath = imagePath;
    userName = userName;
    userAge = userAge;
    userAddress = userAddress;
    userNumber = userNumber;
    userPosition = userPosition;
    userSalary = userSalary;
  }

  ProfileInfo();

  ProfileInfo.fromJson(Map<String, dynamic> json)
      : imagePath = json['imagePath'],
        userName = json['userName'],
        userAge = json['userAge'],
        userAddress = json['userAddress'],
        userNumber = json['userNumber'],
        userPosition = json['userPosition'],
        userSalary = json['userSalary'];
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'userName': userName,
        'userAge': userAge,
        'userAddress': userAddress,
        'userNumber': userNumber,
        'userPosition': userPosition,
        'userSalary': userSalary,
      };
}

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
