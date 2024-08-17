import 'package:flutter/material.dart';

class CustomButtonPoS extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPress;

  const CustomButtonPoS({
    super.key,
    required this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    //Bibliografy:
    // https://api.flutter.dev/flutter/material/FloatingActionButton-class.html

    return FloatingActionButton(
      heroTag: 'Qr_Scaner',
      enableFeedback: true,
      backgroundColor: Colors.blueAccent,
      elevation: 20,
      shape: const StadiumBorder(),
      onPressed: onPress,
      child: Icon(icon),
    );
  }
}
