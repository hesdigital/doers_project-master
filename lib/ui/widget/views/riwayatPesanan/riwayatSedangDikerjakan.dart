import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/postMisi.dart';
import 'package:doers_project/ui/widget/views/detailPekerjaan.dart';
import 'package:doers_project/ui/widget/views/rincianPekerjaan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenRiwayatSedangDikerjakan extends StatefulWidget {
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

  ScreenRiwayatSedangDikerjakan(
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
  _ScreenRiwayatSedangDikerjakanState createState() =>
      _ScreenRiwayatSedangDikerjakanState();
}

class _ScreenRiwayatSedangDikerjakanState
    extends State<ScreenRiwayatSedangDikerjakan> {
  List<PostsMisi> _listPekerjaan = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getlistMisiPembeli();
  }

  void cekList() {
    _getlistMisiPenyedia();
    if (_listPekerjaan == 0) {
      _getlistMisiPembeli();
    } else {
      _getlistMisiPembeli();
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _listPekerjaan.length == 0
            ? Center(
          child: Text('Tidak ada jasa terdaftar'),
        )
            : ListView.builder(
            shrinkWrap: true,
            itemCount: _listPekerjaan.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    Get.to(DetailPekerjaan(
                      judul: 'Sedang Dikerjakan',
                      judulJasa: _listPekerjaan[index].namaJasa,
                      url: _listPekerjaan[index].gambar,
                      penyediaJasa: _listPekerjaan[index].penyediaJasa,
                      tanggal: _listPekerjaan[index].waktuPengerjaan,
                      estimasiWaktu: _listPekerjaan[index].durasi,
                      alamat: _listPekerjaan[index].alamat,
                      catatan: _listPekerjaan[index].catatan,
                      harga: _listPekerjaan[index].harga,
                      metodePembayaran:
                      _listPekerjaan[index].metodepPembayaran,
                      pembeliJasa: _listPekerjaan[index].pembeliJasa,
                    ));
                  },
                  child: Card(
                    elevation: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  color: Colors.black,
                                  height:
                                  MediaQuery.of(context).size.height /
                                      5,
                                  width: MediaQuery.of(context).size.width /
                                      2.5,
                                  child: Image.network(
                                    _listPekerjaan[index].gambar,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    _listPekerjaan[index].namaJasa,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'montserrat medium',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 60.0, top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        size: 10,
                                      ),
                                      Text(
                                        _listPekerjaan[index].penyediaJasa,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily:
                                            'montserrat medium'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50.0, top: 20.0),
                                  child: Text(
                                    'Total Pesanan :  Rp. ' +
                                        _listPekerjaan[index].harga,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'futura',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _getlistMisiPenyedia() async {
    DatabaseReference _ref =
    FirebaseDatabase.instance.reference().child('sedang dikerjakan');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('penyedia jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listPekerjaan.clear();
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
        _listPekerjaan.add(p);
      }

      setState(() {
        print('length : $_listPekerjaan.length');
      });
    });
  }

  Future<void> _getlistMisiPembeli() async {
    DatabaseReference _ref =
    FirebaseDatabase.instance.reference().child('sedang dikerjakan');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('pembeli jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listPekerjaan.clear();
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
        _listPekerjaan.add(p);
      }

      setState(() {
        print('length : $_listPekerjaan.length');
      });
    });
  }
}
