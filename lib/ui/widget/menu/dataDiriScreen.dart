import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DataDiriScreen extends StatefulWidget {
  @override
  _DataDiriScreenState createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNamaGoogle = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNoHp = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerTentang = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseMethods _databaseMethods = DatabaseMethods();

  var _instansi;

  int _heightKeahlian = 30;

  String _namaSekolah = '';
  String _jurusan = '';
  String _pendidikan = '';
  String _kemampuan = '';
  bool _loading = false;

  User _usernya = FirebaseAuth.instance.currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List _listKeahlian = [];
  List _ListPendidikan = [];

  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User _user = _auth.currentUser;
    var _email = _user.email;
    _controllerEmail.text = _usernya.email;
    _controllerNamaGoogle.text = _usernya.displayName;
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? LoadingPage() : Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: themeColors,
        title: Text(
          'Data Diri',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'montserrat',
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 36.0),
                        child: Icon(
                          Icons.edit,
                          size: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: Text(
                          'Nama Lengkap',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'),
                        ),
                      )
                    ],
                  ),
                  _usernya.displayName == ''
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: TextField(
                            controller: _controllerNamaGoogle,
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: TextField(
                            controller: _controllerNama,
                          ),
                        ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 36.0),
                        child: Icon(
                          Icons.email,
                          size: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: TextField(
                      controller: _controllerEmail,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 36.0),
                        child: Icon(
                          Icons.article,
                          size: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: Text(
                          'Tentang Anda',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: TextField(
                      controller: _controllerTentang,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 36.0),
                        child: Icon(
                          Icons.phone,
                          size: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: Text(
                          'No HP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: TextField(
                      controller: _controllerNoHp,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 24.0),
                        child: Icon(
                          Icons.place,
                          size: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Alamat',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 24.0, left: 24.0, top: 8.0),
                    child: TextFormField(
                        maxLines: 5,
                        minLines: 3,
                        keyboardType: TextInputType.emailAddress,
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
                  Divider(
                    height: 35,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      'Pendidikan Terakhir',
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  // _listKeahlian.length == 0
                  //     ? Center(child: Container(child: Text('')))
                  //     : Container(
                  //         height: MediaQuery.of(context).size.height / 10,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0),
                  //           child: ListView.builder(
                  //               itemCount: _listKeahlian.length,
                  //               itemBuilder: (context, index) {
                  //                 return ListTile(
                  //                   title: Text(_instansi),
                  //                   subtitle: Text(_pendidikanTerakhir),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Text('Tambah Pendidikan'),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                              ),
                              onPressed: () {
                                showInformationDialog(context);
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      _namaSekolah,
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      '$_pendidikan, ' + _jurusan,
                      style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Text('Keahlian'),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                showInformationDialogKeahlian(context);
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      _kemampuan,
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  // _listKeahlian.length == 0
                  //     ? Center(child: Container(child: Text('')))
                  //     : Container(
                  //         height: MediaQuery.of(context).size.height / 10,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0),
                  //           child: ListView.builder(
                  //               itemCount: _listKeahlian.length,
                  //               itemBuilder: (context, index) {
                  //                 return ListTile(
                  //                   title: Text(_instansi),
                  //                   subtitle: Text(_pendidikanTerakhir),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: MaterialButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: themeColors,
                            // minWidth: double.maxFinite,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontFamily: 'montserrat', fontSize: 14),
                            ),
                            onPressed: () {
                              setState(() => _loading = true);
                              _saveDataDiri().whenComplete(() => Get.back());
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: MaterialButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white60,
                            // minWidth: double.maxFinite,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontFamily: 'montserrat', fontSize: 14),
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future<void> _saving() async {
    String namaLengkap = _controllerNama.text;
    String email = _controllerEmail.text;
    String tentang = _controllerTentang.text;
    String noTelp = _controllerNoHp.text;
    String alamat = _controllerAlamat.text;

    Map<String, dynamic> dataDiri = {
      'email': email,
      'displayName': namaLengkap,
      'alamat': alamat,
      'tentang': tentang,
      'noTelp': noTelp,
      'pendidikan': _pendidikan,
      'namaSekolah': _namaSekolah,
      'jurusan': _jurusan,
      'keahlian': _kemampuan
    };

    _databaseMethods.addUserInfo(dataDiri, email);
  }

  Future<void> _saveDataDiri() async {
    String namaLengkap = _controllerNama.text;
    String email = _controllerEmail.text;
    String tentang = _controllerTentang.text;
    String noTelp = _controllerNoHp.text;
    String alamat = _controllerAlamat.text;

    Map<String, dynamic> dataDiri = {
      'email': email,
      'displayName': namaLengkap,
      'alamat': alamat,
      'tentang': tentang,
      'noTelp': noTelp,
      'pendidikan': _pendidikan,
      'namaSekolah': _namaSekolah,
      'jurusan': _jurusan,
      'keahlian': _kemampuan
    };

    _databaseMethods.addUserInfo(dataDiri, email);

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
      'pendidikan': _pendidikan,
      'namaSekolah': _namaSekolah,
      'jurusan': _jurusan,
      'keahlian': _kemampuan
    }).then((value) {
      setState(() {
        // Get.back();
      });
    });
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          List _kategoriJasa = [
            'SD',
            'SMP',
            'SMA',
            'S1',
            'S2',
          ];
          String _kategori;

          final TextEditingController _controllerJurusan =
              TextEditingController();
          final TextEditingController _controllerNamaSekolah =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        hint: Text('Pendidikan Terakhir'),
                        value: _kategori,
                        items: _kategoriJasa.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _kategori = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: TextFormField(
                          controller: _controllerNamaSekolah,
                          validator: (value) {
                            return value.isNotEmpty ? null : "Invalid Field";
                          },
                          decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(8)),
                              hintText: "Nama Sekolah/Universitas"),
                        ),
                      ),
                      TextFormField(
                        controller: _controllerJurusan,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(8)),
                            hintText: "Jurusan"),
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Tambah'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // String instansi = _controllerInstansi.text;
                      // String pendidikan = _controllerPendidikan.text;
                      setState(() {
                        _namaSekolah = _controllerNamaSekolah.text;
                        _jurusan = _controllerJurusan.text;
                        _pendidikan = _kategori;

                        print('Nama instansi ' + _namaSekolah + 'jurusan '+_jurusan + 'pendidikan ' + _pendidikan);
                      });
                      // _tambahPendidikan();
                      Navigator.of(context).pop();
                      // _heightKeahlian = 5;
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> showInformationDialogKeahlian(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _controllerKeahlian =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _controllerKeahlian,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Invalid Field";
                        },
                        decoration:
                            InputDecoration(hintText: "Tambah Keahlian"),
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: Text('Tambah'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      String keahlian = _controllerKeahlian.text;
                      setState(() {
                        _kemampuan = _controllerKeahlian.text;
                        // _keahlian = keahlian;
                      });
                      // _tambahKeahlian();
                      Navigator.of(context).pop();
                      // _heightKeahlian = 5;
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Map _data;

  Future<void> takeDataDiri() async {
    QuerySnapshot _snapshot =
        await DatabaseMethods().getUserInfo(_usernya.email);
  }

  void _fetchData() {
    DocumentReference _collection = FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(_usernya.email)
        .collection('Data Diri')
        .doc('Data');

    _collection.snapshots().listen((snapshot) {
      setState(() {
        _data = snapshot.data();
        print('datanya ' + _data.toString());
        _controllerNama.text = _data['displayName'].toString();
        _controllerTentang.text = _data['tentang'].toString();
        _controllerNoHp.text = _data['noTelp'].toString();
        _controllerAlamat.text = _data['alamat'].toString();
        _kemampuan = _data['keahlian'].toString();
        _pendidikan = _data['pendidikan'].toString();
        _namaSekolah = _data['namaSekolah'].toString();
        _jurusan = _data['jurusan'].toString();
      });
    });
  }

  // Future<void> _updateData() async {
  //   var snapshot, url;
  //
  //   String namaLengkap = _controllerNama.text;
  //   String email = _controllerEmail.text;
  //   String tentang = _controllerTentang.text;
  //   String noTelp = _controllerNoHp.text;
  //   String alamat = _controllerAlamat.text;
  //
  //   Map<String, String> _dataDiri = {
  //     'displayName': namaLengkap,
  //     'email': email,
  //     'tentang': tentang,
  //     'noTelp': noTelp,
  //     'alamat': alamat,
  //   };
  //
  //   FirebaseFirestore.instance
  //       .collection('Data Diri User')
  //       .doc(_usernya.email)
  //       .update(_dataDiri)
  //       .then((value) => Get.back());
  // }

  Future<DocumentSnapshot> _getData() async {
    User login = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Data Diri User")
        .doc(_usernya.email)
        .get();
  }
}
