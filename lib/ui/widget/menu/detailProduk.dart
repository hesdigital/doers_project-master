import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/constants.dart';
import 'package:doers_project/helper/database.dart';
import 'package:doers_project/ui/widget/chat/chatScreen.dart';
import 'package:doers_project/ui/widget/views/orderScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DetailProduk extends StatefulWidget {
  var gambar,
      nama,
      judul,
      deskripsi,
      lokasi,
      harga,
      estimasiWaktu,
      penyediaJasa;

  DetailProduk(
      {this.gambar,
      this.nama,
      this.judul,
      this.deskripsi,
      this.lokasi,
      this.harga,
      this.estimasiWaktu});
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  String _estimasi = '3 hari';
  String _username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: widget.gambar != null
                        ? Image.network(
                            widget.gambar,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    color: themeColors,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        //   height: 5,
                        // ),
                        Container(
                          height: 150.0,
                          width: 250.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.nama != null
                                    ? Text(
                                        widget.nama,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    : Text(
                                        'Nama Jasa',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                widget.lokasi != null
                                    ? Text(
                                        widget.lokasi,
                                        style: (TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'montserrat',
                                            color: Colors.black)),
                                      )
                                    : Text(
                                        'widget.lokasi',
                                        style: (TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'montserrat',
                                            color: Colors.black)),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 2,
                      child: widget.judul != null
                          ? Text(
                              widget.judul,
                              style: (TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                            )
                          : Text(
                              'Judul jasa',
                              style: (TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                            ),
                    ),
                  ),
                  widget.harga != null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('IDR ' + widget.harga)),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'IDR. Harga ',
                              style: (TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                  Divider(
                    height: 35,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Deskripsi',
                      style: (TextStyle(
                          fontSize: 16,
                          fontFamily: 'montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: widget.deskripsi != null
                        ? Text(
                            widget.deskripsi,
                            style: (TextStyle(
                              fontSize: 12,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                            )),
                          )
                        : Text(
                            'Deskripsi produk',
                            style: (TextStyle(
                              fontSize: 12,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                            )),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 46.0),
                    child: widget.estimasiWaktu != null
                        ? Text(
                            'Estimasi Waktu : ' +
                                widget.estimasiWaktu +
                                ' Hari',
                            style: (TextStyle(
                              fontSize: 12,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                            )),
                          )
                        : Text(
                            'Estimasi Waktu : ',
                            style: (TextStyle(
                              fontSize: 12,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                            )),
                          ),
                  ),
                  Divider(
                    height: 35,
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, left: 24.0, right: 24.0, bottom: 8),
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
                          Get.to(OrderPage(
                            namaJasa: widget.judul,
                            harga: widget.harga,
                            estimasiWaktu: widget.estimasiWaktu,
                            gambar: widget.gambar,
                            penyediaJasa: widget.nama,
                          ));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 8),
                    child: MaterialButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        minWidth: double.maxFinite,
                        child: Text(
                          'NEGO',
                          style: TextStyle(
                              fontFamily: 'montserrat medium',
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        onPressed: () {
                          sendMessage(widget.nama.toString());
                          print('usernamenya ' + _username);
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.back();
                        }),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.black,
                        ),
                        onPressed: null),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8),
                    child: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        onPressed: null),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  DatabaseMethods databaseMethods = DatabaseMethods();

  sendMessage(String userName) {
    List<String> users = [_username, userName];

    String chatRoomId = getChatRoomId(_username, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Get.off(ChatScreen(chatRoomId: chatRoomId,));
  }

  Map _data;
  User _usernya = FirebaseAuth.instance.currentUser;

  void _fetchData() {
    DocumentReference _collection = FirebaseFirestore.instance
        .collection('Data Diri User')
        .doc(_usernya.email)
        .collection('Data Diri')
        .doc('Data');

    _collection.snapshots().listen((snapshot) {
      setState(() {
        _data = snapshot.data();
        _username = _data['displayName'].toString();
        print('username pengguna ' + _username);
      });
    });
  }
}

