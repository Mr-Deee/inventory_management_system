import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utils/color_palette.dart';

import '../functions/toast.dart';

class transactions extends StatefulWidget {
  const transactions({Key? key, this.docID}) : super(key: key);


  final String? docID;

  @override
  State<transactions> createState() => _transactionsState(docID);
}


class _transactionsState extends State<transactions> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String? docID;

  _transactionsState(this.docID);
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:ColorPalette.brown ,
      appBar: AppBar(
        backgroundColor: ColorPalette.brown,
        title: Text(
          "Transactions",
          style: TextStyle(fontSize: 29, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: size.height, maxHeight: size.height),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: size.height,
                child: StreamBuilder(
                    stream: _firestore
                        .collection("Transactions")
                        .where(
                          "group",
                        )
                        .orderBy('description')
                        .snapshots(),

                    //clientRequestRef.onValue,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot,
                    ) {
                      // print("$snap");

                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ListView.builder(
                            primary: false,
                            // physics: ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                           /*   print(
                                  '${snapshot.data?.docs[index]['SalesPrice']}');*/

                              var data = snapshot.data!.docs;
                              return Column(
                                  //  textDirection: TextDirection.ltr,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 0, right: 0),

                                      child: Card(
                                        color: ColorPalette.brown,
                                        shadowColor: Colors.grey,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            side: BorderSide(
                                                width: 2,
                                                color: Colors.white38)),
                                        child: ListView(
                                            primary: false,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0.0),
                                            children: <Widget>[
                                              //Text(Provider.of<OccupationModel>(context).Institution!,style: TextStyle(color: Colors.black),),
                                              Column(children: [
                                                // scrollDirection: Axis.horizontal,

                                                Column(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20.0),
                                                          child: Text(
                                                            snapshot.data?.docs[
                                                                    index]
                                                                ["CementType"],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .brown),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "GHC" +
                                                                  " " +
                                                                  data[index]["SalesPrice"].toString(),

                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                data[index]
                                                                ["name"].toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 19.0,
                                                                  right: 38),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child: Text(
                                                                  data[index]["quantity"]
                                                                          .toString() +
                                                                      " " +
                                                                      "pcs",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),


                                                              IconButton(icon:Icon(Icons.delete,color: Colors.brown,size: 30,),
                                                                  onPressed: (){
                                                                    DocumentSnapshot ds=snapshot.data?.docs[index] as DocumentSnapshot<Object?>;

                                                                    _firestore
                                                                        .collection("Transactions")
                                                                        .doc(ds.id)
                                                                        .delete()
                                                                        .then((value) {
                                                                      showTextToast('Deleted Sucessfully!');
                                                                    }).catchError((e) {
                                                                      showTextToast('Failed!');
                                                                    });

                                                                  }) //i want to delete item on click on this icon
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ])
                                            ]),
                                      ),
                                      // child: Container(
                                      //     margin: EdgeInsets.symmetric(
                                      //         vertical: 16.0),
                                      //     decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.only(
                                      //             topLeft: Radius.circular(25),
                                      //             topRight: Radius.circular(25),
                                      //             bottomLeft:
                                      //             Radius.circular(25),
                                      //             bottomRight:
                                      //             Radius.circular(25)),
                                      //         color: Colors.white,
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //               color: Colors.black38,
                                      //               blurRadius: 6,
                                      //               spreadRadius: 2,
                                      //               offset: Offset(0, 1))
                                      //         ]),
                                      //     height: 100,
                                      //     width: size.width,
                                      //
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.all(9.0),
                                      //
                                      //       child: Row(
                                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      //         children: [
                                      //
                                      //           Padding(
                                      //             padding: const EdgeInsets.all(8.0),
                                      //             child: Row(
                                      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //               children: [
                                      //                 Padding(
                                      //                   padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //                   child: Row(
                                      //                     children: [
                                      //                       Column(
                                      //                         children: [
                                      //
                                      //
                                      //                           Text(
                                      //
                                      //                             item[index]["client_name"],
                                      //
                                      //                           ),
                                      //
                                      //                         ],
                                      //                       ),
                                      //
                                      //
                                      //
                                      //                     ],
                                      //                   ),
                                      //
                                      //
                                      //                 ),
                                      //
                                      //                 //serviceType
                                      //
                                      //
                                      //
                                      //
                                      //               ],
                                      //             ),
                                      //           ),
                                      //
                                      //
                                      //           Row(
                                      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //             children: [
                                      //               Text(
                                      //
                                      //                 item[index]["service_type"],
                                      //
                                      //               ),
                                      //             ],
                                      //           ),
                                      //
                                      //
                                      //           Row (
                                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      //               children: [
                                      //                 SizedBox(
                                      //                   width: 60.0,
                                      //                   height: 50.0,
                                      //                   child: ElevatedButton(
                                      //                     style: ElevatedButton.styleFrom(
                                      //                       backgroundColor: Colors.white,
                                      //                       shape: RoundedRectangleBorder(
                                      //                           borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                               24.0),
                                      //                           side: const BorderSide(
                                      //                               color: Colors
                                      //                                   .white)),),
                                      //
                                      //                     onPressed:
                                      //                         () async {
                                      //                       launch(
                                      //                           ('tel://${data['client_phone'].toString()}'));
                                      //                     },
                                      //                     child: Padding(
                                      //                       padding:
                                      //                       const EdgeInsets
                                      //                           .all(
                                      //                           1.0),
                                      //                       child:
                                      //                       SingleChildScrollView(
                                      //                         scrollDirection:
                                      //                         Axis.horizontal,
                                      //                         child: Row(
                                      //                           mainAxisAlignment:
                                      //                           MainAxisAlignment
                                      //                               .spaceEvenly,
                                      //                           children: const [
                                      //                             Icon(
                                      //                               Icons
                                      //                                   .call,
                                      //                               color: Colors
                                      //                                   .black,
                                      //                               size:
                                      //                               26.0,
                                      //                             ),
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ])
                                      //
                                      //
                                      //
                                      //
                                      //           //Phone
                                      //
                                      //
                                      //         ],
                                      //       ),
                                      //     ))),
                                      // Text(
                                      //   "Client : " +
                                      //       data["client_name"]
                                      //           .toString(),
                                      // ),
                                    )
                                  ]);
                            },
                          ),
                        );

                        ///}
                      } else {
                        return Center(child: Text("Loading Data..."));
                      }
                      return CircularProgressIndicator();
                    }),

                // const SizedBox(
                //   height: 10,
                // ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> deleteindex(String docID)async {
    return _firestore.collection('Transactions').doc(docID).delete();
  }
}
