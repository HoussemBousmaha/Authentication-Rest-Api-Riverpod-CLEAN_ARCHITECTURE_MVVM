import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/resource/constant.dart';

class LoginView extends StatefulHookConsumerWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final TextEditingController _phoneController;

  late final Size _size;
  late final GlobalKey<FormState> _formKey;
  bool isSizeInit = false;
  String phone = '';

  @override
  void initState() {
    phone = math.Random().nextInt(1000000000).toString();

    _phoneController = TextEditingController(text: phone);
    _formKey = GlobalKey<FormState>();
    _phoneController.addListener(() {
      setState(() {
        if (_phoneController.text.isNotEmpty) {
          phone = '+${_phoneController.text}';
        } else {
          phone = '';
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isSizeInit == false) _size = MediaQuery.of(context).size;
    isSizeInit = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build of login called');
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _phoneController,
                autovalidateMode: AutovalidateMode.always,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: ((value) {
                  if (value == null || value.isEmpty) return 'Enter Phone';
                  return null;
                }),
                onFieldSubmitted: (_) => login(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(_size.width * .3, _size.height * .05)),
              onPressed: phone.isEmpty ? null : login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    if (phone.isNotEmpty) context.goNamed(RouteNames.confirmOtp, extra: phone);
  }
}
