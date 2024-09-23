import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberEditAttribute extends StatelessWidget {
  Function() increment;
  Function() decrement;
  FormFieldValidator<String> validatorFunction;
  int limitSize;

  final TextEditingController mcontroller;
  final String hintLabel;

  NumberEditAttribute({
    super.key,
    required this.mcontroller,
    required this.hintLabel,
    required this.increment,
    required this.decrement,
    required this.validatorFunction,
    required this.limitSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: const Color(0xFFececf8),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            maxLength: limitSize,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            controller: mcontroller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                counterText: "",
                prefixIcon: IconButton(
                    onPressed: decrement, icon: const Icon(Icons.remove)),
                suffixIcon: IconButton(
                    onPressed: increment, icon: const Icon(Icons.add)),
                border: InputBorder.none,
                hintText: hintLabel,
                hintStyle:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w300)),
            validator: validatorFunction));
  }
}
