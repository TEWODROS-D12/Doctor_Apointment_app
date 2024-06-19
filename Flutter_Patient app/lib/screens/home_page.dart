import 'package:doctor_appointment_app/components/appointment_card.dart';
import 'package:doctor_appointment_app/components/doctor_card.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/providers/dio_provider.dart';
import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<dynamic> favList = [];
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];
  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Uint8List? _imageBytes;
  Future<void> _fetchImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    // Fetch image from the server using DioProvider
    Uint8List? imageBytes = await DioProvider().fetchProfileImage(
      token,
      user['profile_photo_path'],
    );
    if (mounted) {
      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    doctor = Provider.of<AuthModel>(context, listen: false).getAppointment;
    favList = Provider.of<AuthModel>(context, listen: false).getFav;
    print(doctor);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();

        return true; // Allow the app to exit
      },
      child: Scaffold(
        //if user is empty, then return progress indicator
        body: user.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                user['name'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  MyApp.navigatorKey.currentState!
                                      .pushNamed('profile');
                                },
                                child: SizedBox(
                                    child: ClipOval(
                                  child: _imageBytes != null
                                      ? Image.memory(
                                          _imageBytes!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Placeholder(
                                          fallbackHeight:
                                              80, // Adjust the height as needed
                                          fallbackWidth:
                                              80, // Adjust the width as needed
                                        ),
                                )),
                              )
                            ],
                          ),
                        ),
                        Config.spaceMedium,
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Config.spaceSmall,
                        SizedBox(
                          height: Config.heightSize * 0.05,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children:
                                List<Widget>.generate(medCat.length, (index) {
                              return Card(
                                margin: const EdgeInsets.only(right: 20),
                                color: Config.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FaIcon(
                                        medCat[index]['icon'],
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        medCat[index]['category'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Config.spaceSmall,
                        const Text(
                          'Appointment Today',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Config.spaceSmall,
                        doctor.isNotEmpty
                            ? AppointmentCard(
                                doctor: doctor,
                                color: Config.primaryColor,
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'No Appointment Today',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Config.spaceSmall,
                        const Text(
                          'Top Doctors',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Config.spaceSmall,
                        Column(
                          children:
                              List.generate(user['doctor'].length, (index) {
                            return DoctorCard(
                              doctor: user['doctor'][index],
                              //  if lates fav list contains particular doctor id, then show fav icon
                              isFav: favList
                                      .contains(user['doctor'][index]['doc_id'])
                                  ? true
                                  : false,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
