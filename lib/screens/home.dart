import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/widgets/Sales_group%20_card.dart';

import '../functions/confirm_dialog.dart';
import '../functions/toast.dart';
import '../utils/color_palette.dart';
import '../widgets/Salescard.dart';
import '../widgets/product_group_card.dart';
import 'global_search_page.dart';
import 'login.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _newProductGroup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: const Text(
                    "Add Product Group",
                    style: TextStyle(
                        fontFamily: "Nunito", color: ColorPalette.brown),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              color: const Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        height: 50,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          key: UniqueKey(),
                          controller: _newProductGroup,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            color: ColorPalette.nileBlue,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product Group Name",
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 16,
                              color: ColorPalette.brown.withOpacity(0.58),
                            ),
                          ),
                          cursorColor: ColorPalette.timberGreen,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_newProductGroup.text != null &&
                              _newProductGroup.text != "") {
                            try {
                              final DocumentSnapshot<Map<String, dynamic>>
                                  _doc = await _firestore
                                      .collection("utils")
                                      .doc("productGroups")
                                      .get();
                              final List<dynamic> _tempList =
                                  _doc.data()!['list'] as List<dynamic>;
                              if (_tempList.contains(_newProductGroup.text)) {
                                showTextToast("Group Name already created");
                              } else {
                                _tempList.add(_newProductGroup.text);
                                _firestore
                                    .collection('utils')
                                    .doc("productGroups")
                                    .update({'list': _tempList});
                                showTextToast("Added Successfully");
                              }
                            } catch (e) {
                              showTextToast("An Error Occured!");
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            _newProductGroup.text = "";
                          } else {
                            showTextToast("Enter Valid Name!");
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorPalette.brown,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Nunito",
                                color: ColorPalette.pacificBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: ColorPalette.brown,
          child: const Icon(
            Icons.add,
            color: ColorPalette.pacificBlue,
          ),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Container(
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
                      left: 20,
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
                        const Text(
                          "Homepage",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 28,
                            color: ColorPalette.timberGreen,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              splashColor: ColorPalette.timberGreen,
                              icon: const Icon(
                                Icons.search,
                                color: ColorPalette.timberGreen,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const GlobalSearchPage(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.power_settings_new,
                                  color: ColorPalette.timberGreen,
                                ),
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        title: Text('Sign Out'),
                                        backgroundColor: Colors.white,
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  'Are you certain you want to Sign Out?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              print('yes');
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/login',
                                                  (route) => false);
                                              // Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              'Cancel',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ],
                        )
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
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                color: ColorPalette.pacificBlue,
                                fontSize: 20,
                                fontFamily: "Open Sans",
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Expanded(
                            //   child: StreamBuilder(
                            //     stream:
                            //         _firestore.collection("utils").snapshots(),
                            //     builder: (
                            //       BuildContext context,
                            //       AsyncSnapshot<
                            //               QuerySnapshot<Map<String, dynamic>>>
                            //           snapshot,
                            //     ) {
                            //       if (snapshot.hasData) {
                            //         final List<dynamic> _productGroups =
                            //             snapshot.data!.docs[0].data()['list']
                            //                 as List<dynamic>;
                            //         _productGroups.sort();
                            //         return GridView.builder(
                            //           gridDelegate:
                            //               const SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 1,
                            //             childAspectRatio: 2,
                            //             crossAxisSpacing: 20,
                            //             mainAxisSpacing: 20,
                            //           ),
                            //           itemCount: _productGroups.length,
                            //           itemBuilder: (context, index) {
                            //             return ProductGroupCard(
                            //               name: _productGroups[index] as String,
                            //               key: UniqueKey(),
                            //             );
                            //           },
                            //         );
                            //       } else {
                            //         return const Center(
                            //           child: SizedBox(
                            //             height: 40,
                            //             width: 40,
                            //             child: CircularProgressIndicator(
                            //               color: ColorPalette.pacificBlue,
                            //             ),
                            //           ),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: StreamBuilder(
                                      stream: _firestore
                                          .collection("utils")
                                          .snapshots(),
                                      builder: (
                                        BuildContext context,
                                        AsyncSnapshot<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>
                                            snapshot,
                                      ) {
                                        if (snapshot.hasData) {
                                          final List<dynamic> _productGroups =
                                              snapshot.data!.docs[0]
                                                      .data()['list']
                                                  as List<dynamic>;
                                          _productGroups.sort();
                                          return GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 2,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0,
                                            ),
                                            itemCount: _productGroups.length,
                                            itemBuilder: (context, index) {
                                              return ProductGroupCard(
                                                name: _productGroups[index]
                                                    as String,
                                                key: UniqueKey(),
                                              );
                                            },
                                          );
                                        } else {
                                          return const Center(
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator(
                                                color: ColorPalette.pacificBlue,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Column(
                                      children: [
                                        SalesGroupCard(
                                          sales: "SALES",

                                          //   //"_productGroups[index] as String",
                                          // key: UniqueKey(),
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Icon(Icons.person,
                                              size: 24,
                                              color: Colors.blueAccent),
                                          padding: const EdgeInsets.all(12),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(12),
                                                  bottomLeft:
                                                      Radius.circular(12))),
                                          child: Text("Student"),
                                          padding: const EdgeInsets.all(12),
                                        )
                                      ],
                                    ),
                                  )
                                  // SizedBox(
                                  //   height: 100,
                                  //   width: 200,
                                  //   child: Card(
                                  //       color: ColorPalette.brown,
                                  //       elevation:5,
                                  //      // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(30.0),
                                  //       ),
                                  //
                                  //       child: Column(
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(top:30.0),
                                  //             child: Text("Sales",style: TextStyle(fontSize: 30),),
                                  //           )
                                  //         ],
                                  //       )
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                            //
                            // Expanded(
                            //   child: StreamBuilder(
                            //     stream:
                            //     _firestore.collection("Sales").snapshots(),
                            //     builder: (
                            //         BuildContext context,
                            //         AsyncSnapshot<
                            //             QuerySnapshot<Map<String, dynamic>>>
                            //         snapshot,
                            //         ) {
                            //       if (snapshot.hasData) {
                            //         final List<dynamic> _productGroups =
                            //       //  snapshot.data!.docs[0].data()['list']
                            //         //as List<dynamic>;
                            //         //_productGroups.sort();
                            //         return GridView.builder(
                            //           gridDelegate:
                            //           const SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 1,
                            //             childAspectRatio: 2,
                            //             crossAxisSpacing: 20,
                            //             mainAxisSpacing: 20,
                            //           ),
                            //           itemCount: _productGroups.length,
                            //           itemBuilder: (context, index) {
                            //             return ProductGroupCard(
                            //               name: _productGroups[index] as String,
                            //               key: UniqueKey(),
                            //             );
                            //           },
                            //         );
                            //       } else {
                            //         return const Center(
                            //           child: SizedBox(
                            //             height: 40,
                            //             width: 40,
                            //             child: CircularProgressIndicator(
                            //               color: ColorPalette.pacificBlue,
                            //             ),
                            //           ),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // )
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
      ),
    );
  }
}
