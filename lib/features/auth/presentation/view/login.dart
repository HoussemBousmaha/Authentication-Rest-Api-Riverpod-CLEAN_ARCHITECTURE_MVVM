import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/resource/constant.dart';
import '../../../../core/presentation/resource/string.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final phone = math.Random().nextInt(1000000000).toString();
    final phoneNotifier = useState<String>(phone);
    final phoneController = useTextEditingController(text: phone);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    useEffect(() {
      phoneController.addListener(() {
        if (phoneController.text.isNotEmpty) {
          phoneNotifier.value = '+${phoneController.text}';
        } else {
          phoneNotifier.value = '';
        }
      });

      return null;
    }, [phoneController]);

    void login() {
      if (phoneNotifier.value.isNotEmpty) {
        context.goNamed(RouteNames.confirmOtp, params: {'phone': phoneNotifier.value});
      }
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: ((value) {
                  if (value == null || value.isEmpty) return AppStrings.enterPhone;
                  return null;
                }),
                onFieldSubmitted: (_) => login(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(size.width * .3, size.height * .05)),
              onPressed: phoneNotifier.value.isEmpty ? null : login,
              child: const Text(AppStrings.login),
            ),
          ],
        ),
      ),
    );
  }
}
