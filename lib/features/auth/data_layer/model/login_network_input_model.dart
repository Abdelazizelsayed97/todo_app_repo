import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/login_input.dart';

part 'login_network_input_model.g.dart';

@JsonSerializable()
class NetworkLoginInputModel {
  final String email;
  final String password;

  NetworkLoginInputModel({
    required this.email,
    required this.password,
  });

  factory NetworkLoginInputModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkLoginInputModelFromJson(json);

  factory NetworkLoginInputModel.fromInput(LoginInput input) {
    return NetworkLoginInputModel(email: input.email, password: input.password);
  }

  Map<String, dynamic> toJson() => _$NetworkLoginInputModelToJson(this);
}

