import 'package:a2d_app/services/keys.dart';

class SignUpModel {
  SignUpModel({
    required this.country,
    required this.phone,
    required this.email,
    required this.name,
    required this.id,
    required this.pass,
  });

  String? name;
  String? email;
  String? phone;
  String? pass;
  String? country;
  String? id;

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      country: json["DATA"][Keys.country],
      phone: json["DATA"][Keys.phone],
      email: json["DATA"][Keys.email],
      name: json["DATA"][Keys.name],
      id: json["DATA"][Keys.id],
      pass: json["DATA"][Keys.password],
    );
  }
}

class LoginModel {
  LoginModel({
    required this.token,
    required this.msg,
    required this.email,
    required this.id2,
    required this.date,
    required this.temp,
    required this.cityId,
    required this.condition,
    required this.humidity,
    required this.maxTemp,
    required this.minTemp,
    required this.windSpeed,
  });

  String? msg;
  String? email;
  String? token;
  String? id2;
  String? date;
  int? minTemp;
  int? maxTemp;
  int? temp;
  String? condition;
  int? windSpeed;
  int? humidity;
  String? cityId;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json[Keys.token],
      msg: json[Keys.msg],
      email: json[Keys.email],
      id2: json[Keys.liveWeather][Keys.id2],
      date: json[Keys.liveWeather][Keys.date],
      temp: json[Keys.liveWeather][Keys.temperature],
      cityId: json[Keys.liveWeather][Keys.cityId],
      condition: json[Keys.liveWeather][Keys.condition],
      humidity: json[Keys.liveWeather][Keys.humidity],
      maxTemp: json[Keys.liveWeather][Keys.maxTemperature],
      minTemp: json[Keys.liveWeather][Keys.minTemperature],
      windSpeed: json[Keys.liveWeather][Keys.windSpeed],
    );
  }
}
