import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/resource/enum/view_state.dart';
import '../../../../core/presentation/widget/loading_dialog.dart';
import '../provider/auth_state_notifier_provider.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authStateNotifier is used to call the login method
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    // Listen to the view state and show a loading dialog if the view state is loading
    ref.listen(viewStateProvider, (_, state) => state == ViewState.loading ? showLoadingDialog(ref.context) : null);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Logout'),
          onPressed: () async => await authStateNotifier.logout(),
        ),
      ),
    );
  }
}
