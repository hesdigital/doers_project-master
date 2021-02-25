import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class TestUi extends StatefulWidget {
  @override
  _TestUiState createState() => _TestUiState();
}

class _TestUiState extends State<TestUi> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  var tokennya;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var tokenFCM = _firebaseMessaging.getToken();
    print('Token device = ' + tokenFCM.toString());
    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
      },
      onLaunch: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user.email),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              notificationAlert,
            ),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: themeColors,
                minWidth: double.maxFinite,
                child: Text(
                  'send',
                  style: TextStyle(
                      fontFamily: 'montserrat medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  sendAndRetrieveMessage();
                  // callOnFcmApiSendPushNotifications(tokennya);
                }),
            MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: themeColors,
                minWidth: double.maxFinite,
                child: Text(
                  'get token',
                  style: TextStyle(
                      fontFamily: 'montserrat medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  gettoken();
                }),
          ],
        ),
      ),
    );
  }

  //device 1 token = ewYPHVu-RR2xrZYrqo2iRO:APA91bHu04BsGupI-GJMhkeIHjs7_Wxpd2nYoanF8Nsqg4gNWwGFsVa7YC_nkxluPeBdSz1IWRYHssr4BE2xS5pOc0NXLAwFZPsJF1hubXVBVpZO51V3yU7L7rqAfD7OOeYfXP_vOSaG
  //
  final String serverToken =
      '<AAAAB2_sho0:APA91bEbykjeCD8o6nb1r-aFp4J_qnppa1GQT8Buo4Nj3HnS3P-QrlRulB-XicBkellVGKn7vg1Y9nCDwEJwk6LefRSVHruj4vjQB3UngsONbL8dvQTSIpregs8juY_NbnqEqpZImp2R>';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

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
          'to':
              'esb4h0PrRyWkSBqfG7CEJH:APA91bGBEfe19ByUjb3iVqMBARjLlFX11kYbkpP8NUFOTI_GeXV5UFTqv_4Xm0qn5IXr4LA0WG3GMYfHEutefYQIZ7im1EikweDAK0Dd2nsqbZ9-jADANuVFwOQ_m8kT9MdffQM5Fkam',
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

  User _user = FirebaseAuth.instance.currentUser;
  var postUrl = "fcm.googleapis.com/fcm/send";

  // Future<bool> callOnFcmApiSendPushNotifications(List<String> userToken) async {
  //   final postUrl = 'https://fcm.googleapis.com/fcm/send';
  //   final data = {
  //     "registration_ids": userToken,
  //     "collapse_key": "type_a",
  //     "notification": {
  //       "title": 'NewTextTitle',
  //       "body": 'NewTextBody',
  //     }
  //   };
  //
  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization': 'key=$serverToken' // 'key=YOUR_SERVER_KEY'
  //   };
  //
  //   final response = await http.post(postUrl,
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     print('test ok push CFM');
  //     return true;
  //   } else {
  //     print(' CFM error');
  //     // on failure do sth
  //     return false;
  //   }
  // }

  // Future<void> _sendNotif(reciver, msg) async {
  //   var token = await getToken(reciver);
  //
  //   final data = {
  //     "notification": {
  //       "body": "Accept Ride Request",
  //       "title": "This is Ride Request"
  //     },
  //     "priority": "high",
  //     "data": {
  //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //       "id": "1",
  //       "status": "done"
  //     },
  //     "to": "$token"
  //   };
  //
  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'key=<AAAAB2_sho0:APA91bEbykjeCD8o6nb1r-aFp4J_qnppa1GQT8Buo4Nj3HnS3P-QrlRulB-XicBkellVGKn7vg1Y9nCDwEJwk6LefRSVHruj4vjQB3UngsONbL8dvQTSIpregs8juY_NbnqEqpZImp2R>'
  //   };
  //
  //   BaseOptions options = new BaseOptions(
  //     connectTimeout: 5000,
  //     receiveTimeout: 3000,
  //     headers: headers,
  //   );
  //
  //   try {
  //     final response = await Dio(options).post(postUrl, data: data);
  //
  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(msg: 'Request Sent To Driver');
  //     } else {
  //       print('notification sending failed');
  //       // on failure do sth
  //     }
  //   } catch (e) {
  //     print('exception $e');
  //   }
  // }
  //
  // void _send() {}
  //
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> gettoken() async {
    _firebaseMessaging.getToken().then((token) {
      final tokenStr = token.toString();
      print("token device " + tokenStr);
      setState(() {
        // tokennya = 'esb4h0PrRyWkSBqfG7CEJH:APA91bGBEfe19ByUjb3iVqMBARjLlFX11kYbkpP8NUFOTI_GeXV5UFTqv_4Xm0qn5IXr4LA0WG3GMYfHEutefYQIZ7im1EikweDAK0Dd2nsqbZ9-jADANuVFwOQ_m8kT9MdffQM5Fkam';
        tokennya = tokenStr;
        print('Tokennya ' + tokennya);
      });
      // do whatever you want with the token here
    }).whenComplete(() => _db
            .collection('Data Diri User')
            .doc(_user.email)
            .collection('tokens')
            .doc('tokennya')
            .set({'token device': tokennya.toString()}).then((snapshot) {
          print('save token berhasil!');
        }));
  }
}
