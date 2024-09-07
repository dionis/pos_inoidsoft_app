import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:pos_inoidsoft_app/presentation/screens/Calculator/calculator_screen.dart";

import "../Qrcode_reader/qr_code_reader_windows.dart";
import "../../widgets/custom_button_pos.dart";
import "home_pos_screen.dart";

class MainPoSScreen extends StatefulWidget {
  const MainPoSScreen({super.key});

  @override
  State<MainPoSScreen> createState() => _MainPoSScreenState();
}

class _MainPoSScreenState extends State<MainPoSScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePosScreen(),
    );
  }
}
