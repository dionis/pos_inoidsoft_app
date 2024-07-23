import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPress;

  const CustomButton({
    super.key,
    required this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    //Bibliografy:
    // https://api.flutter.dev/flutter/material/FloatingActionButton-class.html

    return FloatingActionButton(
      enableFeedback: true,
      backgroundColor: Colors.blueAccent,
      elevation: 20,
      shape: const StadiumBorder(),
      onPressed: onPress,
      child: Icon(icon),
    );
  }
}
