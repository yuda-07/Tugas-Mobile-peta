class WeatherData {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final int weatherCode;
  final String description;
  final String location;
  final DateTime time;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.description,
    required this.location,
    required this.time,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, String locationName) {
    final current = json['current'];
    final weatherCode = current['weather_code'] ?? 0;
    
    return WeatherData(
      temperature: (current['temperature_2m'] ?? 0).toDouble(),
      humidity: (current['relative_humidity_2m'] ?? 0).toDouble(),
      windSpeed: (current['wind_speed_10m'] ?? 0).toDouble(),
      weatherCode: weatherCode,
      description: _getWeatherDescription(weatherCode),
      location: locationName,
      time: DateTime.now(),
    );
  }

  static String _getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Cerah';
      case 1:
        return 'Cerah Berawan';
      case 2:
        return 'Berawan Sebagian';
      case 3:
        return 'Berawan';
      case 45:
      case 48:
        return 'Berkabut';
      case 51:
      case 53:
      case 55:
        return 'Gerimis';
      case 56:
      case 57:
        return 'Gerimis Beku';
      case 61:
      case 63:
      case 65:
        return 'Hujan';
      case 66:
      case 67:
        return 'Hujan Beku';
      case 71:
      case 73:
      case 75:
        return 'Salju';
      case 77:
        return 'Hujan Salju';
      case 80:
      case 81:
      case 82:
        return 'Hujan Lebat';
      case 85:
      case 86:
        return 'Hujan Salju Lebat';
      case 95:
        return 'Badai Petir';
      case 96:
      case 99:
        return 'Badai Petir dengan Hujan Es';
      default:
        return 'Tidak Diketahui';
    }
  }

  String get weatherIcon {
    switch (weatherCode) {
      case 0:
        return '☀️';
      case 1:
      case 2:
        return '🌤️';
      case 3:
        return '☁️';
      case 45:
      case 48:
        return '🌫️';
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return '🌦️';
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return '🌧️';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return '🌨️';
      case 95:
      case 96:
      case 99:
        return '⛈️';
      default:
        return '🌡️';
    }
  }
}

class ForecastData {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final int weatherCode;
  final String description;

  ForecastData({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.weatherCode,
    required this.description,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json, int index) {
    final daily = json['daily'];
    final weatherCode = daily['weather_code'][index] ?? 0;
    
    return ForecastData(
      date: DateTime.parse(daily['time'][index]),
      tempMax: (daily['temperature_2m_max'][index] ?? 0).toDouble(),
      tempMin: (daily['temperature_2m_min'][index] ?? 0).toDouble(),
      weatherCode: weatherCode,
      description: WeatherData._getWeatherDescription(weatherCode),
    );
  }

  String get weatherIcon {
    switch (weatherCode) {
      case 0:
        return '☀️';
      case 1:
      case 2:
        return '🌤️';
      case 3:
        return '☁️';
      case 45:
      case 48:
        return '🌫️';
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return '🌦️';
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return '🌧️';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return '🌨️';
      case 95:
      case 96:
      case 99:
        return '⛈️';
      default:
        return '🌡️';
    }
  }
}

class LocationData {
  final String name;
  final double latitude;
  final double longitude;
  final String? country;
  final String? admin1;

  LocationData({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.country,
    this.admin1,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      name: json['name'] ?? 'Unknown',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      country: json['country'],
      admin1: json['admin1'],
    );
  }

  String get displayName {
    if (admin1 != null && admin1!.isNotEmpty) {
      return '$name, $admin1';
    } else if (country != null && country!.isNotEmpty) {
      return '$name, $country';
    }
    return name;
  }
}
