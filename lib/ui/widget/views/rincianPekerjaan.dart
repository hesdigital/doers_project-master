import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/loadingPage.dart';
import 'package:doers_project/ui/widget/menu/kelolaPekerjaan.dart';
import 'package:doers_project/ui/widget/menu/riwayatPesanan.dart';
import 'package:doers_project/ui/widget/views/riwayatPesanan/menungguKonfirmasi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class RincianPekerjaan extends StatefulWidget {
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

  RincianPekerjaan(
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
  _RincianPekerjaanState createState() => _RincianPekerjaanState();
}

class _RincianPekerjaanState extends State<RincianPekerjaan> {
  var now = new DateTime.now();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool _loading = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String targetuser;
  DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('sedang dikerjakan');

  DatabaseReference _refSelesai =
      FirebaseDatabase.instance.reference().child('selesai');

  DatabaseMethods _database = DatabaseMethods();

  String email = FirebaseAuth.instance.currentUser.email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
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
                  height: ScreenUtil().setHeight(1780),
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        widget.judulJasa,
                                        style: TextStyle(
                                            fontFamily: 'futura',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
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
                          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
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
                          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                          child: Text(
                            'Alamat',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
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
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
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
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          widget.harga,
                                          style: TextStyle(
                                            fontFamily: 'futura',
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
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
                        widget.penyediaJasa != email
                            ? Padding(
                                padding: const EdgeInsets.only(top: 38.0),
                                child: Center(child: (Text(''))),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24.0, top: 24.0),
                                child: MaterialButton(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: themeColors,
                                    minWidth: double.maxFinite,
                                    child: Text(
                                      'Konfirmasi Pesanan',
                                      style: TextStyle(
                                          fontFamily: 'montserrat medium',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      setState(() => _loading = true);
                                      sendNotifTerima();
                                      confirmPesanan().whenComplete(() =>
                                          Get.off(KelolaPekerjaan()));
                                    }),
                              ),
                        widget.penyediaJasa != email
                            ? (Text(''))
                            : Padding(
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
                                      'Tolak Pesanan',
                                      style: TextStyle(
                                          fontFamily: 'montserrat medium',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      setState(() => _loading = true);
                                      sendNotifTolak();
                                      tolakPesanan().whenComplete(() =>
                                          Get.off(KelolaPekerjaan()));
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> confirmPesanan() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User _user = FirebaseAuth.instance.currentUser;

    FirebaseDatabase.instance
        .reference()
        .child('menunggu konfirmasi')
        .orderByChild('penyedia jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child('menunggu konfirmasi')
            .child(key)
            .remove()
            .whenComplete(() => print("Berhasil ditolak"));
      });
    });

    DocumentReference _doc = _firebaseFirestore
        .collection('Data Diri User')
        .doc(widget.penyediaJasa)
        .collection('order')
        .doc('menunggu konfirmasi')
        .collection('menunggu')
        .doc(widget.judulJasa);

    _doc.delete();

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
    _ref.push().set(_orderan);
    Map<String, String> _notif = {
      'title' : 'Orderan diterima',
      'body' : 'Silahkan mulai pekerjaan anda!',
      'target' : widget.pembeliJasa
    };
    _database.saveNotif(_notif);
  }

  Future<void> tolakPesanan() async {
    User _user = FirebaseAuth.instance.currentUser;

    FirebaseDatabase.instance
        .reference()
        .child('menunggu konfirmasi')
        .orderByChild('penyedia jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child('menunggu konfirmasi')
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
    //
    // _doc.delete();
  }

  Future<Map<String, dynamic>> sendNotifTolak() async {
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
            'title': 'Orderan anda telah di tolak. Silahkan coba lagi!'
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
            'title': 'Orderan anda telah di terima!'
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

  Future<void> batal() {
    User _user = FirebaseAuth.instance.currentUser;

    FirebaseDatabase.instance
        .reference()
        .child('menunggu konfirmasi')
        .orderByChild('pembeli jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child('menunggu konfirmasi')
            .child(key)
            .remove()
            .whenComplete(() => print("Berhasil ditolak"));
      });
    });

    DocumentReference _doc = _firebaseFirestore
        .collection('Data Diri User')
        .doc(widget.pembeliJasa)
        .collection('order')
        .doc('menunggu konfirmasi')
        .collection('menunggu')
        .doc(widget.judulJasa);

    _doc.delete();

    Map<String, String> _notif = {
      'title' : 'Pekerjaan dibatalkan',
      'body' : 'Anda mendapatkan orderan baru!',
      'target' : widget.pembeliJasa.toString()
    };
    _database.saveNotif(_notif);
  }

  Future<void> selesaikanPekerjaan() {
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

    Map<String, String> _notif = {
      'title' : 'Orderan telah selesai!',
      'body' : 'Beri ulasan untuk pekerjaan!',
      'target' : widget.pembeliJasa.toString()
    };
    _database.saveNotif(_notif);
  }
}
