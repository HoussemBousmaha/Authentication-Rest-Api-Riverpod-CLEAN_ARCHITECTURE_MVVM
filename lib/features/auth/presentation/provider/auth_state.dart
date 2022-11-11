import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../core/data/error/failure.dart';
import '../../domain/entity/auth_response.dart';

@immutable
class AuthState extends Equatable {
  final Failure? failure;
  final AuthResponse? authResponse;

  const AuthState({this.failure, this.authResponse});

  factory AuthState.initial() => const AuthState();

  // failure state
  factory AuthState.failure(Failure failure) => AuthState(failure: failure);

  // success state
  factory AuthState.success(AuthResponse authResponse) => AuthState(authResponse: authResponse);

  @override
  List<Object?> get props => [failure, authResponse];

  @override
  bool get stringify => true;
}
