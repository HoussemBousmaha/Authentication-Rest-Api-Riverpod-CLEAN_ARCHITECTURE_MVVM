import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_u/features/auth/presentation/provider/auth_state_notifier.dart';

import '../provider/auth_state_notifier_provider.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final AuthStateNotifier _authStateNotifier;

  @override
  void initState() {
    _authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build of home called');
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Logout'),
          onPressed: () async {
            await _authStateNotifier.logout();
          },
        ),
      ),
    );
  }
}
