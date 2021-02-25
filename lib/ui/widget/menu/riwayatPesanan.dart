import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/ui/widget/views/riwayatPesanan/riwayatDibatalkan.dart';
import 'package:doers_project/ui/widget/views/riwayatPesanan/menungguKonfirmasi.dart';
import 'package:doers_project/ui/widget/views/riwayatPesanan/riwayatSedangDikerjakan.dart';
import 'package:doers_project/ui/widget/views/riwayatPesanan/riwayatSelesai.dart';
import 'package:flutter/material.dart';

class RiwayatPesanan extends StatefulWidget {
  @override
  _RiwayatPesananState createState() => _RiwayatPesananState();
}

class _RiwayatPesananState extends State<RiwayatPesanan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColors,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Riwayat Pesanan',
            style: TextStyle(
                fontFamily: 'montserrat', fontSize: 16, color: Colors.black),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Menunggu Konfirmasi',
              ),
              Tab(
                text: 'Sedang Dikerjakan',
              ),
              Tab(
                text: 'Selesai',
              ),
              Tab(
                text: 'Dibatalkan',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          MenungguKonfirmasi(),
          ScreenRiwayatSedangDikerjakan(),
          ScreenRiwayatSelesai(),
          ScreenRiwayatDibatalkan()
        ]),
      ),
    );
  }
}
