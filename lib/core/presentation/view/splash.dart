import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
