import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/notif.dart';
import 'package:doers_project/helper/postMisi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class DatabaseMethods {
  User _user = FirebaseAuth.instance.currentUser;

  Future<void> addUserInfo(userData, String email) async {
    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('Data Diri')
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('Data Diri')
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  Future<void> addJobInfo(jobData) async {
    FirebaseFirestore.instance
        .collection('user jasa')
        .add(jobData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addOrderMenungguKonfirmasi(jobData, String email) async {
    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('order')
        .doc('menunggu konfirmasi')
        .collection('menunggu')
        .add(jobData)
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByTag(String searchField) {
    return FirebaseFirestore.instance
        .collection("user jasa")
        .where('tag1', isEqualTo: searchField)
        .get();
  }

  Future<void> saveNotif(notif) async {
    FirebaseDatabase.instance.reference().child('notif').set(notif);
  }

  Future<void> addNotifInfo(notifInfo, String email) async {
    FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(email)
        .collection('notif info')
        .add(notifInfo)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> saveOrderMenunggu(jobs) async {
    FirebaseDatabase.instance
        .reference()
        .child('Menunggu Konfirmasi')
        .set(jobs);
  }

  Future<void> addnotif(addnotif) async {
    FirebaseFirestore.instance
        .collection('notif')
        .add(addnotif)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> getNotification(List<getNotifInfo> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('notif');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('target')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        getNotifInfo p = new getNotifInfo(
          Data[individualKeys]['title'],
          Data[individualKeys]['body'],
          Data[individualKeys]['target'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPesananMenunggu(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('menunggu konfirmasi');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('pembeli jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPekerjaanMenunggu(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('menunggu konfirmasi');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('penyedia jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPesananDikerjakan(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('sedang dikerjakan');

    _ref
        .orderByChild('pembeli jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPekerjaanDikerjakan(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('sedang dikerjakan');

    _ref
        .orderByChild('penyedia jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPesananSelesai(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('selesai');

    _ref
        .orderByChild('pembeli jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPekerjaanSelesai(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('selesai');

    _ref
        .orderByChild('penyedia jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPesananBatal(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('dibatalkan');

    _ref
        .orderByChild('pembeli jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  Future<void> getListPekerjaanBatal(List<PostsMisi> list, String email) async {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('dibatalkan');

    _ref
        .orderByChild('penyedia jasa')
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      list.clear();
      for (var individualKeys in Keys) {
        PostsMisi p = new PostsMisi(
          Data[individualKeys]['alamat'],
          Data[individualKeys]['catatan'],
          Data[individualKeys]['durasi'],
          Data[individualKeys]['gambar'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['metode pembayaran'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['pembeli jasa'],
          Data[individualKeys]['penyedia jasa'],
          Data[individualKeys]['waktu pengerjaan'],
        );
        list.add(p);
      }
    });
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendNotifTerima(target) async {
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
          'to': '$target'
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
