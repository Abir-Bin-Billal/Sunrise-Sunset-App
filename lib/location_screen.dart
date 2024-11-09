import 'package:flutter/material.dart';
import 'package:sunrise_sunset/api%20services/api_Services.dart';
import 'package:sunrise_sunset/current_location_button.dart';
import 'package:sunrise_sunset/home_screen.dart';
import 'package:sunrise_sunset/models/auto_complete_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  AutoCompleteModel _autoCompleteModel = AutoCompleteModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.withOpacity(0.7),
        centerTitle: true,
        title: const Text('Location'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _locationController,
                    onChanged: (value) {
                      ApiServices().autoCompleteService(value).then((value) {
                        setState(() {
                          _autoCompleteModel = value!;
                        });
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter your location',
                      hintText: 'Place',
                    ),
                  ),
                ),
                const CurrentLocationButton(),
                  ],
            ),
          ),
              Expanded(
                child: Visibility(
                  visible: _locationController.text.isNotEmpty &&
                      (_autoCompleteModel.results?.isNotEmpty ?? false),
                  child: ListView.builder(
                    itemCount: _autoCompleteModel.results?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final result = _autoCompleteModel.results?[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(result?.name ?? 'Unknown location'),
                        subtitle: Text(result?.country ?? 'Unknown country'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return HomeScreen(
                               lat: result?.latitude ?? 0.0,
                            lng: result?.longitude ?? 0.0,
                            placeName: result?.name ?? 'Unknown',
                            );
                          }));
                        },
                      );
                    },
                  ),
                ),
              )
          
        ],
      ),
    );
  }
}
