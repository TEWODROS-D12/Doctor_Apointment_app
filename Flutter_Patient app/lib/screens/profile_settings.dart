import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';


import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import '../providers/dio_provider.dart';
import 'package:image_picker/image_picker.dart';
class ProfileSetting extends StatefulWidget {
  ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  @override
  void initState() {
    super.initState();
    //requestPermissions();
  }
  XFile? _image;
  // Future<void> requestPermissions() async {
  //   // Request permission to access the image gallery and camera
  //   var status = await Permission.photos.request();
  //
  //     if (status.isDenied) {
  //       // Permission denied
  //       // Show an explanation to the user
  //       await showDialog(
  //         context: context,
  //         builder: (BuildContext context) => AlertDialog(
  //           title: Text('Permission Required'),
  //           content: Text('This app needs access to your photos to function properly.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('Cancel'),
  //             ),
  //             TextButton(
  //               onPressed: () => openAppSettings(),
  //               child: Text('Open Settings'),
  //             ),
  //           ],
  //         ),
  //       );
  //   }
  //
  //   status = await Permission.camera.request();
  //   if (status.isDenied) {
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: Text('Permission Required'),
  //         content: Text('This app needs access to your camera to function properly.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () => openAppSettings(),
  //             child: Text('Open Settings'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  Future getImage() async {
    final picker = ImagePicker();
    final   XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveProfile() async {
    if (_image == null) return;
    final String fileName = _image!.path.split('/').last;
    MultipartFile file = await MultipartFile.fromFile(_image!.path, filename: fileName);
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    FormData formData = FormData.fromMap({
      "profile_image": file,
    });
    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().uploadProfileImage(token,formData);
      print(response);
      if (response == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile image updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile image')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapCancel: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.jpg"), // Add a nice background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _image != null
                                    ? FileImage(File(_image!.path))
                                    : AssetImage("assets/placeholder.jpg") as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: getImage,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 4, color: Colors.white),
                                  color: Config.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Config.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
