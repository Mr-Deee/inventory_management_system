import 'package:flutter/material.dart';

import '../screens/product_group_page.dart';
import '../utils/color_palette.dart';

class ProductGroupCard extends StatelessWidget {
  final String? name;
  final String? CementType;

  const ProductGroupCard({Key? key, this.name, this.CementType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ProductGroupPage(
                  name: name,
                );
              },
            ),
          );
        },
        child: Container(

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
            name!,
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
