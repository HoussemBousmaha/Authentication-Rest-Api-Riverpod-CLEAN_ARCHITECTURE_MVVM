import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        height: size.height * .15,
        width: size.height * .1,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const LoadingDialog(),
  );
}
