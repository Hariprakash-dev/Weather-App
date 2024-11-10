import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:  Colors.grey[500],
      appBar: AppBar(
         backgroundColor:  Colors.grey[500],
       
        title: const Text("Weather App",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                
                
                labelText: "Enter City Name",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _fetchWeather(context),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              
              onPressed: () {
                _fetchWeather(context);
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
                   //loading is true
              // if (weatherProvider.isLoading) {
               
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              //if data is available
              return weatherProvider.temperature.isEmpty
                  ? const Text("Enter a city to get the weather")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${weatherProvider.cityName}  ",
                              style: const TextStyle(
                                  fontSize: 30, color:  Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("${weatherProvider.temperature}°C", style: const TextStyle(
                                  fontSize: 40, color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(" ${weatherProvider.description}", style:  const TextStyle(
                                  fontSize: 30, color:  Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (weatherProvider.iconCode.isNotEmpty)
                              Image.network(
                                'http://openweathermap.org/img/wn/${weatherProvider.iconCode}@4x.png',
                                width: 300,
                                height: 300,
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Humidity: ${weatherProvider.humidity}%",
                              style: const TextStyle(
                                  fontSize: 30, color:  Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                          
                            Text(
                              "windSpeed: ${weatherProvider.windspeed}m/s",
                              style: const TextStyle(
                                  fontSize: 30, color:  Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }

  void _fetchWeather(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.fetchWeather(_controller.text);
  }
}
