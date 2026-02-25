// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? avatarUrl;
  const UserModel({this.id, this.name, this.avatarUrl});

  UserModel copyWith({String? id, String? name, String? avatarUrl}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'avatar_url': avatarUrl};
  }

  factory UserModel.fromJsonMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJsonString(String source) =>
      UserModel.fromJsonMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, avatar_url: $avatarUrl)';

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
