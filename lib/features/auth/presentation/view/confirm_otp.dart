import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../provider/auth_state_notifier.dart';
import '../provider/auth_state_notifier_provider.dart';

class ConfirmOtpView extends StatefulHookConsumerWidget {
  const ConfirmOtpView(this.phone, {super.key});

  final String phone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends ConsumerState<ConfirmOtpView> {
  late final AuthStateNotifier _authStateNotifier;
  late final Size _size;
  bool isSizeInit = false;

  @override
  initState() {
    _authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isSizeInit == false) _size = MediaQuery.of(context).size;
    isSizeInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log('build of confirm otp called');
    // print(widget.phone);
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Otp')),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        child: OTPTextField(
          length: 4,
          width: _size.width,
          fieldWidth: _size.width * .13,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          onChanged: (_) {},
          onCompleted: (_) async {
            await _authStateNotifier.login(widget.phone);
          },
        ),
      ),
    );
  }
}
