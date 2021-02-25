import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/message.dart';
import 'package:doers_project/helper/notif.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  DatabaseMethods _databaseMethods = DatabaseMethods();

  List<Message> _listNotif;
  List<getNotifInfo> _listNotifiation = [];

  String _userEmail = FirebaseAuth.instance.currentUser.email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseMethods.getNotification(_listNotifiation, _userEmail);
    _configNotification();
    _listNotif = List<Message>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: TextStyle(),
        ),
        backgroundColor: Colors.amber,
      ),
      body: _listNotifiation == 0 ? Center(child: Text(' Tidak ada notification'),) :
      ListView.builder(
        shrinkWrap: true,
          itemCount: _listNotifiation.length,
          itemBuilder: (context, index) {
        return ListTile(
          title: Text(_listNotifiation[index].title),
          subtitle: Text(_listNotifiation[index].body),
        );
      }),
    );
  }

  _configNotification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);

      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _setMessage(message);

      },
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notifi = message['notification'];
    final data = message['data'];
    final String title = notifi['title'];
    final String body = notifi['title'];
    final String mMessage = data['message'];
    setState(() {
       Message m = Message(title, body, mMessage);
       _listNotif.add(m);
    });

  }
}
