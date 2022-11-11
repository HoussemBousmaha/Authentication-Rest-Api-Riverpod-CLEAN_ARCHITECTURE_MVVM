import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../core/presentation/resource/string.dart';
import '../../../../core/presentation/resource/enum/user_status.dart';
import '../../data/model/response/auth_response_model.dart';

@immutable
class AuthResponse extends Equatable {
  final String token;
  final UserStatus userStatus;
  final String name;
  final String phone;

  const AuthResponse({
    required this.token,
    required this.userStatus,
    required this.name,
    required this.phone,
  });

  factory AuthResponse.fromModel(AuthResponseModel model) {
    return AuthResponse(
      // at this point the token can not be null
      // if the token is null, there is a problem from api side
      token: model.token!,
      userStatus: _getUserStatus(model.userStatus),
      name: '',
      phone: '',
    );
  }

  @override
  List<Object?> get props => [token, userStatus];

  @override
  bool get stringify => true;
}

UserStatus _getUserStatus(String? userStatus) {
  if (userStatus == AppStrings.newUser) return UserStatus.newUser;

  return UserStatus.oldUser;
}
