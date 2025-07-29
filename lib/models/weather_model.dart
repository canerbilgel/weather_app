class Weather {
  final String? cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final double windSpeed;
  final int humidity;
  final DateTime? date;
  final double feelsLike;

  Weather({
    this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,

    this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),

    );
  }

  factory Weather.fromForecastJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      date: DateTime.parse(json['dt_txt']),
      feelsLike: json['main']['feels_like'].toDouble(),

    );
  }
}
