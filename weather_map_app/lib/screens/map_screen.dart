import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  
  LatLng _currentCenter = LatLng(-6.2088, 106.8456); // Default: Jakarta
  LatLng? _selectedLocation;
  WeatherData? _selectedWeather;
  bool _isLoading = false;
  bool _isGettingLocation = false;

  @override
  void initState() {
    super.initState();
    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      final position = await _locationService.getCurrentPositionOrDefault();
      final latLng = LatLng(position.latitude, position.longitude);
      
      setState(() {
        _currentCenter = latLng;
      });
      
      _mapController.move(latLng, 13);
    } catch (e) {
      // Silently fail, will use default location
    } finally {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  Future<void> _onMapTap(TapPosition tapPosition, LatLng position) async {
    setState(() {
      _selectedLocation = position;
      _isLoading = true;
      _selectedWeather = null;
    });

    try {
      final weatherData = await _weatherService.fetchWeather(
        position.latitude,
        position.longitude,
      );

      final weather = WeatherData.fromJson(
        weatherData,
        '${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}',
      );

      setState(() {
        _selectedWeather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data cuaca: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 13,
              onTap: _onMapTap,
            ),
            children: [
              // OpenStreetMap tiles
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.weather_map_app',
              ),
              
              // Current location marker
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentCenter,
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                  ),
                  
                  // Selected location marker
                  if (_selectedLocation != null)
                    Marker(
                      point: _selectedLocation!,
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          // Show weather info
                        },
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Weather info popup
          if (_selectedLocation != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : _selectedWeather != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedWeather!.location,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _selectedLocation = null;
                                        _selectedWeather = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    _selectedWeather!.weatherIcon,
                                    style: const TextStyle(fontSize: 48),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_selectedWeather!.temperature.toStringAsFixed(1)}°C',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _selectedWeather!.description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInfoChip(
                                    Icons.water_drop,
                                    '${_selectedWeather!.humidity.toStringAsFixed(0)}%',
                                  ),
                                  _buildInfoChip(
                                    Icons.air,
                                    '${_selectedWeather!.windSpeed.toStringAsFixed(1)} km/h',
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
              ),
            ),

          // Controls
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                // Current location button
                FloatingActionButton(
                  heroTag: 'location_btn',
                  onPressed: _isGettingLocation ? null : _goToCurrentLocation,
                  backgroundColor: Colors.white,
                  child: _isGettingLocation
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location, color: Colors.blue),
                ),
                
                const SizedBox(height: 8),
                
                // Zoom in
                FloatingActionButton(
                  heroTag: 'zoom_in_btn',
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom + 1,
                    );
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.add, color: Colors.blue),
                ),
                
                const SizedBox(height: 8),
                
                // Zoom out
                FloatingActionButton(
                  heroTag: 'zoom_out_btn',
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom - 1,
                    );
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.remove, color: Colors.blue),
                ),
              ],
            ),
          ),

          // Instructions
          Positioned(
            top: 16,
            left: 16,
            right: 80,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Tap peta untuk melihat cuaca di lokasi tersebut',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String value) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(value),
      backgroundColor: Colors.blue.shade50,
    );
  }
}
