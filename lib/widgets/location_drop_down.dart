import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/color_palette.dart';

class CementTypeDD extends StatefulWidget {
  final Product? product;

  const CementTypeDD ({Key? key, this.product}) : super(key: key);
  @override
  _CementTypeDDState createState() => _CementTypeDDState();
}

class _CementTypeDDState extends State<CementTypeDD > {
  final List<String> CementType = [
    "Ordinary Portland Cement",
    "Quick Setting Cement",
    "Portland Pozzsana Cement",
    "Low  heat Cement",
    "White Cement"
    "Expansive heat \nCement",

  ];
  @override
  Widget build(BuildContext context) {
    widget.product!.CementType ??= CementType[0];
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 6,
            color: ColorPalette.nileBlue.withOpacity(0.1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2.5),
      child: SingleChildScrollView(

        child: DropdownButton(
          iconSize: 30,
          underline: const SizedBox(),
          value: widget.product!.CementType,
          onChanged: (dynamic newValue) {
            setState(() {
              widget.product!.CementType = newValue as String?;
            });
          },
          items: CementType.map((process) {
            return DropdownMenuItem(
              value: process,
              child: Text(
                process,
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 16,
                  color: ColorPalette.nileBlue.withOpacity(0.58),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
