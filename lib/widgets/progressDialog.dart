import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/color_palette.dart';

class ProgressDialog extends StatelessWidget {

  String message;
  ProgressDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorPalette.brown,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color:  ColorPalette.brown,
          borderRadius: BorderRadius.circular(6.0)
        ),
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
          children: [
            SizedBox(width: 6.0,),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorPalette.bondyBlue),),
            SizedBox(width: 26.0,),
            Text(
              message,
              style: TextStyle(color: ColorPalette.bondyBlue, fontSize: 10.0),

            ),

          ],
      ),
    ),



      ),
    );
  }
}
