import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../functions/toast.dart';
import '../models/product.dart';
import '../screens/product_details_page.dart';
import '../utils/color_palette.dart';
import 'package:inventory_management_system/screens/saledetails.dart';

class salesCard extends StatelessWidget {
  final Product? product;
  final String? docID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   salesCard({Key? key, this.product, this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SalesDetailsPage(
              docID: docID,
              product: product,

            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 147,
        decoration: BoxDecoration(
          color: ColorPalette.brown,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 6,
              color: const Color(0xff000000).withOpacity(0.06),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
                height: 87,
                width: 87,
                // child: (product!.image == null)
                //     ? Center(
                //   child: Icon(
                //     Icons.image,
                //     color: ColorPalette.nileBlue.withOpacity(0.5),
                //   ),
                // )
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Image.asset('Assets/images/c04.png'),
                      ),
                    ])
                //
                //   ClipRRect(
                //   borderRadius: BorderRadius.circular(11),
                //   child: CachedNetworkImage(
                //     fit: BoxFit.cover,
                //     imageUrl:"Assets/images/c04.png",
                //
                //     //product!.image!,
                //     errorWidget: (context, s, a) {
                //       return Icon(
                //         Icons.abc_rounded,
                //         color: ColorPalette.nileBlue.withOpacity(0.5),
                //       );
                //     },
                //   ),
                // ),
                ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.CementType ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.timberGreen,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        // Icon(
                        //   Icons.location_on,
                        //   size: 14,
                        //   color: ColorPalette.timberGreen.withOpacity(0.44),
                        // ),
                        Text(
                          product!.name ?? '-',
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 12,
                            color: ColorPalette.timberGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        product!.group ?? '-',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          top: 2,
                          right: 5,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                      Text(
                        product!.company ?? '-',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.timberGreen.withOpacity(0.44),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // width: 100,
                    child: Text(
                      product!.description ?? '-',
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 11,
                        color: ColorPalette.timberGreen.withOpacity(0.35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "GHC ${product!.cost ?? '-'}",
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 14,
                      color: ColorPalette.nileBlue,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${product!.quantity ?? '-'}\nAvailable",
                        style: const TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 12,
                          color: ColorPalette.nileBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: ColorPalette.timberGreen,
                    ),
                    onPressed: () {

                      _firestore
                          .collection("Sales")
                          .doc(docID)
                          .delete()
                          .then((value) {
                        showTextToast('Deleted Sucessfully!');
                      }).catchError((e) {
                        showTextToast('Failed!');
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
