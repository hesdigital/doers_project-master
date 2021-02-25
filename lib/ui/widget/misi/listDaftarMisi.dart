import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/posts.dart';
import 'package:doers_project/ui/widget/jasa/buatJasaScreen.dart';
import 'package:doers_project/ui/widget/misi/buatMisi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDaftarMisi extends StatefulWidget {
  @override
  _ListDaftarMisiState createState() => _ListDaftarMisiState();
}

class _ListDaftarMisiState extends State<ListDaftarMisi> {

  List<Posts> _listMisi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getlistMisi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: themeColors,
        title: Text(
          'Misi Saya',
          style: TextStyle(
              fontFamily: 'montserrat',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _listMisi.length == 0
            ? Center(
            child: new Text('Tidak ada jasa terdaftar',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)))
            : ListView.builder(
            shrinkWrap: true,
            itemCount: _listMisi.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: Image.network(
                    _listMisi[index].gambar1,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    _listMisi[index].namaJasa,
                    style: TextStyle(fontSize: 24),
                  ),
                  subtitle: Text(
                    _listMisi[index].deskripsi,
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {},
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: themeColors,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          label: Text(
            'Tambah Misi',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'montserrat',
              fontSize: 12,
            ),
          ),
          onPressed: () {
            Get.off(BuatMisiScreen());
          }),
    );
  }

  void _getlistMisi() {
    DatabaseReference _ref =
    FirebaseDatabase.instance.reference().child('UserMisi');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('email')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listMisi.clear();
      for (var individualKeys in Keys) {
        Posts p = new Posts(
          Data[individualKeys]['deskripsi'],
          Data[individualKeys]['email'],
          Data[individualKeys]['estimasiWaktu'],
          Data[individualKeys]['harga'],
          Data[individualKeys]['kategori'],
          Data[individualKeys]['namaJasa'],
          Data[individualKeys]['tag1'],
          Data[individualKeys]['gambar1'],
        );
      _listMisi.add(p);
      }

      setState(() {
        print('length : $_listMisi.length');
      });
    });
  }

}
