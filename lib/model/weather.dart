class Weather {
  final double temperatureC;
  final double temperatureF;
  final double uv;
  final double windKPH;
  final String condition;
  final String location;
  final String country;
  final int isDay;

  Weather({
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.uv = 0,
    this.windKPH = 0,
    this.condition = "Sunny",
    this.location = "",
    this.country = "",
    this.isDay = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['temp_f'],
      uv: json['current']['uv'],
      windKPH: json['current']['wind_kph'],
      condition: json['current']['condition']['text'],
      location: json['location']['name'],
      country: json['location']['country'],
      isDay: json['current']['is_day'],
    );
  }
}