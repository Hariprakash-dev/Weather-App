import 'package:flutter/material.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/Screen/weather_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ],
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
    
     
      
      home: WeatherScreen(),

    );
  }
}