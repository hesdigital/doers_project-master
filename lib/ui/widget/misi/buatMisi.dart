import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:doers_project/ui/widget/misi/listDaftarMisi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BuatMisiScreen extends StatefulWidget {
  @override
  _BuatMisiScreenState createState() => _BuatMisiScreenState();
}

class _BuatMisiScreenState extends State<BuatMisiScreen> {
  TextEditingController _controllerJudulMisi = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();
  TextEditingController _controllerHarga = TextEditingController();

  var _hari = 0;
  List _kategoriJasa = [
    'Rumah Tangga',
    'Pertukangan',
    'Elektronik',
    'Otomotif',
    'Desain/Pemrogaman',
  ];

  File _image, _image2, _image3;
  bool _valNego = false;
  bool _loading = false;
  String _kategori;

  void getKategori(String s) {
    setState(() {
      _kategori = s;
    });
  }

  User _user = FirebaseAuth.instance.currentUser;

  DatabaseReference _reference =
      FirebaseDatabase.instance.reference().child('UserMisi');

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: themeColors,
              title: Text(
                'Buat Misi',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 32),
                    child: Text(
                      'Judul Misi',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      controller: _controllerJudulMisi,
                    ),
                  ),
                  Divider(
                    height: 60,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Pilih Kategori',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: DropdownButton(
                      hint: Text('Kategori'),
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
                  ),
                  Divider(
                    height: 30,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Estimasi Waktu',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() => _hari--);
                          }),
                      Text(
                        '$_hari',
                        style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() => _hari++);
                          }),
                      Text(
                        'Hari',
                        style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: Text(
                      'Catatan',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: TextFormField(
                        maxLines: 5,
                        minLines: 3,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: _controllerDeskripsi,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Catatan tidak boleh kosong!';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Divider(
                    height: 50,
                    thickness: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Harga',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              controller: _controllerHarga,
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return 'Harga tidak boleh kosong!';
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Nego',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 50,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Photo',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      primary: false,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: _getImage,
                            child: Container(
                              color: Colors.black12,
                              child: _image == null
                                  ? Icon(Icons.add)
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: _getImage2,
                            child: Container(
                              color: Colors.black12,
                              child: _image2 == null
                                  ? Icon(Icons.add)
                                  : Image.file(
                                      _image2,
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: _getImage3,
                            child: Container(
                              color: Colors.black12,
                              child: _image3 == null
                                  ? Icon(Icons.add)
                                  : Image.file(
                                      _image3,
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                          'Submit',
                          style: TextStyle(
                              fontFamily: 'montserrat medium',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          setState(() => _loading = true);
                          _saveMisi()
                              .whenComplete(() => Get.off(ListDaftarMisi()));
                        }),
                  ),
                ],
              ),
            ));
  }

  Future _getImage() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = img;
      print('image$_image');
    });
  }

  Future _getImage2() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image2 = img;
      print('image$_image2');
    });
  }

  Future _getImage3() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image3 = img;
      print('image$_image3');
    });
  }

  Future<void> _saveMisi() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    var snapshot1, snapshot2, snapshot3, url1, url2, url3;
    String email = _user.email;
    String namaMisi = _controllerJudulMisi.text;
    String kategori = _kategori;
    String estimasiWaktu = _hari.toString();
    String deskripsi = _controllerDeskripsi.text;
    // String tag1 = _tag1;
    String harga = _controllerHarga.text;

    snapshot1 =
        await _storage.ref().child(_user.email).putFile(_image).onComplete;
    url1 = await snapshot1.ref.getDownloadURL();
    //
    // snapshot2 =
    //     await _storage.ref().child(_user.email).child('ktp').putFile(_image2);
    // url2 = await snapshot2.ref.getDownloadURL();
    // snapshot3 =
    //     await _storage.ref().child(_user.email).child('ktp').putFile(_image3);
    // url3 = await snapshot3.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('list misi')
        .doc(namaMisi)
        .set({
      'namaJasa': namaMisi,
      'kategori': kategori,
      'estimasiWaktu': estimasiWaktu,
      'deskripsi': deskripsi,
      // 'tag1': _tag1,
      'harga': harga,
    }).then((value) {
      print('print ');
    });

    Map<String, String> _misinya = {
      'namaJasa': namaMisi,
      'kategori': kategori,
      'estimasiWaktu': estimasiWaktu,
      'deskripsi': deskripsi,
      // 'tag1': _tag1,
      'harga': harga,
      'email': email,
      'gambar1': url1,
      //
      // 'gambar2': url2,
      // 'gambar3': url3
    };
    _reference.push().set(_misinya);
  }
}
