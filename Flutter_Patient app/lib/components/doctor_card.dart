import 'dart:core';
import 'package:doctor_appointment_app/main.dart';
import 'package:doctor_appointment_app/models/costUtil.dart';
import 'package:doctor_appointment_app/screens/doctor_details.dart';
import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.isFav,
  }) : super(key: key);

  final Map<String, dynamic> doctor;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    print('Constructed URL: ${ConstUrl.url}${doctor['doctor_profile']}');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: CachedNetworkImage(
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                  fit: BoxFit.fill,
                  imageUrl: '${ConstUrl.url}${doctor['doctor_profile']}',
                  placeholder: (context, url) => Center(
                    child: Image.asset('assets/placeholder.jpg'),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dr ${doctor['doctor_name']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${doctor['category']}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text('4.5'),
                          Spacer(
                            flex: 1,
                          ),
                          Text('Reviews'),
                          Spacer(
                            flex: 1,
                          ),
                          Text('(20)'),
                          Spacer(
                            flex: 7,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          //pass the details to detail page
          MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (_) => DoctorDetails(
                    doctor: doctor,
                    isFav: isFav,
                  )));
        },
      ),
    );
  }
}