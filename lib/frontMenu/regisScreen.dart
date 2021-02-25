import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/helperfunctions.dart';
import 'package:doers_project/ui/widget/menu/mainmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisScreen extends StatefulWidget {
  @override
  _RegisScreenState createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController tentangController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noHpController = TextEditingController();

  bool _pwVisible;

  bool _isSuccess = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List _kategoriProvinsi = [
   'Lampung'
  ];
  String _provinsi;

  List _kategoriKabupaten = [
    'Bandar Lampung ',
    'Metro',
    'Pesawaran',
    'Pringsewu',
    'Tanggamus',
    'Lampung Barat',
    'Lampung Selatan',
    'Lampung Timur',
    'Lampung Utara',
  ];
  String _kabupaten;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pwVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Column(children: [
          Text(
            'Daftar Akun',
            style: TextStyle(
                fontFamily: 'mentserrat medium',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Daftarkan diri anda',
              style: TextStyle(
                  fontFamily: 'mentserrat', fontSize: 12, color: Colors.black),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 24.0),
              child: Text(
                'Nama',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: namaController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    } else {
                      return null;
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0),
              child: Text(
                'Email',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: emailController,
                  autovalidate: true,
                  validator: (input) =>
                      input._isValidEmail() ? null : 'Email tidak valid!'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 24.0),
              child: Text(
                'Password',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
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
                  validator: (input) => input._isValidPw()
                      ? null
                      : 'Password harus terdiri dari huruf besar dan kecil dan angka!'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24.0),
              child: Text(
                'Alamat',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
              child: TextFormField(
                  maxLines: 5,
                  minLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: alamatController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Alamat tidak boleh kosong!';
                    } else {
                      return null;
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Provinsi',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      child: DropdownButtonFormField(
                        hint: Text(
                          "Provinsi",
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _provinsi,
                        items: _kategoriProvinsi.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _provinsi = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Kabupaten/Kota',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      child: DropdownButtonFormField(
                        hint: Text(
                          "Kabupaten/kota",
                          style: TextStyle(fontSize: 12),
                        ),
                        value: _kabupaten,
                        items: _kategoriKabupaten.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _kabupaten = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24.0),
              child: Text(
                'Tentang Anda',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
              child: TextFormField(
                  maxLines: 5,
                  minLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: tentangController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Tentang tidak boleh kosong!';
                    } else {
                      return null;
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0),
              child: Text(
                'Nomor Hp',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: noHpController,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Nomor Hp tidak boleh kosong!';
                    } else {
                      return null;
                    }
                  }),
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
                    'Daftar',
                    style: TextStyle(
                        fontFamily: 'montserrat medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  onPressed: () {
                    regisAcn().whenComplete(() => Get.to(MainMenu()));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> regisAcn() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: pwController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = _auth.currentUser;
      final String uidnya = user1.uid;
      user1.getIdToken().then((value) => print(value));

      String _email = emailController.text;
      String _alamat = alamatController.text;
      String _nama = namaController.text;
      String _tentangAnda = tentangController.text;
      String _noHp = noHpController.text;
      //

      HelperFunctions.saveUserNameSharedPreference(_nama);
      HelperFunctions.saveUserEmailSharedPreference(_email);

      FirebaseFirestore.instance
          .collection('Data Diri User')
          .doc(user1.email)
          .set({
        'email': _email,
        'displayName': _nama,
        'alamat': _alamat,
        'provinsi' : _provinsi,
        'kabupaten' : _kabupaten,
        'tentang': _tentangAnda,
        'nomorHp' : _noHp
      }).then((value) {
        setState(() {});
      });
    } else {
      _isSuccess = false;
    }
  }
}

extension EmailValidator on String {
  bool _isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PwValidator on String {
  bool _isValidPw() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(this);
  }
}
