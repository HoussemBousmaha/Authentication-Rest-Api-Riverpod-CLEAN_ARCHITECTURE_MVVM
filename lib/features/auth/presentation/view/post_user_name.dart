import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/auth_state_notifier.dart';
import '../provider/auth_state_notifier_provider.dart';

class PostUserNameView extends StatefulHookConsumerWidget {
  const PostUserNameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostUserNameViewState();
}

class _PostUserNameViewState extends ConsumerState<PostUserNameView> {
  late final AuthStateNotifier _authStateNotifier;
  late final TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController(text: 'Houssem');
    _authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build of post user name called');
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
            TextField(
              controller: _nameController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await _authStateNotifier.postUserName(_nameController.text);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
