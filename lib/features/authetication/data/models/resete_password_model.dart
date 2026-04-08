class ResetePasswordModel {
  final String message;

  ResetePasswordModel({required this.message});

  factory ResetePasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetePasswordModel(message: json['message']);
  }
}
