import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/presentation/resource/enum/view_state.dart';
import '../../../../core/presentation/widget/loading_dialog.dart';
import '../provider/auth_state_notifier_provider.dart';

class ConfirmOtpView extends HookConsumerWidget {
  const ConfirmOtpView(this.phone, {super.key});

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authStateNotifier is used to call the login method
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    // screen size
    final size = MediaQuery.of(context).size;
    // Listen to the view state and show a loading dialog if the view state is loading
    ref.listen(viewStateProvider, (_, state) => state == ViewState.loading ? showLoadingDialog(ref.context) : null);

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Otp')),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        child: OTPTextField(
          length: 4,
          width: size.width,
          fieldWidth: size.width * .13,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          onChanged: (_) {},
          onCompleted: (_) async => await authStateNotifier.login(phone),
        ),
      ),
    );
  }
}
