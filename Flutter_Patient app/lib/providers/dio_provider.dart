import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:doctor_appointment_app/models/costUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {

  //get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post(
        '${ConstUrl.url}/api/login',
        data: {'email': email, 'password': password},
      );
      print('Response received: ${response.statusCode} - ${response.data}');
      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Invalid email or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response!.statusCode == 302) {
          Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'An error occurred: ${error.response!.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Network error, please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      return false;
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'An unexpected error occurred',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  //get user data
  Future<dynamic> getUser(String token) async {
    try {

      var user = await Dio().get('${ConstUrl.url}/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      print("boss");
      return error;
    }
  }

  //register new user
  Future<dynamic> registerUser(
      String username, String email, String password) async {
    try {
      var user = await Dio().post('${ConstUrl.url}/api/register',
          data: {'name': username, 'email': email, 'password': password});
      if (user.statusCode == 201 && user.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //store booking details
  Future<dynamic> bookAppointment(
      String date, String day, String time, int doctor, String token) async {
    try {
      var response = await Dio().post('${ConstUrl.url}/api/book',
          data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //retrieve booking details
  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get('${ConstUrl.url}/api/appointments',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //store rating details
  Future<dynamic> storeReviews(
      String reviews, double ratings, int id, int doctor, String token) async {
    try {
      var response = await Dio().post('${ConstUrl.url}/api/reviews',
          data: {
            'ratings': ratings,
            'reviews': reviews,
            'appointment_id': id,
            'doctor_id': doctor
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
  // Fetch profile image
  Future<Uint8List?> fetchProfileImage(String token, String imagePath) async {
    try {
      Dio dio = Dio();
      Response<List<int>> response = await dio.get(
        '${ConstUrl.url}/$imagePath',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          responseType: ResponseType.bytes,
        ),
      );
     print(response);
      if (response.statusCode == 200) {
        return Uint8List.fromList(response.data!);
      } else {
        return null; // Return null if the request was not successful
      }
    } catch (error) {
      print('Error fetching profile image: $error');
      return null; // Return null in case of errors
    }
  }

  //store fav doctor
  Future<dynamic> storeFavDoc(String token, List<dynamic> favList) async {
    try {
      print("Token: $token");
      print("Payload: $favList");
      var response = await Dio().post('${ConstUrl.url}/api/fav',
          data: {
            'favList': favList,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print("Response Status Code: "
          "${response.statusCode}");
      print("Response Data: ${response.data}");



      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

//logout
  Future<dynamic> logout(String token) async {
    try {
      var response = await Dio().post('${ConstUrl.url}/api/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
  Future<int> uploadProfileImage(String token, FormData formData) async {
    try {
      Response response = await Dio().post(
        '${ConstUrl.url}/api/profile', options: Options(headers: {'Authorization': 'Bearer $token'}), // Replace with your actual API endpoint
        data: formData,
      );
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 500; // or any other code to indicate failure
    }
  }
}
