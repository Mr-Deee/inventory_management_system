import 'package:flutter/material.dart';

import '../screens/product_group_page.dart';
import '../screens/sales_group_page.dart';
import '../utils/color_palette.dart';

class SalesGroupCard extends StatelessWidget {
  final String? sales;
  final String? CementType;

  const SalesGroupCard({Key? key, this.sales, this.CementType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SalesGroupdPage(
                  name: sales,
                );
              },
            ),
          );
        },
        child: Container(
            height: 90,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorPalette.brown,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.16),
              ),
            ],
          ),
          child: Text(
            sales!,
            style: const TextStyle(
              fontFamily: "Nunito",
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // TODO: Add counter
        ),
      ),
    );
  }
}
