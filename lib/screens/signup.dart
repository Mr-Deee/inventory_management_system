import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:io' as io;


import '../main.dart';
import '../utils/color_palette.dart';
import '../utils/svg_strings.dart';
import '../widgets/custom_richtext.dart';
import '../widgets/progressDialog.dart';
import 'home.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String idScreen = "SignUpScreen";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _userName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
 User? firebaseUser;
  User? currentfirebaseUser;

  String get firstName => _userName.text.trim();

  String get lastName => _lastName.text.trim();

  String get email => _emailController.text.trim();

  String get password => _passwordController.text.trim();
  late String _email, _password, _UName, _lname, _mobileNumber,dateofBirth;


  String initValue = "Date Of Birth";
  bool isDateSelected = false;
  late DateTime birthDate; // instance of DateTime
  late String birthDateInString;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
                children: [
                  SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [



                                    Padding(
                                      padding: const EdgeInsets.only(top:50.0,left:30),
                                      child: SvgPicture.string(SvgStrings.warehouse),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const Text(
                                        "Inventory\nManagement",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0,left: 30),
                                      child: Row(
                                        children: [
                                          // SvgPicture.string(SvgStrings.location),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Sign Up",
                                            style: TextStyle(fontFamily: "Open_Sans", fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),



                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        //username
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 330,
                                              child: Container(
                                                margin: const EdgeInsets.all(10.0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    _UName = value;
                                                  },
                                                  //keyboardType: TextInputType.visiblePassword,
                                                  validator: (val) {
                                                    return val!.length > 6
                                                        ? null
                                                        : "User Name";
                                                  },
                                                  controller: _userName,
                                                  textCapitalization:
                                                  TextCapitalization.none,
                                                  decoration: InputDecoration(
                                                    hintText: 'User Name',
                                                    hintStyle: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFFb1b2c4),
                                                    ),
                                                    border: new OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius:
                                                      BorderRadius.circular(60),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(context)
                                                              .primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(60),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                    Colors.black.withOpacity(0.05),
                                                    contentPadding: EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 25.0,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.account_circle,
                                                      color: ColorPalette.bondyBlue,
                                                    ),
                                                    //
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),

                                        //email
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 330,
                                              child: Container(
                                                margin: const EdgeInsets.all(10.0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    _email = value;
                                                  },
                                                  keyboardType:
                                                  TextInputType.visiblePassword,
                                                  validator: (val) {
                                                    return val!.length > 6
                                                        ? null
                                                        : "Email ";
                                                  },
                                                  controller: _emailController,
                                                  textCapitalization:
                                                  TextCapitalization.none,
                                                  decoration: InputDecoration(
                                                    hintText: 'Email',
                                                    hintStyle: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFFb1b2c4),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius:
                                                      BorderRadius.circular(60),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(context)
                                                              .primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(60),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                    Colors.black.withOpacity(0.05),
                                                    contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 25.0,
                                                    ),
                                                    prefixIcon: const Icon(
                                                      Icons.email,
                                                      color: ColorPalette.bondyBlue,                                                    ),
                                                    //
                                                  ),
                                                ),
                                              ),
                                            ),



                                            //Date

                                          ],
                                        ),

                                        //Password
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 330,
                                              child: Container(
                                                margin: const EdgeInsets.all(10.0),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    _password = value;
                                                  },
                                                  keyboardType:
                                                  TextInputType.visiblePassword,
                                                  validator: (val) {
                                                    return val!.length > 6
                                                        ? null
                                                        : "password ";
                                                  },
                                                  obscureText: true,
                                                  controller: _passwordController,
                                                  textCapitalization:
                                                  TextCapitalization.none,
                                                  decoration: InputDecoration(
                                                      hintText: 'password',
                                                      hintStyle: const TextStyle(
                                                        fontSize: 13,
                                                        color: Color(0xFFb1b2c4),
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius:
                                                        BorderRadius.circular(60),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(context)
                                                                .primaryColor),
                                                        borderRadius:
                                                        BorderRadius.circular(60),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                      Colors.black.withOpacity(0.05),
                                                      contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 20.0,
                                                        horizontal: 25.0,
                                                      ),
                                                      prefixIcon: const Icon(
                                                        Icons.password,
                                                        color: ColorPalette.bondyBlue,
                                                      ),
                                                      suffixIcon: IconButton(
                                                          icon: const Icon(
                                                              Icons.visibility),
                                                          onPressed: () {})
                                                    //
                                                  ),
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                        SizedBox(
                                          width: 330,
                                          child: Container(
                                            margin: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                _mobileNumber = value;
                                              },
                                              keyboardType:
                                              TextInputType.number,
                                              validator: (val) {
                                                return val!.length > 6
                                                    ? null
                                                    : "password ";
                                              },

                                              controller: _phoneController,
                                              textCapitalization:
                                              TextCapitalization.none,
                                              decoration: InputDecoration(
                                                hintText: 'Phone Number',
                                                hintStyle: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFFb1b2c4),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                  BorderRadius.circular(60),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius.circular(60),
                                                ),
                                                filled: true,
                                                fillColor:
                                                Colors.black.withOpacity(0.05),
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                  horizontal: 25.0,
                                                ),
                                                prefixIcon: const Icon(
                                                  Icons.phone,
                                                  color: ColorPalette.bondyBlue,
                                                ),

                                                //
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: ()=> [
                                          if (_userName.text.length < 0)
                                            {
                                              displayToast(
                                                  "First Name must be at least 3 characters.", context),
                                            }
                                          else if(_lastName.text.length<0)
                                            {
                                              displayToast(
                                                  "Last Name must be at least 3 characters.", context),

                                            }
                                          else if (!_emailController.text.contains("@"))
                                              {
                                                displayToast("Email address is not Valid", context),
                                              }
                                            else if (_phoneController.text.isEmpty)
                                                {
                                                  displayToast("PhoneNumber are mandatory", context),
                                                }
                                              //
                                              else if (_passwordController.text.length < 6)
                                                  {
                                                    displayToast(
                                                        "Password must be atleast 6 Characters", context),
                                                  }
                                                else
                                                  {
                                                    registerNewUser(context),
                                                    registerInfirestore(context),


                                                  }
                                                ],
                                        child:Text( 'Sign Up'),

                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                            backgroundColor: MaterialStateProperty.all<Color>(ColorPalette.bondyBlue),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    side: BorderSide(color: ColorPalette.bondyBlue)
                                                )
                                            )
                                        )

                        ),
                                    ),



                                    CustomRichText(
                                      discription: 'Already Have an account? ',
                                      text: 'Log In here',
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  Login()));
                                      },
                                    )
                ],
              )),

      ]),

    ));
  }




  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering,Please wait.....",
          );
        });

    firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text)
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user!;

    if (firebaseUser != null) // user created

        {
      //save use into to database

      Map userDataMap = {

        "UserName": _userName.text.trim(),

        "email": _emailController.text.trim(),
        // "fullName": firstNameTextEditingController.text.trim()  +lastNameTextEditingController.text.trim(),
        "phone": _phoneController.text.trim(),
        // "Dob":birthDate,
        // "Gender":Gender,
      };
      users.child(firebaseUser!.uid).set(userDataMap);
      // Admin.child(firebaseUser!.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToast("Congratulation, your account has been created", context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return  Home();
        }),
      );
      Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }


  Future<void> registerInfirestore(BuildContext context) async {
    User? user = await FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set({
      'UserName': _UName,
      'MobileNumber': _mobileNumber,
      'Email': _email,
      'Password':_password,
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return SignInScreen();
    //   }),
    // );
  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
