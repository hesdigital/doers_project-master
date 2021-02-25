import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPekerjaanSelesai extends StatefulWidget {
  var judul,
      url,
      judulJasa,
      penyediaJasa,
      pembeliJasa,
      tanggal,
      estimasiWaktu,
      alamat,
      catatan,
      harga,
      metodePembayaran;

  DetailPekerjaanSelesai(
      {this.judul,
      this.url,
      this.penyediaJasa,
      this.pembeliJasa,
      this.judulJasa,
      this.tanggal,
      this.estimasiWaktu,
      this.metodePembayaran,
      this.alamat,
      this.catatan,
      this.harga});
  @override
  _DetailPekerjaanSelesaiState createState() => _DetailPekerjaanSelesaiState();
}

class _DetailPekerjaanSelesaiState extends State<DetailPekerjaanSelesai> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var now = new DateTime.now();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool _loading = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String targetuser;
  DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('sedang dikerjakan');

  DatabaseReference _refSelesai =
      FirebaseDatabase.instance.reference().child('selesai');

  String email = FirebaseAuth.instance.currentUser.email;
  var rating = 0.0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    _fetchDataUlasan();
    User usernya = FirebaseAuth.instance.currentUser;
    email = usernya.email;
    print('emailnya  ' + email);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1280, 720),
        allowFontScaling: false,
        builder: () => _loading
            ? LoadingPage()
            : Scaffold(
                key: _scaffoldKey,
                backgroundColor: Color(0xfff9f4e1),
                appBar: AppBar(
                  title: InkWell(
                    onTap: () {
                      print(email);
                    },
                    child: Text(widget.judul,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'montserrat',
                            fontSize: 16)),
                  ),
                  backgroundColor: themeColors,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: ScreenUtil().setHeight(1920),
                    width: ScreenUtil().setWidth(1280),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  widget.judul,
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontFamily: 'futura',
                                      fontSize: 12),
                                ),
                                Spacer(),
                                Text(
                                  now.toString(),
                                  style: TextStyle(
                                      fontFamily: 'futura', fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 100.0,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: widget.url != null
                                      ? Image.network(
                                          widget.url,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.image),
                                ),
                                widget.judulJasa != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          widget.judulJasa,
                                          style: TextStyle(
                                              fontFamily: 'futura',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Judul Jasa',
                                          style: TextStyle(
                                              fontFamily: 'futura',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Text(
                              'Detail Pesanan',
                              style: TextStyle(
                                  fontFamily: 'futura',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Penyedia Jasa :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.penyediaJasa != null
                                    ? Text(
                                        widget.penyediaJasa,
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      )
                                    : Text(
                                        'Penyedia Jasa',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Waktu Pengerjaan :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.tanggal != null
                                    ? Text(
                                        widget.tanggal,
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      )
                                    : Text(
                                        'Tanggal Pengerjaan',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Durasi :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.estimasiWaktu != null
                                    ? Text(
                                        widget.estimasiWaktu + ' Hari',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      )
                                    : Text(
                                        'Estimasi Waktu',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Text(
                              'Alamat',
                              style: TextStyle(
                                fontFamily: 'futura',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 8.0),
                            child: widget.alamat != null
                                ? Text(
                                    widget.alamat,
                                    style: TextStyle(
                                      fontFamily: 'futura',
                                      fontSize: 10,
                                    ),
                                  )
                                : Text(
                                    'Jl. Teuku Umar no. 34a, Bandar Lampung',
                                    style: TextStyle(
                                      fontFamily: 'futura',
                                      fontSize: 10,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Catatan :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.catatan != null
                                    ? Text(
                                        widget.catatan,
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      )
                                    : Text(
                                        '-',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 8.0),
                            child: Text(
                              'Detail Pembayaran',
                              style: TextStyle(
                                  fontFamily: 'futura',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 16.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Metode Pembayaran :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.metodePembayaran != null
                                    ? Text(
                                        widget.metodePembayaran,
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 12,
                                        ),
                                      )
                                    : Text(
                                        'Transfer',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 10,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            child: Container(
                              color: Color(0xffd4d4d4),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Sub Total :',
                                      style: TextStyle(
                                        fontFamily: 'futura',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  widget.harga != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Text(
                                            widget.harga,
                                            style: TextStyle(
                                              fontFamily: 'futura',
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Text(
                                            'Rp. 0000000',
                                            style: TextStyle(
                                              fontFamily: 'futura',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, right: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Total :',
                                  style: TextStyle(
                                    fontFamily: 'futura',
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                widget.harga != null
                                    ? Text(
                                        'Rp. ' + widget.harga,
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 14,
                                        ),
                                      )
                                    : Text(
                                        'Rp. 0000000',
                                        style: TextStyle(
                                          fontFamily: 'futura',
                                          fontSize: 14,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          widget.pembeliJasa == email
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Center(
                                      child: (Text(
                                    'Beri ulasan kepada seller',
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontFamily: 'futura',
                                        fontSize: 12),
                                  ))),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, right: 24.0, top: 8.0),
                                  child: Center(
                                    child: Text(
                                      'Belum ada ulasan',
                                      style: TextStyle(
                                          fontFamily: 'montserrat medium',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                          widget.pembeliJasa == email
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, right: 24.0),
                                  child: MaterialButton(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Colors.white,
                                      minWidth: double.maxFinite,
                                      child: Text(
                                        'Beri Ulasan',
                                        style: TextStyle(
                                            fontFamily: 'montserrat medium',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        showInformationDialog(context);

                                        // setState(() => _loading = true);
                                        // sendNotifTerima();
                                        //   beriUlasan().whenComplete(() =>
                                        //       Get.off(ScreenRiwayatMenunggu()));
                                      }),
                                )
                              : (Text('')),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  Map _data;
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

  Future<void> submitRating() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User _user = FirebaseAuth.instance.currentUser;

    FirebaseDatabase.instance
        .reference()
        .child('sedang dikerjakan')
        .orderByChild('pembeli jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child('sedang dikerjakan')
            .child(key)
            .remove()
            .whenComplete(() => print("Berhasil ditolak"));
      });
    });

    // DocumentReference _doc = _firebaseFirestore
    //     .collection('Data Diri User')
    //     .doc(widget.penyediaJasa)
    //     .collection('order')
    //     .doc('menunggu konfirmasi')
    //     .collection('menunggu')
    //     .doc(widget.judulJasa);

    // _doc.delete();

    // _firebaseFirestore
    //     .collection('Data Diri User')
    //     .doc(widget.penyediaJasa)
    //     .collection('order')
    //     .doc('menunggu konfirmasi')
    //     .collection('menunggu')
    //     .doc(widget.judulJasa)
    //     .set({
    //   'namaJasa': widget.judulJasa,
    //   'gambar': widget.url,
    //   'penyedia jasa': widget.penyediaJasa,
    //   'waktu pengerjaan': widget.tanggal,
    //   'durasi': widget.estimasiWaktu,
    //   'alamat': widget.alamat,
    //   'catatan': widget.catatan,
    //   'metode pembayaran': widget.metodePembayaran,
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
    //     .doc('orderan')
    //     .collection('menunggu konfirmasi')
    //     .doc(widget.judulJasa)
    //     .set({
    //   'namaJasa': widget.judulJasa,
    //   'gambar': widget.url,
    //   'penyedia jasa': widget.penyediaJasa,
    //   'waktu pengerjaan': widget.tanggal,
    //   'durasi': widget.estimasiWaktu,
    //   'alamat': widget.alamat,
    //   'catatan': widget.catatan,
    //   'metode pembayaran': widget.metodePembayaran,
    //   'harga': widget.harga,
    // }).then((value) {
    //   print('print ');
    // });

    Map<String, String> _orderan = {
      'namaJasa': widget.judulJasa,
      'gambar': widget.url,
      'penyedia jasa': widget.penyediaJasa,
      'pembeli jasa': widget.pembeliJasa,
      'waktu pengerjaan': widget.tanggal,
      'durasi': widget.estimasiWaktu,
      'alamat': widget.alamat,
      'catatan': widget.catatan,
      'metode pembayaran': widget.metodePembayaran,
      'harga': widget.harga,
    };
    _refSelesai.push().set(_orderan);
  }

  Future<Map<String, dynamic>> sendNotifTerima() async {
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
            'title': 'Orderan anda telah di selesaikan!'
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

  final TextEditingController _controllerUlasan = TextEditingController();
  Timer _timer;

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            _timer = Timer(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return _controllerUlasan.text != null
                ? AlertDialog(
                    content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                                child: Text(
                              'Beri Ulasan',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'futura'),
                            )),
                            Divider(
                              color: Colors.black,
                            ),
                            Center(
                                child: Text(
                              'Seller telah menyelesaikan pekerjaannya',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'futura'),
                            )),
                            Center(
                                child: Text(
                              'Beri Ulasan',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'futura'),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                              ),
                            ),
                            Center(
                                child: Text(
                              widget.penyediaJasa,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'futura'),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: SmoothStarRating(
                                rating: rating,
                                isReadOnly: false,
                                size: 30,
                                filledIconData: Icons.star,
                                defaultIconData: Icons.star_border,
                                color: Colors.amber,
                                borderColor: Colors.amber,
                                starCount: 5,
                                allowHalfRating: false,
                                spacing: 2.0,
                                onRated: (value) {
                                  rating = value;
                                  print("rating value -> $rating");
                                  // print("rating value dd -> ${value.truncate()}");
                                },
                              ),
                            ),
                            TextFormField(
                              maxLines: 5,
                              minLines: 3,
                              style:
                                  TextStyle(fontSize: 12, fontFamily: 'futura'),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Berikan ulasan..',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              controller: _controllerUlasan,
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return 'Ulasan tidak boleh kosong!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.white,
                                        child: Text(
                                          'Nanti Saja',
                                          style: TextStyle(
                                              fontFamily: 'montserrat medium',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                  MaterialButton(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Colors.amber,
                                      child: Text(
                                        'Kirim Ulasan',
                                        style: TextStyle(
                                            fontFamily: 'montserrat medium',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Berhasil meberi ulasan'),
                                          duration: Duration(seconds: 3),
                                        ));
                                        beriUlasan();
                                      })
                                ])
                          ],
                        )),
                  )
                : AlertDialog(
                    content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.report,
                              color: Colors.red,
                            ),
                            Center(
                                child: Text(
                              'Anda sudah memberikan ulasan!',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'futura'),
                            )),
                          ],
                        )),
                  );
          });
        });
  }

  var dateNow = DateTime.now();

  Future<void> beriUlasan() {
    String _ulasan = _controllerUlasan.text;
    //save seller
    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(widget.penyediaJasa)
        .collection('ulasan')
        .doc(widget.judulJasa)
        .set({
      'penyediaJasa': widget.penyediaJasa,
      'pembeliJasa': widget.pembeliJasa,
      'judulJasa': widget.judulJasa,
      'tanggal': dateNow.toString(),
      'ulasan': _ulasan,
      'rating': rating.toString(),
    }).then((value) {
      setState(() {
        Get.back();
      });
    });
  }

  Map _dataUlasan;
  void _fetchDataUlasan() {
    DocumentReference _collection = FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(widget.penyediaJasa)
        .collection('ulasan')
        .doc(widget.judulJasa);

    _collection.snapshots().listen((snapshot) {
      setState(() {
        _dataUlasan = snapshot.data();
        print('ulasannya ' + _dataUlasan.toString());
        _controllerUlasan.text = _dataUlasan['ulasan'].toString();
      });
    });
  }
}
