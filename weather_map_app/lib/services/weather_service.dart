import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1';
  static const String geocodingUrl = 'https://geocoding-api.open-meteo.com/v1';

  // Fetch current weather and forecast for a location
  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url = Uri.parse(
      '$baseUrl/forecast?latitude=$lat&longitude=$lon'
      '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
      '&timezone=auto&forecast_days=7',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  // Search locations by name
  Future<List<LocationData>> searchLocation(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      '$geocodingUrl/search?name=$query&count=5&language=id&format=json',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List?;
        
        if (results != null) {
          return results
              .map((json) => LocationData.fromJson(json))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to search location: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching location: $e');
    }
  }

  // Get weather for a specific location (combines geocoding + weather)
  Future<Map<String, dynamic>> getWeatherForLocation(LocationData location) async {
    final weatherData = await fetchWeather(location.latitude, location.longitude);
    return {
      'weather': WeatherData.fromJson(weatherData, location.displayName),
      'forecast': _parseForecast(weatherData),
    };
  }

  List<ForecastData> _parseForecast(Map<String, dynamic> json) {
    final daily = json['daily'];
    final times = daily['time'] as List;
    
    return List.generate(times.length, (index) {
      return ForecastData.fromJson(json, index);
    });
  }
}
