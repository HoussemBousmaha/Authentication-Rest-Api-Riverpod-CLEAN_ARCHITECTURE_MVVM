import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/enum/view_state.dart';
import 'auth_state.dart';
import 'auth_state_notifier.dart';

final viewStateProvider = StateProvider<ViewState>(
  (ref) => ViewState.initial,
);

final authStateNotifierProvider = AsyncNotifierProvider<AuthStateNotifier, AuthState>(
  () => AuthStateNotifierImpl(),
);

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final authResponse = authState.value?.authResponse;
  final authFailure = authState.value?.failure;

  // This means that the success part of the fold method was called.
  return authResponse != null && authFailure == null;
});
