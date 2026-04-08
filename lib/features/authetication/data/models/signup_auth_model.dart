import 'dart:convert';

class SignUpAuthModel {
  final String message;

  SignUpAuthModel({required this.message});

  factory SignUpAuthModel.fromJson(Map<String, dynamic> json) {
    return SignUpAuthModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  factory SignUpAuthModel.fromJsonString(String source) =>
      SignUpAuthModel.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());
}
