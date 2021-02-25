import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/ui/widget/views/kelolaPekerjaan/pekerjaanDibatalkan.dart';
import 'package:doers_project/ui/widget/views/kelolaPekerjaan/pekerjaanMenunggu.dart';
import 'package:doers_project/ui/widget/views/kelolaPekerjaan/pekerjaanSelesai.dart';
import 'package:doers_project/ui/widget/views/kelolaPekerjaan/sedangDikerjakan.dart';
import 'package:flutter/material.dart';

class KelolaPekerjaan extends StatefulWidget {
  @override
  _KelolaPekerjaanState createState() => _KelolaPekerjaanState();
}

class _KelolaPekerjaanState extends State<KelolaPekerjaan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColors,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Riwayat Pekerjaan',
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
          PekerjaanMenungguScreen(),
          PekerjaanDikerjakanScreen(),
          PekerjaanSelesaiScreen(),
          PekerjaanDibatalkanScreen()
        ]),
      ),
    );
  }
}
