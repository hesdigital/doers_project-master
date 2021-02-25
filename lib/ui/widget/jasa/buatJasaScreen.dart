import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:doers_project/ui/widget/jasa/listJasaScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class BuatJasaScreen extends StatefulWidget {
  @override
  _BuatJasaScreenState createState() => _BuatJasaScreenState();
}

class _BuatJasaScreenState extends State<BuatJasaScreen> {
  DatabaseReference _reference = FirebaseDatabase.instance.reference().child('UserJasa');

  TextEditingController _controllerJudulJasa = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();
  TextEditingController _controllerHarga = TextEditingController();

  List _tags = [];

  String _helperTag = 'Masukan 1 tag';

  List _kategoriJasa = [
    'Desain Grafis',
    'Elektronik',
    'Gaya Hidup',
    'Pertukangan',
    'Rumah tangga',
  ];
  String _kategori;

  File _image, _image2, _image3;
  bool _valNego = false;
  bool _loading = false;
  var _hari = 0;

  String _tag1, _tag2, _tag3;
  DatabaseReference _ref;
  User _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('UserJasa');
    print('email ' + _user.email);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: themeColors,
              title: Text(
                'Buat Jasa',
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
                      'Nama Jasa',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextField(
                      controller: _controllerJudulJasa,
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
                      hint: Text("Kategori"),
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
                          print(value);
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
                            print('jumlah $_hari hari');
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
                      'Deskripsi',
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: _controllerDeskripsi,
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Deskripsi tidak boleh kosong!';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Divider(
                    height: 50,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: Text(
                      'Tags',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TextFieldTags(
                        tagsStyler: TagsStyler(
                          tagTextStyle:
                              TextStyle(fontWeight: FontWeight.normal),
                          tagDecoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          tagPadding: const EdgeInsets.all(6.0),
                          tagCancelIcon: Icon(Icons.cancel,
                              size: 18.0, color: Colors.black),
                        ),
                        textFieldStyler: TextFieldStyler(
                          hintText: 'tag',
                          helperText: _helperTag,
                        ),
                        onTag: (t) {
                          setState(() {
                            _tag1 = t;
                            _helperTag = t;
                          });

                          // setState(() {
                          //   _tag1 = _tags[0];
                          //   _tag2 = _tags[1];
                          //   _tag3 = _tags[2];
                          // });
                          // print('print ' + t + 'print1 ' +_tag1 +'print2 ' + _tag2 +'print3 ' + _tag3);
                          print('print ' + _tag1);
                        },
                        onDelete: (tag) {
                          print('onDelete ' + tag);
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
                          height: MediaQuery.of(context).size.height / 25,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
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
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Checkbox(
                            value: _valNego,
                            checkColor: Colors.red,
                            activeColor: Colors.white,
                            onChanged: (bool value) {
                              setState(() {
                                _valNego = value;
                              });
                            }),
                      )
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
                          _saveJasa()
                               .whenComplete(() => Get.off(ListJasaScreen()));
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
      print('image 1 $_image');
    });
  }

  Future _getImage2() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image2 = img;
      print('image 2 $_image2');
    });
  }

  Future _getImage3() async {
    var img = await ImagePicker.pickImage(
        source: ImageSource
            .gallery); //ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image3 = img;
      print('image 3 $_image3');
    });
  }

  DatabaseMethods _dataJasa = DatabaseMethods();


  Future<void> _saveJasa() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    var snapshot1, snapshot2, snapshot3, url1, url2, url3;
    String email = _user.email;
    String namaJasa = _controllerJudulJasa.text;
    String kategori = _kategori;
    String estimasiWaktu = _hari.toString();
    String deskripsi = _controllerDeskripsi.text;
    String tag1 = _tag1;
    String harga = _controllerHarga.text;

     snapshot1 =
      await _storage.ref().child(_user.email).putFile(_image).onComplete;
      url1 = await snapshot1.ref.getDownloadURL();


    // snapshot2 =
    //     await _storage.ref().child(_user.email).child('ktp').putFile(_image2);
    // url2 = await snapshot2.ref.getDownloadURL();
    // snapshot3 =
    //     await _storage.ref().child(_user.email).child('ktp').putFile(_image3);
    // url3 = await snapshot3.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('list jasa')
        .doc(namaJasa)
        .set({
      'namaJasa': namaJasa,
      'kategori': kategori,
      'estimasiWaktu': estimasiWaktu,
      'deskripsi': deskripsi,
      'tag1': _tag1,
      'harga': harga,
      'gambar' : url1
    }).then((value) {
      print('print ');
    });

    Map<String, String> jasanya = {
      'namaJasa': namaJasa,
      'kategori': kategori,
      'estimasiWaktu': estimasiWaktu,
      'deskripsi': deskripsi,
      'tag1': _tag1,
      'harga': harga,
      'email': email,
      'gambar1': url1,
      //
      // 'gambar2': url2,
      // 'gambar3': url3
    };
    _reference.push().set(jasanya);
    _dataJasa.addJobInfo(jasanya);
  }
}
