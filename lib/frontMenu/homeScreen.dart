import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/frontMenu/notificationScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/posts.dart';
import 'package:doers_project/ui/widget/menu/detailProduk.dart';
import 'package:doers_project/ui/widget/menu/listKategoriMisi.dart';
import 'package:doers_project/ui/widget/menu/listKategorijasa.dart';
import 'package:doers_project/ui/widget/menu/searchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _visibility = false;
  String _judulnya = 'Rekomendasi Untukmu';
  int _mediaQueryHigh = 2;
  Color _iconColor = Colors.black;

  List<Posts> _defaultList = [];
  List<Posts> _list = [];
  List<Posts> _listMisinya = [];

  List _listMisi = [
    {
      'gambar': 'asset/images/download 2 (1).png',
      'judul': 'Dicari design undangan pernikahan',
      'nama': 'Nama client',
      'harga': '1000',
      'rating': '4.4'
    },
    {
      'gambar': 'asset/images/download (1) 3.png',
      'judul': 'Develop Website, HTTP, CSS',
      'nama': 'Nama client',
      'harga': '10000',
      'rating': '4.1'
    },
  ];

  List _listJasa = [
    {
      'gambar': 'asset/images/muraljogja 2.png',
      'judul': 'Terima pesanan lukis dinding (grafitti)',
      'nama': 'Yudi Syahputra',
      'harga': '100000',
      'rating': '4.4'
    },
    {
      'gambar': 'asset/images/download 2.png',
      'judul': 'Design Kartun Digital Murah Full Body',
      'nama': 'Tukang Program',
      'harga': '10000',
      'rating': '4.1'
    },
  ];

  List _listKategori = [
    {'nama': 'Semua Kategori', 'gambar': 'asset/images/semua.png'},
    {'nama': 'Design & Pemrograman', 'gambar': 'asset/images/design.png'},
    {'nama': 'Elektronik', 'gambar': 'asset/images/elektronik.png'},
    {'nama': 'Gaya Hidup', 'gambar': 'asset/images/gayahidup.png'},
    {'nama': 'Pertukangan', 'gambar': 'asset/images/tukang.png'},
    {'nama': 'Rumah Tangga', 'gambar': 'asset/images/rumahtangga.png'},
  ];

  List _listDefault = [
    {'nama': 'Desain Grafis', 'gambar': 'asset/images/kategoriLogo.png'},
    {'nama': 'Program', 'gambar': 'asset/images/kategoriProgram.png'},
    {
      'nama': 'Handphone',
      'gambar': 'asset/images/kategoriKomputer.png'
    },
    {'nama': 'AC', 'gambar': 'asset/images/acKategori.png'},
    {'nama': 'Kulkas Mesin Cuci', 'gambar': 'asset/images/kategoriKulkas.png'},
    {'nama': 'ART', 'gambar': 'asset/images/rumahtangga.png'},
    {'nama': 'Baby Sister', 'gambar': 'asset/images/kategoriBabysister.png'},
    {'nama': 'Laundry', 'gambar': 'asset/images/kategoriLaundry.png'},
    {'nama': 'Pompa & Sumur Bor', 'gambar': 'asset/images/kategoriPompa.png'},
    {'nama': 'Kontruksi', 'gambar': 'asset/images/pembangunan.png'},
    {'nama': 'Renovasi', 'gambar': 'asset/images/kategoriKontruksi.png'},
    {'nama': 'Taman', 'gambar': 'asset/images/kategoriTaman.png'},
    {'nama': 'EO/WO', 'gambar': 'asset/images/kategoriEo.png'},
    {'nama': 'Gaming', 'gambar': 'asset/images/kategoriGaming.png'},
    {'nama': 'Pendidikan', 'gambar': 'asset/images/kategoriPendidikan.png'},
    {'nama': 'Perawatan', 'gambar': 'asset/images/kategoriPerawatan.png'},
  ];

  List _listSemua = [
    {'nama': 'Desain Grafis', 'gambar': 'asset/images/kategoriLogo.png'},
    {'nama': 'Program', 'gambar': 'asset/images/kategoriProgram.png'},
    {
      'nama': 'Handphone',
      'gambar': 'asset/images/kategoriKomputer.png'
    },
    {'nama': 'AC', 'gambar': 'asset/images/acKategori.png'},
    {'nama': 'Kulkas Mesin Cuci', 'gambar': 'asset/images/kategoriKulkas.png'},
    {'nama': 'ART', 'gambar': 'asset/images/rumahtangga.png'},
    {'nama': 'Baby Sister', 'gambar': 'asset/images/kategoriBabysister.png'},
    {'nama': 'Laundry', 'gambar': 'asset/images/kategoriLaundry.png'},
    {'nama': 'Pompa & Sumur Bor', 'gambar': 'asset/images/kategoriPompa.png'},
    {'nama': 'Kontruksi', 'gambar': 'asset/images/pembangunan.png'},
    {'nama': 'Renovasi', 'gambar': 'asset/images/kategoriKontruksi.png'},
    {'nama': 'Taman', 'gambar': 'asset/images/kategoriTaman.png'},
    {'nama': 'EO/WO', 'gambar': 'asset/images/kategoriEo.png'},
    {'nama': 'Gaming', 'gambar': 'asset/images/kategoriGaming.png'},
    {'nama': 'Pendidikan', 'gambar': 'asset/images/kategoriPendidikan.png'},
    {'nama': 'Perawatan', 'gambar': 'asset/images/kategoriPerawatan.png'},
  ];

  List _listDesain = [
    {'nama': 'Desain Grafis', 'gambar': 'asset/images/kategoriLogo.png'},
    {'nama': 'Program', 'gambar': 'asset/images/kategoriProgram.png'},
  ];

  List _listKategoriElektronik = [
    {
      'nama': 'Handphone',
      'gambar': 'asset/images/kategoriKomputer.png'
    },
    {'nama': 'AC', 'gambar': 'asset/images/acKategori.png'},
    {'nama': 'Kulkas Mesin Cuci', 'gambar': 'asset/images/kategoriKulkas.png'},
  ];

  List _listGaya = [
    {'nama': 'EO/WO', 'gambar': 'asset/images/kategoriEo.png'},
    {'nama': 'Gaming', 'gambar': 'asset/images/kategoriGaming.png'},
    {'nama': 'Pendidikan', 'gambar': 'asset/images/kategoriPendidikan.png'},
    {'nama': 'Perawatan', 'gambar': 'asset/images/kategoriPerawatan.png'},
  ];

  List _listTukang = [
    {'nama': 'Pompa & Sumur Bor', 'gambar': 'asset/images/kategoriPompa.png'},
    {'nama': 'Kontruksi', 'gambar': 'asset/images/pembangunan.png'},
    {'nama': 'Renovasi', 'gambar': 'asset/images/kategoriKontruksi.png'},
    {'nama': 'Taman', 'gambar': 'asset/images/kategoriTaman.png'},
  ];

  List _listRumahtangga = [
    {'nama': 'ART', 'gambar': 'asset/images/rumahtangga.png'},
    {'nama': 'Baby Sister', 'gambar': 'asset/images/kategoriBabysister.png'},
    {'nama': 'Laundry', 'gambar': 'asset/images/kategoriLaundry.png'},
  ];
  DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('UserJasa');

  String _location = '';
  Position _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrenLcoation();
    _getlistMisi();
    _getTokenDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: themeColors,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.location_on_outlined),
                ),
                Text(_location,
                    style: TextStyle(fontFamily: 'montserrat', fontSize: 12)),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(SearchScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(NotificationScreen());
                      },
                  child: Icon(Icons.notifications, color: Colors.black)),
                )
              ]),
            ),

            //KATEGORI
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0),
              child: Text(
                'Kategori',
                style: TextStyle(
                    fontFamily: 'montserrat medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _listKategori.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      if (_listKategori[index]['nama'] ==
                          'Design & Pemrograman') {
                        setState(() {
                          _visibility = true;
                          _listSemua = _listDesain;
                          _mediaQueryHigh = 5;
                        });
                        _judulnya = 'Rekomendasi Untukmu';
                      }

                      if (_listKategori[index]['nama'] == 'Semua Kategori') {
                        setState(() => _visibility = true);
                        _listSemua = _listDefault;
                        _mediaQueryHigh = 2;
                        _judulnya = 'Rekomendasi Untukmu';
                      } else if (_listKategori[index]['nama'] ==
                          'Design & Pemrograman') {
                        setState(() {
                          _listSemua = _listDesain;
                          addDesainList();
                        });
                        _mediaQueryHigh = 5;
                        _judulnya = 'Desain Grafis';
                      } else if (_listKategori[index]['nama'] == 'Elektronik') {
                        setState(() {
                          _listSemua = _listKategoriElektronik;
                          addelektronikList();
                        });
                        _mediaQueryHigh = 5;
                        _judulnya = 'Elektronik';
                      } else if (_listKategori[index]['nama'] == 'Gaya Hidup') {
                        setState(() {
                          _listSemua = _listGaya;
                          addGayaHidupList();
                        });
                        _mediaQueryHigh = 5;
                        _judulnya = 'Gaya Hidup';
                      } else if (_listKategori[index]['nama'] ==
                          'Pertukangan') {
                        setState(() {
                          _listSemua = _listTukang;
                          addPertukanganList();
                        });
                        _mediaQueryHigh = 5;
                        _judulnya = 'Pertukangan';
                      } else if (_listKategori[index]['nama'] ==
                          'Rumah Tangga') {
                        setState(() {
                          _listSemua = _listRumahtangga;
                          addRumahTanggaList();
                        });
                        _mediaQueryHigh = 5;
                        _judulnya = 'Rumah Tangga';
                      } else {
                        setState(() => _visibility = false);
                      }
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                '${_listKategori[index]['gambar']}',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '${_listKategori[index]['nama']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Monsterrat',
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 25,
              thickness: 5,
            ),
            Visibility(
              visible: _visibility,
              child: Container(
                height: MediaQuery.of(context).size.height / _mediaQueryHigh,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: _listSemua.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            if (_listSemua[i]['nama'] == 'Desain Grafis') {
                              Get.to(ListKategoriJasa(
                                judul: 'Desain Grafis',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Program') {
                              Get.to(ListKategoriJasa(
                                judul: 'Program',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Komputer % Handphone') {
                              Get.to(ListKategoriJasa(
                                judul: 'Komputer % Handphone',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Laundry') {
                              Get.to(ListKategoriJasa(
                                judul: 'Laundry',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'EO/WO') {
                              Get.to(ListKategoriJasa(
                                judul: 'EO/WO',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Kulkas Mesin Cuci') {
                              Get.to(ListKategoriJasa(
                                judul: 'Kulkas Mesin Cuci',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'ART') {
                              Get.to(ListKategoriJasa(
                                judul: 'ART',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Baby Sister') {
                              Get.to(ListKategoriJasa(
                                judul: 'Baby Sister',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Taman') {
                              Get.to(ListKategoriJasa(
                                judul: 'Taman',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Gaming') {
                              Get.to(ListKategoriJasa(
                                judul: 'Gaming',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Pompa & Sumur Bor') {
                              Get.to(ListKategoriJasa(
                                judul: 'Pompa & Sumur Bor',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Kontruksi') {
                              Get.to(ListKategoriJasa(
                                judul: 'Kontruksi',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Renovasi') {
                              Get.to(ListKategoriJasa(
                                judul: 'Renovasi',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Perawatan') {
                              Get.to(ListKategoriJasa(
                                judul: 'Perawatan',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Pendidikan') {
                              Get.to(ListKategoriJasa(
                                judul: 'Pendidikan',
                              ));
                            } else if (_listSemua[i]['nama'] ==
                                'Lain-Lain') {
                              Get.to(ListKategoriJasa(
                                judul: 'Lain-Lain',
                              ));
                            }
                          },
                          child: GridTile(
                            child: IconButton(
                              icon: Container(
                                  height:
                                      MediaQuery.of(context).size.width / 15,
                                  width: MediaQuery.of(context).size.width / 15,
                                  child: Image.asset(
                                      '${_listSemua[i]['gambar']}')),
                              iconSize: 5,
                            ),
                            footer: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '${_listSemua[i]['nama']}',
                                style: TextStyle(
                                    fontSize: 8, fontFamily: 'futura'),
                              ),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ),

            Visibility(
              visible: _visibility,
              child: Divider(
                height: 25,
                thickness: 5,
              ),
            ),

            //REKOMENDASI UNTUKMU
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                  child: Text(
                    _judulnya,
                    style: TextStyle(
                        fontFamily: 'montserrat medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 24.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(ListKategoriJasa(
                        judul: _judulnya,
                      ));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                          fontFamily: 'montserrat medium', fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.9,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _defaultList.length == 0
                    ? Center(
                        child: new Text('Tidak ada jasa terdaftar',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)))
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _defaultList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Get.to(
                              DetailProduk(
                                nama: _defaultList[index].email,
                                gambar: _defaultList[index].gambar1,
                                judul: _defaultList[index].namaJasa,
                                harga: _defaultList[index].harga,
                                deskripsi: _defaultList[index].deskripsi,
                                estimasiWaktu:
                                    _defaultList[index].estimasiWaktu,
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: Image.network(
                                        _defaultList[index].gambar1,
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.8,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Text(
                                            _defaultList[index].namaJasa,
                                            style: TextStyle(
                                                fontFamily: 'montserrat medium',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          icon: Icon(Icons.favorite),
                                          onPressed: () {})
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 13,
                                        ),
                                      ),
                                      Text(
                                        _defaultList[index].email,
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 9),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 9),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          'IDR. ' + _defaultList[index].harga,
                                          style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Divider(
              height: 35,
              thickness: 5,
            ),

            //Papan Misi
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                  child: Text(
                    'Papan Misi',
                    style: TextStyle(
                        fontFamily: 'montserrat medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 24.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(ListKategoriMisi(
                        judul: 'Papan Misi',
                      ));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontFamily: 'montserrat medium',
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _listMisinya == 0
                    ? Center(
                        child: new Text('Tidak ada misi terdaftar',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)))
                    : ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // itemCount: listberita.length,
                        itemCount: _listMisinya.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Get.to(DetailProduk(
                                nama: _listMisinya[index].email,
                                gambar: _listMisinya[index].gambar1,
                                judul: _listMisinya[index].namaJasa,
                                harga: _listMisinya[index].harga));
                          },
                          child: Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, right: 8.0),
                                      child: Image.network(
                                        _listMisinya[index].gambar1,
                                        fit: BoxFit.fill,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.8,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Text(
                                            _listMisinya[index].namaJasa,
                                            style: TextStyle(
                                                fontFamily: 'montserrat medium',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          icon: Icon(Icons.favorite),
                                          color: _iconColor,
                                          onPressed: () {
                                            setState(
                                                () => _iconColor = Colors.red);
                                          })
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 13,
                                        ),
                                      ),
                                      Text(
                                        _listMisinya[index].email,
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 9),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Text(
                                        '4.4',
                                        style: TextStyle(
                                            fontFamily: 'montserrat',
                                            fontSize: 9),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          _listMisinya[index].harga,
                                          style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addelektronikList() async {
    List<Posts> _listElektronik = [];
    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo('Elektronik')
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listElektronik.clear();
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
        _listElektronik.add(p);
      }

      setState(() {
        print('length : $_listElektronik.length');
        _defaultList = _listElektronik;
      });
    });
  }

  Future<void> addDesainList() async {
    List<Posts> _listDesain = [];
    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo('Desain Grafis')
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listDesain.clear();
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
        _listDesain.add(p);
      }

      setState(() {
        print('length : $_listDesain.length');
        _defaultList = _listDesain;
      });
    });
  }

  Future<void> addGayaHidupList() async {
    List<Posts> _listGayaHidup = [];
    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo('Gaya Hidup')
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listGayaHidup.clear();
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
        _listGayaHidup.add(p);
      }

      setState(() {
        print('length : $_listGayaHidup.length');
        _defaultList = _listGayaHidup;
      });
    });
  }

  Future<void> addPertukanganList() async {
    List<Posts> _listPertukungan = [];
    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo('Pertukangan')
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listPertukungan.clear();
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
        _listPertukungan.add(p);
      }

      setState(() {
        print('length : $_listPertukungan.length');
        _defaultList = _listPertukungan;
      });
    });
  }

  Future<void> addRumahTanggaList() async {
    List<Posts> _listRumahTangga = [];
    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo('Rumah tangga')
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listRumahTangga.clear();
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
        _listRumahTangga.add(p);
      }

      setState(() {
        print('length : $_listRumahTangga.length');
        _defaultList = _listRumahTangga;
      });
    });
  }

  void _getlistMisi() {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('UserMisi');

    User _user = FirebaseAuth.instance.currentUser;

    _ref.once().then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listMisinya.clear();
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
        _listMisinya.add(p);
      }

      setState(() {
        print('length : $_listMisinya.length');
      });
    });
  }

  void _getCurrenLcoation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        "${first.subAdminArea} : ${first.thoroughfare} : ${first.adminArea} : ${first.countryName} : ${first.featureName} : ${first.addressLine}");
    var _currenLocation = position;
    setState(() {
      _location = first.subAdminArea.toString();
    });
  }

  var tokennya;
  User _user = FirebaseAuth.instance.currentUser;

  void _getTokenDevice() {
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
