import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/frontmenu/interestScreen.dart';
import 'package:doers_project/frontmenu/regisScreen.dart';
import 'package:doers_project/helper/helperfunctions.dart';
import 'package:doers_project/ui/widget/menu/dataDiriGoogle.dart';
import 'package:doers_project/ui/widget/views/loading.dart';
import 'package:doers_project/ui/widget/menu/mainmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;

  bool _pwVisible;

  GoogleSignIn _googlSignIn = new GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pwVisible = true;
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        print("user is logged in");
        Get.off(MainMenu());
        //navigate to home page using Navigator Widget
      } else {
        print("user is not logged in");
        //navigate to sign in page using Navigator Widget
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeColors,
        body: _loading
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: Center(
                                child: Image.asset('asset/images/logo.png')),
                          )
                        ],
                      ),
                      Container(
                        transform: Matrix4.translationValues(0, 180, 1),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 90.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 24.0),
                                  child: Container(
                                    width: 100,
                                    child: Text(
                                      "Selamat Datang!",
                                      style: TextStyle(
                                          fontFamily: 'montserrat medium',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.off(InterestScreen());
                                    },
                                    child: Text(
                                      'Lewati',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'montserrat'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Icon(Icons.arrow_forward),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 35.0, left: 24.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontFamily: 'montserrat medium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 24.0, left: 24.0, top: 8.0),
                              child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  controller: emailController,
                                  autovalidate: true,
                                  validator: (input) => input.isValidEmail()
                                      ? null
                                      : 'Email tidak valid!'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 24.0),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    fontFamily: 'montserrat medium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 24.0, left: 24.0, top: 8.0),
                              child: TextFormField(
                                  obscureText: _pwVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(_pwVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _pwVisible = !_pwVisible;
                                          });
                                        }),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  controller: pwController,
                                  autovalidate: true,
                                  validator: (input) => input.isValidPw()
                                      ? null
                                      : 'Password harus terdiri dari huruf besar dan kecil dan angka!'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: MaterialButton(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: themeColors,
                                  minWidth: double.maxFinite,
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontFamily: 'montserrat medium',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  onPressed: () {
                                    setState(() => _loading = true);
                                    loginAcn().whenComplete(
                                        () => Get.off(MainMenu()));
                                  }),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Login dengan',
                                  style: TextStyle(
                                      fontFamily: 'montserrat medium',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon:
                                        Image.asset('asset/images/google.png'),
                                    onPressed: () {
                                      _signInGoogle(context).whenComplete(
                                          () => Get.off(DataDiriGoogle()));
                                    }),
                                IconButton(
                                    icon: Image.asset('asset/images/fb.png'),
                                    onPressed: () {})
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('tidak punya akun?'),
                                  InkWell(
                                    onTap: () {
                                      Get.off(RegisScreen());
                                    },
                                    child: Text(
                                      'Daftar',
                                      style: TextStyle(
                                          fontFamily: 'montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  GoogleSignIn _googleSignIn;
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future loadUser() async {
    User _tempUser = _auth.currentUser;
    if (_tempUser != null) {
      print('user login');
      //  goto MainPage(mainUser:_tempUser);
    } else {
      print('user kosong');
    }
  }

  Map _data;

  Future<void> loginAcn() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: pwController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = _auth.currentUser;
      final String uid = user1.uid;
      user1.getIdToken().then((value) => print('Token nya ' + value));
      print('Usernya ' + user1.toString());
      String fcmToken = await _fcm.getToken();
// Save it to Firestore
      if (fcmToken != null) {
        var tokens = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('tokens')
            .doc(fcmToken);

        await tokens.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
        });
      }
      //
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', user1.email);
      HelperFunctions.saveUserEmailSharedPreference(user1.email);

      DocumentReference _collection = FirebaseFirestore.instance
          .collection('Data Diri User')
          .doc(user1.email)
          .collection('Data Diri')
          .doc('Data');

      _collection.snapshots().listen((snapshot) {
        setState(() {
          _data = snapshot.data();
          print('datanya ' + _data.toString());
          HelperFunctions.saveUserNameSharedPreference(
              _data['displayName'].toString());
        });
      });
    } else {
      _loading = false;
    }
  }

  Future<User> _signInGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        (await _auth.signInWithCredential(credential));
    User userDetails = userCredential.user;
    print('info ' + userDetails.email);
    return userDetails;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PwValidator on String {
  bool isValidPw() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(this);
  }
}
