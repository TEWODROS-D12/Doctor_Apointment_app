import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final List<String> _titles = [
    "Book Appointments",
    "Consult with Doctors",
    "Manage Health Records"
  ];
  final List<String> _descriptions = [
    "Easily book appointments with your preferred doctors.",
    "Get consultations from top specialists online.",
    "Keep track of your medical records and history."
  ];
  final List<String> _images = [
    'assets/manage_records.jpg',
    'assets/book_appointments.jpg',
    'assets/consult_doctors.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CarouselSlider.builder(
              itemCount: _titles.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.75,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      _images[index],
                      height: 300.0,
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      _titles[index],
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _descriptions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _titles.map((url) {
              int index = _titles.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentIndex == index ? Color(0xff909cdf) : Colors.grey,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('auth');
            },
            child: Text("Get Started"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              textStyle: TextStyle(fontSize: 16),
              backgroundColor: Config.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
