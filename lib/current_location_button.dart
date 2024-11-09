import 'package:flutter/material.dart';
import 'package:sunrise_sunset/api%20services/handle_location_permission.dart';
import 'package:sunrise_sunset/home_screen.dart';

class CurrentLocationButton extends StatefulWidget {
  const CurrentLocationButton({super.key});

  @override
  State<CurrentLocationButton> createState() => _CurrentLocationButtonState();
}

class _CurrentLocationButtonState extends State<CurrentLocationButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isLoading = true;
          });
          determinePosition().then((value) async {
            print('Latitude: ${value.latitude}');
            print('Longitude: ${value.longitude}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        lat: value.latitude,
                        lng: value.longitude,
                        placeName: "My Location")));
            setState(() {
              isLoading = false;
            });
          }).onError((error, stackTrace) {
            setState(() {
              isLoading = false;
            });
            print('Error: $error');
          });
        },
        child: Container(
          height: 60,
          width: 60,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ));
  }
}
