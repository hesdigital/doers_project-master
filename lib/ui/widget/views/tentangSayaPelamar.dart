import 'package:flutter/material.dart';

class ScreenTentangSayaPlamar extends StatefulWidget {
  @override
  _ScreenTentangSayaPlamarState createState() =>
      _ScreenTentangSayaPlamarState();
}

class _ScreenTentangSayaPlamarState extends State<ScreenTentangSayaPlamar> {
  String _tanggalDaftar, _tanggalVerifikasi;

  bool _dokumenPendukung = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              'Terdaftar Sejak ' + _tanggalDaftar,
              style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
            child: Text(
              'Terverifikasi Sejak ' + _tanggalVerifikasi,
              style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
            ),
          ),
          Divider(
            height: 35,
            thickness: 5,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Tentang Saya ',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    'Saya seorang design grafis yang mampu berkerja sangat cepat,  '
                    'sangat menyukai tantangan dan pengalaman baru. ',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Skill ',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    'Adobe Photoshop',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 35,
            thickness: 5,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Riwayat Pendidikan',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Universitas Sriwijaya',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    'S1 Sistem Komputer',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    '2010 - 2013',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  child: Divider(
                    height: 10.0,
                    thickness: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'SMA YP UNILA',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    'SMA',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    '2010-2013',
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Dokumen Pendukung',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _dokumenPendukung
                    ? Center(
                        child: Text(
                        'Tidak Ada',
                        style: TextStyle(color: Colors.red),
                      ))
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
