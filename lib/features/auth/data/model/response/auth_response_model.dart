import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../../core/presentation/resource/string.dart';

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
      AuthResponseKeys.code: code,
      AuthResponseKeys.message: message,
      AuthResponseKeys.token: token,
      AuthResponseKeys.userStatus: userStatus,
    };
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      code: json[AuthResponseKeys.code],
      message: json[AuthResponseKeys.message],
      token: json[AuthResponseKeys.token],
      userStatus: json[AuthResponseKeys.userStatus],
    );
  }

  @override
  List<Object?> get props => [code, message, token, userStatus];
}
