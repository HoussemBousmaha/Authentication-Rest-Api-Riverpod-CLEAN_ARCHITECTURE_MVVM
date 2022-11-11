import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/resource/enum/view_state.dart';
import '../../../../core/presentation/widget/loading_dialog.dart';
import '../provider/auth_state_notifier_provider.dart';

class PostUserNameView extends HookConsumerWidget {
  const PostUserNameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authStateNotifier is used to call the login method
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

    // name text field controller
    final nameController = useTextEditingController(text: 'Houssem');

    // Listen to the view state and show a loading dialog if the view state is loading
    ref.listen(viewStateProvider, (_, state) => state == ViewState.loading ? showLoadingDialog(ref.context) : null);

    return Scaffold(
      appBar: AppBar(title: const Text('Post User Name')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your name',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            TextField(controller: nameController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async => await authStateNotifier.postUserName(nameController.text),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
