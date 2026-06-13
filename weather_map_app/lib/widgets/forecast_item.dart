import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

class ForecastItem extends StatelessWidget {
  final ForecastData forecast;

  const ForecastItem({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('EEE');
    final dateFormat = DateFormat('d MMM');
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day name
          Text(
            dayFormat.format(forecast.date),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          
          // Date
          Text(
            dateFormat.format(forecast.date),
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Weather icon
          Text(
            forecast.weatherIcon,
            style: const TextStyle(fontSize: 28),
          ),
          
          const SizedBox(height: 8),
          
          // Temperature range
          Column(
            children: [
              Text(
                '${forecast.tempMax.toStringAsFixed(0)}°',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              Text(
                '${forecast.tempMin.toStringAsFixed(0)}°',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
