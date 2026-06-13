import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();
  final TextEditingController _searchController = TextEditingController();
  
  WeatherData? _currentWeather;
  List<ForecastData> _forecast = [];
  List<LocationData> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocationWeather();
  }

  Future<void> _loadCurrentLocationWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _locationService.getCurrentPositionOrDefault();
      final weatherData = await _weatherService.fetchWeather(
        position.latitude,
        position.longitude,
      );

      final weather = WeatherData.fromJson(
        weatherData,
        'Lokasi Saat Ini',
      );
      
      final forecast = _parseForecast(weatherData);

      setState(() {
        _currentWeather = weather;
        _forecast = forecast;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data cuaca: $e';
        _isLoading = false;
      });
    }
  }

  List<ForecastData> _parseForecast(Map<String, dynamic> json) {
    final daily = json['daily'];
    final times = daily['time'] as List;
    
    return List.generate(times.length, (index) {
      return ForecastData.fromJson(json, index);
    });
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {});

    try {
      final results = await _weatherService.searchLocation(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _loadWeatherForLocation(LocationData location) async {
    setState(() {
      _isLoading = true;
      _searchResults = [];
      _searchController.clear();
      _errorMessage = null;
    });

    try {
      final weatherData = await _weatherService.fetchWeather(
        location.latitude,
        location.longitude,
      );

      final weather = WeatherData.fromJson(
        weatherData,
        location.displayName,
      );
      
      final forecast = _parseForecast(weatherData);

      setState(() {
        _currentWeather = weather;
        _forecast = forecast;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data cuaca: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari kota...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _searchLocation('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onChanged: _searchLocation,
                  ),
                  
                  // Search results dropdown
                  if (_searchResults.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final location = _searchResults[index];
                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(location.name),
                            subtitle: Text(
                              location.country ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                            onTap: () => _loadWeatherForLocation(location),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _errorMessage!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _loadCurrentLocationWeather,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadCurrentLocationWeather,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Current weather card
                                if (_currentWeather != null)
                                  WeatherCard(weather: _currentWeather!),
                                
                                const SizedBox(height: 24),
                                
                                // Forecast section
                                const Text(
                                  'Prakiraan 7 Hari',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                
                                // Forecast list
                                SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _forecast.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width: 80,
                                        child: ForecastItem(
                                          forecast: _forecast[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
