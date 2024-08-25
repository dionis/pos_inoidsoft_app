import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:pos_inoidsoft_app/presentation/screens/Calculator/calculator_screen.dart";

import "../../../domain/qr_code_reader_windows.dart";
import "../../widgets/custom_button_pos.dart";
import "../../home_pos_screen.dart";

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
      // floatingActionButton: Column(
      //   //mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     CustomButtonPoS(
      //         icon: Icons.plus_one,
      //         onPress: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               //QR Reader see mor examples in:
      //               //https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/

      //               //and about the library
      //               // https://pub.dev/packages/mobile_scanner/

      //               builder: (context) => const QrReaderCodeWindow(),
      //             ),
      //           );

      //           clickCounter++;
      //           //Order to update all the view with modified
      //           setState(() {});
      //         }),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const HomePosScreen(),

      // const SizedBox(
      //   height: 10,
      // ),
      // CustomButton(
      //     icon: Icons.exposure_minus_1_outlined,
      //     onPress: () {
      //       if (clickCounter == 0) return;
      //       clickCounter--; //Order to update all the view with modified
      //       setState(() {});
      //     })
    );
  }
}
