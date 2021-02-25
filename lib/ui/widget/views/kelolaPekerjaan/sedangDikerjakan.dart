import 'package:doers_project/helper/database.dart';
import 'package:doers_project/helper/postMisi.dart';
import 'package:doers_project/ui/widget/views/detailPekerjaan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PekerjaanDikerjakanScreen extends StatefulWidget {
  @override
  _PekerjaanDikerjakanScreenState createState() => _PekerjaanDikerjakanScreenState();
}

class _PekerjaanDikerjakanScreenState extends State<PekerjaanDikerjakanScreen> {

  List<PostsMisi> _listPekerjaan = [];

  DatabaseMethods _databaseMethods = DatabaseMethods();

  String _userEmail = FirebaseAuth.instance.currentUser.email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseMethods.getListPekerjaanDikerjakan(_listPekerjaan, _userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
