import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
//import "package:pos_inoidsoft_app/presentation/home_screen.dart";

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
      //bottomNavigationBar: Container(),
      resizeToAvoidBottomInset: false,
      //extendBodyBehindAppBar: false,
      appBar: AppBar(
        title:
            const Text('Punto de Venta (Cajero)', textAlign: TextAlign.center),
        leading: IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () {
            setState(() {
              clickCounter = 0;
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  clickCounter += 5;
                });
              },
              icon: const Icon(Icons.update_disabled_rounded))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: const BottomAppBar(
        //shape: CircularNotchedRectangle(),
        //notchMargin: 6.0,
        child: Row(

            // Bottom navigation bar items go here

            ),
      ),
      body: const HomePosScreen(),

      floatingActionButton: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomButtonPoS(
              icon: Icons.plus_one,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    //QR Reader see mor examples in:
                    //https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/

                    //and about the library
                    // https://pub.dev/packages/mobile_scanner/

                    builder: (context) => const QrReaderCodeWindow(),
                  ),
                );

                clickCounter++;
                //Order to update all the view with modified
                setState(() {});
              }),
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
        ],
      ),
    );
  }
}
