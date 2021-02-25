import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/frontmenu/loginScreen.dart';
import 'package:doers_project/frontmenu/regisScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/helperfunctions.dart';
import 'package:doers_project/helper/sizeConfig.dart';
import 'package:doers_project/ui/widget/jasa/listJasaScreen.dart';
import 'package:doers_project/ui/widget/menu/dataDiriScreen.dart';
import 'package:doers_project/ui/widget/menu/kelolaPekerjaan.dart';
import 'package:doers_project/ui/widget/menu/riwayatPesanan.dart';
import 'package:doers_project/ui/widget/misi/listDaftarMisi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> getData() async {
    User login = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Data Diri User")
        .doc(user.email)
        .get();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String namaUser, email;
  bool _loginState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        print("user is logged in");

        //navigate to home page using Navigator Widget
      } else {
        print("user is not logged in");
        setState(() => _loginState = true);
        //navigate to sign in page using Navigator Widget
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _loginState
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Anda belum login/mendaftar!',
                  style: TextStyle(
                      fontFamily: 'montserrat medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
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
                        Get.off(LoginScreen());
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: MaterialButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white70,
                      minWidth: double.maxFinite,
                      child: Text(
                        'REGIS',
                        style: TextStyle(
                            fontFamily: 'montserrat medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        Get.off(RegisScreen());
                      }),
                ),
              ],
            )
          : SingleChildScrollView(
            child: Stack(
                overflow: Overflow.visible,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: themeColors,
                        height: 220,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15, top: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png')),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  height: 20,
                                ),
                                Container(
                                  //color: Colors.white,
                                  height: 100,
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: FutureBuilder(
                                      future: getData(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            user.displayName != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30.0, left: 8.0),
                                                    child: Text(
                                                      user.displayName,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: 'montserrat',
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30.0, left: 8.0),
                                                    child: Text(
                                                      snapshot.data
                                                          .data()['displayName'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: 'montserrat',
                                                      ),
                                                    ),
                                                  ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'verified status',
                                                style: (TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'montserrat')),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.black,
                                                    size: 12,
                                                  ),
                                                  Text(
                                                    '4.2',
                                                    style: (TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontFamily:
                                                            'montserrat')),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                )
                              ])
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 8.0, bottom: 8.0),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              fontFamily: 'montserra',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(DataDiriScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 40,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Data Diri',
                                  style: TextStyle(
                                    fontFamily: 'montserra',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(Icons.chevron_right),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 35,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 8.0),
                        child: Text(
                          'Pesanan Saya',
                          style: TextStyle(
                              fontFamily: 'montserra',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 40,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(RiwayatPesanan());
                                },
                                child: Text(
                                  'Riwayat Pesanan',
                                  style: TextStyle(
                                    fontFamily: 'montserra',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 35,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 8.0),
                        child: Text(
                          'Misi',
                          style: TextStyle(
                              fontFamily: 'montserra',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 40,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ListDaftarMisi());
                                },
                                child: Text(
                                  'Kelola Misi',
                                  style: TextStyle(
                                    fontFamily: 'montserra',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 35,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 8.0),
                        child: Text(
                          'Pekerjaan',
                          style: TextStyle(
                              fontFamily: 'montserra',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 40,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ListJasaScreen());
                                },
                                child: Text(
                                  'Jasa Saya',
                                  style: TextStyle(
                                    fontFamily: 'montserra',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 40,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(KelolaPekerjaan());
                                  },
                                  child: Text(
                                    'Kelola Pekerjaan',
                                    style: TextStyle(
                                      fontFamily: 'montserra',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(Icons.chevron_right),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 35,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            'Support',
                            style: TextStyle(
                                fontFamily: 'montserra',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 40,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontFamily: 'montserra',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 40,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Version',
                                  style: TextStyle(
                                    fontFamily: 'montserra',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(Icons.chevron_right),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 40,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    _signOut().whenComplete(
                                        () => Get.off(LoginScreen()));
                                  },
                                  child: Text(
                                    'Keluar',
                                    style: TextStyle(
                                        fontFamily: 'montserra',
                                        fontSize: 12,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
    );
  }

  Future<void> _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    HelperFunctions.deleteUserEmailSharedPreference();
    HelperFunctions.deleteUserEmailSharedPreference();
    await FirebaseAuth.instance.signOut();
  }
}
