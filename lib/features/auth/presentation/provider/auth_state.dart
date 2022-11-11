import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../domain/entity/auth_failure.dart';
import '../../domain/entity/auth_response.dart';

@immutable
class AuthState extends Equatable {
  final AuthFailure? authFailure;
  final AuthResponse? authResponse;

  const AuthState({this.authFailure, this.authResponse});

  factory AuthState.initial() => const AuthState();

  // failure state
  factory AuthState.failure(AuthFailure authFailure) => AuthState(authFailure: authFailure);

  // success state
  factory AuthState.success(AuthResponse authResponse) => AuthState(authResponse: authResponse);

  @override
  List<Object?> get props => [authFailure, authResponse];

  @override
  bool get stringify => true;
}
