import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/sharedpref.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

bool alreadyHaveAnAccount = false;

class _BodyState extends State<Body> {
  Map intentData = {};
  File file;
  final picker = ImagePicker();

  void _selectImage() async {
    try {
      final pickedFileCamera =
          await picker.getImage(source: ImageSource.camera);
      final pickedFileGallery =
          await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFileCamera != null) {
          file = File(pickedFileCamera.path);
          print("$file");
        } else
          print("No image selected");
      });
    } catch (e) {
      print("$e");
    }
  }
  bool passwordCheck = false;
  @override
  Widget build(BuildContext context) {
    intentData = ModalRoute.of(context).settings.arguments;
    String name;
    String email;
    bool loginStatus;
    if (intentData != null) {
      name = intentData['userName'];
      email = intentData['userMail'];
      loginStatus = intentData['loginStatus'];
    }
    return Container(
      child: profileView(name, email, loginStatus),
    );
  }

  Widget profileView(String name, String email, bool loginStatus) {
    TextEditingController userName = TextEditingController();
    TextEditingController userMail = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    TextEditingController loginPassword = TextEditingController();
    TextEditingController loginMail = TextEditingController();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Profiles details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(height: 24, width: 24)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 30, 5),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                  radius: 50,
                  child: loginStatus != null && false
                      ? ClipOval(
                          child: Image.asset(
                            'images/girl.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          name != null && name != ""
                              ? name[0].toUpperCase()
                              : LETSKHAREEDO[0].toUpperCase(),
                          style: TextStyle(fontSize: 64),
                        )),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: GestureDetector(
                    onTap: () {
                      _selectImage();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: APPLICATION_DRAWER_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)])),
          child: Column(
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginStatus != null && loginStatus ?
                        Text(
                          name != null && name != "" ? name : LETSKHAREEDO,
                          style: TextStyle(color: Colors.white70),
                        ) : TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Name",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
                visible: !alreadyHaveAnAccount,
              ),
              Visibility(
                visible: !alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginStatus != null && !loginStatus ?
                        Text(
                          'Email',
                          style: TextStyle(color: Colors.white70),
                        ) : TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              Visibility(
                visible: !alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginStatus != null && loginStatus ?
                        Text(
                          'Address',
                          style: TextStyle(color: Colors.white70),
                        ) : TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Address",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              Visibility(
                visible: !alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  loginStatus != null && loginStatus ?
                        Text(
                          'Phone number',
                          style: TextStyle(color: Colors.white70),
                        ) : TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              Visibility(
                visible: !alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              Visibility(
                visible: alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email or username",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              Visibility(
                visible: alreadyHaveAnAccount,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.0, color: Colors.white70)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !alreadyHaveAnAccount,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        alreadyHaveAnAccount = true;
                      });
                    },
                    child: Text(
                      "Already have an account",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
              ),
              Visibility(
                visible: alreadyHaveAnAccount,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        alreadyHaveAnAccount = false;
                      });
                    },
                    child: Text(
                      "Create new account",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 70,
                    width: 200,
                    child: Align(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white70, fontSize: 20),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: APPLICATION_DRAWER_COLOR,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        )),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
