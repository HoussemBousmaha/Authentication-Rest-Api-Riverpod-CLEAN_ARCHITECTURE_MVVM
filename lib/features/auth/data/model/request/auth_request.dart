import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../../core/presentation/resource/constant.dart';
import '../../../../../core/presentation/resource/string.dart';

@immutable
class AuthRequest extends Equatable {
  final String phone;
  const AuthRequest({required this.phone});

  Map<String, dynamic> toJson() => {AppStrings.otp: ApiConstants.otpValue, AppStrings.phone: phone};

  @override
  List<Object?> get props => [phone];
}
