import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/helperfunctions.dart';
import 'package:doers_project/ui/widget/menu/mainmenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataDiriGoogle extends StatefulWidget {
  @override
  _DataDiriGoogleState createState() => _DataDiriGoogleState();
}

class _DataDiriGoogleState extends State<DataDiriGoogle> {
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNamaKosong = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerTentang = TextEditingController();
  TextEditingController _controllerNoHp = TextEditingController();
  TextEditingController _controllerNoHpKosong = TextEditingController();

  bool _pwVisible;

  bool _isSuccess = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List _kategoriProvinsi = ['Lampung'];
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

  User _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pwVisible = true;

    _controllerNama.text = _user.displayName;
    _controllerNoHp.text = _user.phoneNumber;
    print(
        'print ' + _user.displayName + ' Tambah Nomor Hp ' + _user.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: themeColors,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back), onPressed: () {}),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data Diri',
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text('Isi Data Diri Anda',
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.off(MainMenu());
                        },
                        child: Text('Lewati',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 14,
                          ),
                          onPressed: () {
                            Get.off(MainMenu());
                          }),
                    ],
                  ),
                ),
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
                _user.displayName != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 24.0, left: 24.0, top: 8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: _controllerNama,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'Nama tidak boleh kosong!';
                              } else {
                                return null;
                              }
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            right: 24.0, left: 24.0, top: 8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: _controllerNamaKosong,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'Nama tidak boleh kosong!';
                              } else {
                                return null;
                              }
                            }),
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
                  padding:
                      const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
                  child: TextFormField(
                      maxLines: 5,
                      minLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: _controllerAlamat,
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
                  padding:
                      const EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0),
                  child: TextFormField(
                      maxLines: 5,
                      minLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: _controllerTentang,
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
                _user.phoneNumber != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 24.0, left: 24.0, top: 8.0),
                        child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: _controllerNoHp,
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'Nomor Hp tidak boleh kosong!';
                              } else {
                                return null;
                              }
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            right: 24.0, left: 24.0, top: 8.0),
                        child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: _controllerNoHpKosong,
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
                        _saveDataDiri().whenComplete(() => Get.off(MainMenu()));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveDataDiri() async {
    String namaLengkap = _controllerNama.text;
    String email = _user.email;
    String tentang = _controllerTentang.text;
    String noTelp = _controllerNoHp.text;
    String alamat = _controllerAlamat.text;


    HelperFunctions.saveUserNameSharedPreference(namaLengkap);
    HelperFunctions.saveUserEmailSharedPreference(email);

    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('Data Diri')
        .doc('Data')
        .set({
      'email': email,
      'displayName': namaLengkap,
      'alamat': alamat,
      'tentang': tentang,
      'noTelp': noTelp,
      'provinsi': _provinsi,
      'kabupaten': _kabupaten
    }).then((value) {
      setState(() {
        Get.back();
      });
    });
  }
}
