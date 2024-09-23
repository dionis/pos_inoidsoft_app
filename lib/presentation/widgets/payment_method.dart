import 'package:flutter/material.dart';

class PaymentMethodDialog extends StatelessWidget {
  final String title;
  final String content;
  List<Widget> actions = [];

  PaymentMethodDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          this.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: this.actions,
        content: Text(
          this.content,
          style: Theme.of(context).textTheme.bodySmall,
        ));
  }
}
