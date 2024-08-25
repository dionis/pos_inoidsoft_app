import 'package:flutter/material.dart';

class ChangeCurremcyDialog extends StatelessWidget {
  final String title;
  final String content;
  List<Widget> actions = [];

  ChangeCurremcyDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          this.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: this.actions,
        content: Text(
          this.content,
          style: Theme.of(context).textTheme.bodySmall,
        ));
  }
}
