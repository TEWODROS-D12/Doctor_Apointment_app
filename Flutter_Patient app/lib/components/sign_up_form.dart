import 'dart:convert';

import 'package:doctor_appointment_app/components/button.dart';
import 'package:doctor_appointment_app/main.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                hintText: 'Username',
                labelText: 'Username',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.person_outlined),
                prefixIconColor: Config.primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Config.primaryColor),
                ),
              ),
              validator: (input) {
                if (input!.isEmpty) {
                  return "Enter Username";
                }
                return null;
              }),
          Config.spaceSmall,
          TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: 'Email Address',
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Config.primaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Config.primaryColor),
                  )),
              validator: (input) {
                if (input!.isEmpty) {
                  return "Enter Email";
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                    .hasMatch(input);
                if (!emailValid) {
                  return "Enter Valid Email";
                }
                return null;
              }),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Config.primaryColor),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
            validator: (input) {
              if (input!.isEmpty) {
                return "Enter Password";
              } else if (_passController.text.length < 6) {
                return "Password Length Should Be More Than 6 Charachters";
              }
              return null;
            },
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign Up',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final userRegistration = await DioProvider().registerUser(
                        _nameController.text,
                        _emailController.text,
                        _passController.text);

                    //if register success, proceed to login
                    if (userRegistration) {
                      final token = await DioProvider().getToken(
                          _emailController.text, _passController.text);

                      if (token) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final tokenValue = prefs.getString('token') ?? '';

                        if (tokenValue.isNotEmpty && tokenValue != '') {
                          //get user data
                          final response =
                              await DioProvider().getUser(tokenValue);
                          if (response != null) {
                            setState(() {
                              //json decode
                              Map<String, dynamic> appointment = {};
                              final user = json.decode(response);

                              //check if any appointment today
                              for (var doctorData in user['doctor']) {
                                //if there is appointment return for today

                                if (doctorData['appointments'] != null) {
                                  appointment = doctorData;
                                }
                              }

                              auth.loginSuccess(user, appointment);
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('main');
                            });
                          }
                        }
                      }
                    } else {
                      print('register not successful');
                    }
                  }
                },
                disable: false,
              );
            },
          )
        ],
      ),
    );
  }
}

//now, let's get all doctor details and display on Mobile screen