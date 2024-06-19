import "package:doctor_appointment_app/main.dart";
import "package:doctor_appointment_app/utils/config.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/auth_model.dart";
import "../providers/dio_provider.dart";

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> user = {};
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    return Scaffold(
      body: user.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Config.primaryColor,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 110,
                  ),
                  const CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage('assets/placeholder.jpg'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '23 Years Old | Female',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: Center(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                  child: Container(
                    width: 300,
                    height: 265,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                          ),
                          GestureDetector(
                            onTap: () {
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('profile_set');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blueAccent[400],
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Profile",
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Config.spaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.yellowAccent[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "History",
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.logout_outlined,
                                color: Colors.lightGreen[400],
                                size: 35,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                  await SharedPreferences
                                      .getInstance();
                                  final token =
                                      prefs.getString('token') ?? '';

                                  if (token.isNotEmpty && token != '') {
                                    // Logout here
                                    final response =
                                    await DioProvider().logout(token);

                                    if (response == 200) {
                                      // If successfully delete access token,
                                      // then delete token saved at Shared Preference as well
                                      await prefs.remove('token');
                                      if (mounted) {
                                        setState(() {
                                          // Redirect to login page
                                          MyApp.navigatorKey.currentState!
                                              .pushReplacementNamed('/');
                                        });
                                      }
                                    }
                                  }
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Config.primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
