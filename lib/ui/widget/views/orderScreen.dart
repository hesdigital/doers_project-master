import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:doers_project/ui/widget/views/detailPembelian.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  var namaJasa, estimasiWaktu, harga, gambar, penyediaJasa;
  OrderPage(
      {this.namaJasa,
      this.estimasiWaktu,
      this.harga,
      this.gambar,
      this.penyediaJasa});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _controllerJudul = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();
  DatabaseMethods _database = DatabaseMethods();

  var _hari = 0;
  String _tanggal = '';
  String _location = '';
  String _metodeBayar = 'Pilih metode pembayaran';
  DateTime _dateTime;
  User _user = FirebaseAuth.instance.currentUser;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String targetuser;
  bool _loading = false;
  DatabaseReference _ref = FirebaseDatabase.instance
      .reference()
      .child('menunggu konfirmasi');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrenLcoation();
    _fetchData();
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
                'Buat Pesanan',
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
                  widget.namaJasa != null
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Text(
                            widget.namaJasa,
                            style:
                                TextStyle(fontFamily: 'futura', fontSize: 12),
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Text(
                            '',
                            style:
                                TextStyle(fontFamily: 'futura', fontSize: 12),
                          ),
                        ),
                  Divider(
                    height: 60,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Tanggal Mulai',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        Text(
                          _dateTime != null
                              ? _dateTime.toString()
                              : 'hh/mm/yyyy',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _pickDate();
                            }),
                      ],
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
                      IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                      Text(
                        widget.estimasiWaktu != null
                            ? widget.estimasiWaktu
                            : '$_hari',
                        style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {}),
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
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Alamat',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          'Ganti Alamat',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Text(
                      _location,
                      style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: widget.harga != null
                        ? Text(
                            'Rp. ' + widget.harga,
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          )
                        : Text(
                            'Harga',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                  ),
                  Divider(
                    height: 50,
                    thickness: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onCLick();
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          children: [
                            Text('Metode Pembayaran '),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  _onCLick();
                                },
                                child: Text(
                                  _metodeBayar,
                                  style: TextStyle(color: Colors.green),
                                )),
                          ],
                        ),
                      ),
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
                          'ORDER',
                          style: TextStyle(
                              fontFamily: 'montserrat medium',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          sendAndRetrieveMessage();
                          setState(() => _loading = true);
                          _orderJasa()
                              .whenComplete(() => Get.off(DetailPembelian(
                                    judul: 'Menunggu Konfirmasi',
                                    metodePembayaran: _metodeBayar,
                                    judulJasa: widget.namaJasa,
                                    url: widget.gambar,
                                    tanggal: _dateTime.toString(),
                                    penyediaJasa: widget.penyediaJasa,
                                    estimasiWaktu: widget.estimasiWaktu,
                                    alamat: _location,
                                    catatan: _controllerDeskripsi.text,
                                    harga: widget.harga,
                                  )));
                        }),
                  ),
                ],
              ),
            ));
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2001),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dateTime = value;
      });
    });
  }

  void _onCLick() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 5,
            child: _builderBottomSheet(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(30),
                    topLeft: const Radius.circular(30))),
          );
        });
  }

  Column _builderBottomSheet() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('Tunai'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _metodeBayar = 'Tunai';
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.money),
          title: Text('Transfer'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _metodeBayar = 'Transfer';
            });
          },
        )
      ],
    );
  }

  void _getCurrenLcoation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        "${first.subAdminArea} : ${first.thoroughfare} : ${first.adminArea} : ${first.countryName} : ${first.featureName} : ${first.addressLine}");
    var _currenLocation = position;
    setState(() {
      _location = first.addressLine.toString();
    });
  }

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _orderJasa() async {
    //save for seller

    // _firebaseFirestore
    //     .collection('Data Diri User')
    //     .doc(widget.penyediaJasa)
    //     .collection('order')
    //     .doc('menunggu konfirmasi')
    //     .collection('menunggu')
    //     .doc(widget.namaJasa)
    //     .set({
    //   'namaJasa': widget.namaJasa,
    //   'gambar': widget.gambar,
    //   'penyedia jasa': widget.penyediaJasa,
    //   'waktu pengerjaan': _dateTime.toString(),
    //   'durasi': widget.estimasiWaktu,
    //   'alamat': _location,
    //   'catatan': _controllerDeskripsi.text,
    //   'metode pembayaran': _metodeBayar,
    //   'harga': widget.harga,
    // }).then((value) {
    //   print('print ');
    // });
    //
    // //save for buyer

    // _firebaseFirestore
    //     .collection('Data Diri User')
    //     .doc(_user.email)
    //     .collection('order')
    //     .doc('menunggu konfirmasi')
    //     .collection('menunggu')
    //     .doc()
    //     .set({
    //   'namaJasa': widget.namaJasa,
    //   'gambar': widget.gambar,
    //   'penyedia jasa': widget.penyediaJasa,
    //   'waktu pengerjaan': _dateTime.toString(),
    //   'durasi': widget.estimasiWaktu,
    //   'alamat': _location,
    //   'catatan': _controllerDeskripsi.text,
    //   'metode pembayaran': _metodeBayar,
    //   'harga': widget.harga,
    // }).then((value) {
    //   print('print ');
    // });

    Map<String, String> _orderan = {
      'namaJasa': widget.namaJasa,
      'gambar': widget.gambar,
      'penyedia jasa': widget.penyediaJasa,
      'pembeli jasa' : _user.email,
      'waktu pengerjaan': _dateTime.toString(),
      'durasi': widget.estimasiWaktu,
      'alamat': _location,
      'catatan': _controllerDeskripsi.text,
      'metode pembayaran': _metodeBayar,
      'harga': widget.harga,
    };
    _ref.push().set(_orderan);

    Map<String, String> _notif = {
      'title' : 'Orderan Baru',
      'body' : 'Anda mendapatkan orderan baru!'
    };
    _database.saveNotif(_notif);
  }

  Map _data;

  //take traget token
  void _fetchData() {
    DocumentReference _collection = FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(widget.penyediaJasa)
        .collection('tokens')
        .doc('tokennya');

    _collection.snapshots().listen((snapshot) {
      setState(() {
        _data = snapshot.data();
        print('datanya ' + _data.toString());
        targetuser = _data['token device'].toString();
        print('token target user ' + targetuser);
      });
    });
  }

  //send notif
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    final response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAB2_sho0:APA91bEbykjeCD8o6nb1r-aFp4J_qnppa1GQT8Buo4Nj3HnS3P-QrlRulB-XicBkellVGKn7vg1Y9nCDwEJwk6LefRSVHruj4vjQB3UngsONbL8dvQTSIpregs8juY_NbnqEqpZImp2R',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Orderan!',
            'title': 'Anda Orderan Baru!'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'Done'
          },
          'to': '$targetuser'
          // 'esb4h0PrRyWkSBqfG7CEJH:APA91bGBEfe19ByUjb3iVqMBARjLlFX11kYbkpP8NUFOTI_GeXV5UFTqv_4Xm0qn5IXr4LA0WG3GMYfHEutefYQIZ7im1EikweDAK0Dd2nsqbZ9-jADANuVFwOQ_m8kT9MdffQM5Fkam',
          //await firebaseMessaging.getToken() $'{token to specific device}',
        },
      ),
    );

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
    } else {
      print(' CFM error');
      // on failure do sth
    }
  }
}
