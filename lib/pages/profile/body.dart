import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letskhareedo/ModelView/Model/userprofile/userprofileModel.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/sharedpref.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

bool alreadyHaveAnAccount = false;
bool iHaveTheImage = false;

class _BodyState extends State<Body> {
  Map intentData = {};
  File file;
  final picker = ImagePicker();
  String image;


  void _selectImage(bool check) async {
    try {
      if (check) {
        final pickedFileCamera =
            await picker.getImage(source: ImageSource.camera);
        setState(() {
          if (pickedFileCamera != null) {
            file = File(pickedFileCamera.path);
            image = base64Encode(file.readAsBytesSync());
            iHaveTheImage = true;
          } else
            print("No image selected");
        });
      } else {
        final pickedFileGallery =
            await picker.getImage(source: ImageSource.gallery);
        setState(() {
          if (pickedFileGallery != null) {
            file = File(pickedFileGallery.path);
            image = base64Encode(file.readAsBytesSync());
            iHaveTheImage = true;
          } else
            print("No image selected");
        });
      }
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
    String image;
    String imageName;
    if (intentData != null) {
      name = intentData['userName'];
      email = intentData['userMail'];
      loginStatus = intentData['loginStatus'];
      image = intentData['image'];
      imageName = intentData['imageName'];
    }
    Fluttertoast.showToast(msg: "$loginStatus");

    return Container(
      child: profileView(name, email, loginStatus, image, imageName),
    );
  }

  Widget profileView(String name, String email, bool loginStatus, String imageFromIntent, String imageName) {
    if(loginStatus == null)
      loginStatus = false;
    SharedPrefs sharedPrefs = SharedPrefs();
    WebRepo webRepo = WebRepo();
    Uint8List toImage;
    TextEditingController userName = TextEditingController();
    TextEditingController userMail = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    TextEditingController loginPassword = TextEditingController();
    TextEditingController loginMail = TextEditingController();
    if (file != null) {
      if (file.readAsBytesSync() != null) {
        if (iHaveTheImage) {
          if(image != null && image != "")
            toImage = base64Decode(image);
          else toImage = base64Decode(imageFromIntent);
        }
      }
    }
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
                  radius: 70,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: toImage != null ?
                        MemoryImage(toImage) : AssetImage('assets/letskhareedoLogo.jpeg')
                      ),
                    ),
                  )
                        ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: GestureDetector(
                    onTap: () {
                      showDialogBox();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
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
          child: ListView(
            children: [
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginStatus != null && loginStatus
                            ? Text(
                                name != null && name != ""
                                    ? name
                                    : LETSKHAREEDO,
                                style: TextStyle(color: Colors.white70),
                              )
                            : TextField(
                                controller: userName,
                                keyboardType: TextInputType.name,
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
                        child: loginStatus != null && loginStatus
                            ? Text(
                                'Email',
                                style: TextStyle(color: Colors.white70),
                              )
                            : TextField(
                                controller: userMail,
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
                        child: loginStatus != null && loginStatus
                            ? Text(
                                'Address',
                                style: TextStyle(color: Colors.white70),
                              )
                            : TextField(
                                controller: address,
                                keyboardType: TextInputType.streetAddress,
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
                visible: !alreadyHaveAnAccount && !loginStatus,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "PhoneNumber",
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
                        child: loginStatus != null && loginStatus
                            ? Text(
                                'Phone number',
                                style: TextStyle(color: Colors.white70),
                              )
                            : TextField(
                                controller: password,
                                keyboardType: TextInputType.visiblePassword,
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
                visible: !alreadyHaveAnAccount && !loginStatus,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Container(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: confirmPassword,
                          keyboardType: TextInputType.visiblePassword,
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
                          controller: loginMail,
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
                          controller: loginPassword,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      if (alreadyHaveAnAccount) {
                        if (loginMail.text != "" &&
                            loginMail.text != null &&
                            loginPassword.text != "" &&
                            loginPassword.text != null) {
                          webRepo
                              .login(loginMail.text, loginPassword.text)
                              .then((value) {
                            Fluttertoast.showToast(
                                msg: "${value.name}", toastLength: Toast.LENGTH_SHORT);
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Login field empty",
                              toastLength: Toast.LENGTH_SHORT);
                        }
                      } else {
                        String imageName;
                        if(file != null) {
                          image = base64Encode(file.readAsBytesSync());
                          imageName = file.path.split("/").last;
                        }else {
                          image = "";
                          imageName = "";
                        }
                        if (password.text != null &&
                            confirmPassword.text != null &&
                            password.text != "" &&
                            confirmPassword.text != "") {
                          if (password.text == confirmPassword.text) {
                            if (image != null &&
                                // image != "" &&
                                imageName != null &&
                                // imageName != "" &&
                                userName.text != null &&
                                userName.text != "" &&
                                userMail.text != null &&
                                userMail.text != "" &&
                                address.text != null &&
                                address.text != "" &&
                                phoneNumber.text != null &&
                                phoneNumber.text != "") {
                              webRepo
                                  .addNewUser(UserProfileModel(
                                address: address.text,
                                phoneNumber: phoneNumber.text,
                                password: password.text,
                                email: userMail.text,
                                name: userName.text,
                                profileImageByteStream: image,
                                profileImageName: imageName,
                              ))
                                  .then((value) {
                                Fluttertoast.showToast(
                                    msg: "$value",
                                    toastLength: Toast.LENGTH_SHORT);
                                if(value == "Successful") {
                                   sharedPrefs.setLoginStatus(true);
                                  sharedPrefs.setUserMail(userMail.text);
                                  sharedPrefs.setUserId(userName.text);
                                  sharedPrefs.setUserImage(image);
                                  sharedPrefs.setUserImageName(imageName);
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                }
                              });
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password does not match",
                                toastLength: Toast.LENGTH_SHORT);
                          }
                        }else Fluttertoast.showToast(msg: "Password field empty");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      child: Align(
                        child: Text(
                          alreadyHaveAnAccount ? "Login" : "Save",
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: APPLICATION_DRAWER_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }

  void showDialogBox() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            child: SizedBox.expand(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _selectImage(true);
                        },
                        child: Text("Open Camera"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.black)))),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectImage(false);
                        },
                        child: Text("Select from gallery"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.black)))),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
