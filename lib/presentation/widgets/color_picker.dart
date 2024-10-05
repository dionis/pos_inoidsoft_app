import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Detail/edit_item.dart';

import '../../constant.dart';

class ColorPicker extends StatefulWidget {
  dynamic action;

  ColorPicker({required this.action});

  @override
  _ColorPickerState createState() => _ColorPickerState(setPickedColor: action);
}

class _ColorPickerState extends State<ColorPicker> {
  late Map<String, Color> colors;

  Function(Color) setPickedColor;

  String selectedColor = 'Rojo'; // Inicializar el valor seleccionado

  _ColorPickerState({required this.setPickedColor}) {
    //Set internacionalizacion config
    colors = colorCodesEs;
    selectedColor = colors.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: colors[selectedColor],
      items: colors.keys.map((key) {
        return DropdownMenuItem(
          value: colors[key],
          child: Container(
            alignment: Alignment.center,
            color: colors[key]!,
            child: Text(
              key,
              style: TextStyle(
                  color:
                      colors[key] != Colors.black ? Colors.black : Colors.white,
                  background: Paint()
                    ..strokeWidth = 30.0
                    ..color = colors[key]!
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedColor = colors.keys
              .toList()
              .firstWhere((color) => colors[color] == value)
              .toString();

          setPickedColor(Color(colors[selectedColor]!.value));
        });
      },
    );
  }
}
