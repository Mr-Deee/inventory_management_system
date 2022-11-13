import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/toast.dart';
import '../models/product.dart';
import '../utils/color_palette.dart';
import '../widgets/location_drop_down.dart';

class SalesDetailsPage extends StatefulWidget {

  const SalesDetailsPage({Key? key, this.product,this.docID,this.productimage,this.productprice, this.productp})
      : super(key: key);
  final productprice;
  final productimage;
final Product? product;
  final String? docID;


  final productp ;



  @override
  State<SalesDetailsPage> createState() => _SalesDetailsPageState(product,docID,productprice, productimage,productp);
}
class _SalesDetailsPageState extends State<SalesDetailsPage> {

  int _n = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Product? product;

  final String? docID;
  final prodprice;
  double? finalprice = 0.0;
  int? updatedquantity= 0;
  final productimage;
  int counter = 1;
  final productp;


  _SalesDetailsPageState(this.product, this.docID, this.prodprice,
      this.productimage, this.productp);


  void increment() {
    setState(() {
      counter++;
      finalprice = double.parse(productp) * counter;
    });
  }

  void decrement() {
    setState(() {
      counter--;
      finalprice = double.parse(productp) * counter;
    });
  }


  @override
  void initState() {
    super.initState();
    // final productp =prodprice.replaceAll(new RegExp(r'\$'), '');

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {

            UploadSales(context);
          },
          //   _firestore
          //       .collection("Sales")
          //       .doc(docID)
          //       .update(product!.toMap())
          //       .then((value) {
          //     showTextToast('Updated Sucessfully!');
          //   }).catchError((e) {
          //     showTextToast('Failed!');
          //   });
          //   Navigator.of(context).pop();
          // },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: ColorPalette.brown,
          child: const Icon(
            Icons.done,
            color: ColorPalette.pacificBlue,
          ),
        ),
      ),
      body: Container(
        color: ColorPalette.brown,
        child: SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 15,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: ColorPalette.brown,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            "Perform Sales",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              color: ColorPalette.timberGreen,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 50,
                                  ),
                                  margin: const EdgeInsets.only(top: 75),
                                  decoration: const BoxDecoration(
                                    color: ColorPalette.brown,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 12,
                                          ),
                                          child: Text(
                                            "Product Group : ${product!.group}",
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              color: ColorPalette.nileBlue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.brown,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            readOnly: true,
                                            initialValue: product!.name ?? '',
                                            onChanged: (value) {
                                              product!.name = value;
                                            },
                                            textInputAction:
                                            TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Product Name",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                            ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.brown,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue:
                                                  product!.cost == null
                                                      ? ''
                                                      : product!.cost
                                                      .toString(),
                                                  onChanged: (value) {
                                                    product!.cost =
                                                        double.parse(value);
                                                  },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Cost",
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                  ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.brown,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  initialValue:
                                                  product!.quantity == null
                                                      ? ''
                                                      : product!.quantity
                                                      .toString(),
                                                  onChanged: (value) {
                                                    product!.quantity =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Quantity",
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                  ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.brown,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            readOnly: true,
                                            initialValue:
                                            product!.description ?? '',
                                            onChanged: (value) {
                                              product!.description = value;
                                            },
                                            textInputAction:
                                            TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                            ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(20),
                                              ),

                                              border: Border.all(
                                                  width: 4,
                                                  color: ColorPalette.brown),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.transparent
                                                        .withOpacity(0.1),
                                                    offset: const Offset(0, 10))
                                              ]
                                          ),

                                          height: 107.0,
                                          width: width,


                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        finalprice.toString() ??
                                                            ""),
                                                  ],
                                                ),


                                                new Container(
                                                  height: 50,
                                                  child: new Center(
                                                    child: new Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: <Widget>[
                                                        new FloatingActionButton(
                                                          onPressed: add,
                                                          child: new Icon(
                                                            Icons.add,
                                                            color: Colors
                                                                .black,),
                                                          backgroundColor: ColorPalette
                                                              .brown,),

                                                        new Text('$_n',
                                                            style: new TextStyle(
                                                                fontSize: 20.0)),

                                                        new FloatingActionButton(
                                                            onPressed: minus,
                                                            child: new Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .black),
                                                            backgroundColor: ColorPalette
                                                                .brown),
                                                      ],
                                                    ),
                                                  ),
                                                ),





                                              ],
                                            ),
                                          ),
                                        )


                                        // const Padding(
                                        //   padding: EdgeInsets.only(
                                        //     left: 8,
                                        //     bottom: 5,
                                        //   ),
                                        //   child: Text(
                                        //     "Cement Type",
                                        //     style: TextStyle(
                                        //       fontFamily: "Nunito",
                                        //       fontSize: 14,
                                        //       color: ColorPalette.nileBlue,
                                        //     ),
                                        //   ),
                                        // ),
                                        // CementTypeDD(product: product),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Container(
                                          color: ColorPalette.white,
                                          child: Container(
                                            color: ColorPalette.timberGreen
                                                .withOpacity(0.1),
                                            child:
                                            //
                                            // (product!.image == null)
                                            //     ? Center(
                                            //   child: Icon(
                                            //     Icons.image,
                                            //     color: ColorPalette
                                            //         .nileBlue
                                            //         .withOpacity(0.5),
                                            //   ),
                                            // )
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Image.asset(
                                                  'Assets/images/c04.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void minus() {
    setState(() {
      final String? newproductprice = product!.cost.toString();
      final int? newproductquantity = product!.quantity;


      if (_n != 0){
        _n--;
      finalprice = double.parse(newproductprice!) * _n;
      updatedquantity= (newproductquantity! +_n);
    }
      else if(_n==0){
        _n;

      }


    });
  }

  void add() {
    setState(() {
      final String? newproductprice = product!.cost.toString();
      final int? newproductquantity = product!.quantity;
      _n++;
      finalprice = double.parse(newproductprice!) * _n;
      updatedquantity= (newproductquantity! -_n) ;
    });
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void>  UploadSales(BuildContext context)async {
    User? user = await FirebaseAuth.instance.currentUser;
    updateproductdetails(context);

    await FirebaseFirestore.instance.collection('Transactions').doc().set({
      "name": product?.name,
      "cost": product?.cost,
      "group": product?.group,
      "CementType": product?.CementType,
      "quantity": product?.quantity,
      "SalesPrice":finalprice,
      'SoldQuantity':_n,


      "description": product?.description,


    });

    Navigator.of(context).pop();

        }




Future<void>updateproductdetails(BuildContext context) async
{
  _firestore
      .collection("products")
      .doc(docID)
      .update({
    'quantity': updatedquantity
  }
  )
      .then((value) {
    showTextToast('Updated Sucessfully!');
  }).catchError((e) {

    showTextToast('failed');
  });
  //Navigator.of(context).pop();
}

}