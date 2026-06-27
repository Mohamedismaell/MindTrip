import 'package:equatable/equatable.dart';

class RenameTripRequestModel extends Equatable {
  const RenameTripRequestModel({required this.title});

  final String title;

  Map<String, dynamic> toJson() => {'title': title};

  @override
  List<Object?> get props => [title];
}
