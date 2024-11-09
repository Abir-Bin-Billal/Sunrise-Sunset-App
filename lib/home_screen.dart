import 'package:flutter/material.dart';
import 'package:sunrise_sunset/api%20services/api_Services.dart';
import 'package:sunrise_sunset/models/sunride_sunset_model.dart';

class HomeScreen extends StatefulWidget {
  final double lat, lng;
  final String placeName;
  const HomeScreen(
      {super.key,
      required this.lat,
      required this.lng,
      required this.placeName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  Sunrise_Sunset_Model sunrise_sunset_model = Sunrise_Sunset_Model();

  void getSunsetSunrise() {
    ApiServices()
        .autoSunsetServiceService(widget.lat, widget.lng)
        .then((value) {
      sunrise_sunset_model = value!;
    }).onError((error, stackTrace) {
      print('Error: $error');
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSunsetSunrise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.withOpacity(0.7),
        centerTitle: true,
        leading: BackButton(color: Colors.white,),
        title: Text(widget.placeName),
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 200,
              child: Image.network("https://static.vecteezy.com/system/resources/thumbnails/033/160/276/small_2x/sun-sunlight-rays-sunrise-or-sunset-png.png"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Sunrise', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.brown),),
                    Text(sunrise_sunset_model.results?.sunrise ?? 'Unknown' , style: const TextStyle(fontSize: 15, color: Colors.brown),),
                  ],
                ),
                Column(
                  children: [
                    const Text('Sunset' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.brown),),
                    Text(sunrise_sunset_model.results?.sunset ?? 'Unknown' , style: const TextStyle(fontSize: 15, color: Colors.brown),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: [
                Text("Day Length", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.brown),),
                Text(sunrise_sunset_model.results?.dayLength ?? 'Unknown' , style: const TextStyle(fontSize: 15, color: Colors.brown),),
              ],
            )
            ],
        )
      ),
    );
  }
}
