import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../../core/constant/string.dart';

@immutable
class AuthResponseModel extends Equatable {
  final int? code;
  final String? message;
  final String? token;
  final String? userStatus;
  final String? name;
  final String? phone;

  const AuthResponseModel({this.code, this.message, this.token, this.userStatus, this.name, this.phone});

  Map<String, dynamic> toJson() {
    return {
      ResponseKeys.code: code,
      ResponseKeys.message: message,
      ResponseKeys.token: token,
      ResponseKeys.userStatus: userStatus,
    };
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      code: json[ResponseKeys.code],
      message: json[ResponseKeys.message],
      token: json[ResponseKeys.token],
      userStatus: json[ResponseKeys.userStatus],
    );
  }

  @override
  List<Object?> get props => [code, message, token, userStatus];
}
