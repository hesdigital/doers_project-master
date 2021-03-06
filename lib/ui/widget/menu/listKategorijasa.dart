import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/posts.dart';
import 'package:doers_project/ui/widget/menu/detailProduk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListKategoriJasa extends StatefulWidget {
  var judul;
  ListKategoriJasa({this.judul});
  @override
  _ListKategoriJasaState createState() => _ListKategoriJasaState();
}

class _ListKategoriJasaState extends State<ListKategoriJasa> {
  List<Posts> _listKategori = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: themeColors,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Get.back();
                          }),
                      widget.judul == null
                          ? Text('Judul',
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
                          : Text(
                              widget.judul,
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                      Spacer(),
                      IconButton(icon: Icon(Icons.search), onPressed: () {}),
                      IconButton(icon: Icon(Icons.sort), onPressed: () {})
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: _listKategori.length == 0
                      ? Center(
                          child: new Text('Tidak ada jasa terdaftar',
                              style: TextStyle(
                                  fontFamily: 'montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _listKategori.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(DetailProduk(
                                    nama: _listKategori[index].email,
                                    gambar: _listKategori[index].gambar1,
                                    judul: _listKategori[index].namaJasa,
                                    harga: _listKategori[index].harga,
                                    deskripsi: _listKategori[index].deskripsi,
                                    estimasiWaktu:
                                        _listKategori[index].estimasiWaktu,
                                  ));
                                  print(
                                      'print ' + _listKategori[index].namaJasa);
                                },
                                child: Card(
                                  elevation: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                color: Colors.black,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                child: Image.network(
                                                  _listKategori[index].gambar1,
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 18.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8,
                                                              left: 150),
                                                      child: Container(
                                                        width: 60,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          8.0),
                                                              child: Icon(
                                                                Icons.favorite,
                                                                size: 18,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: Text(
                                                  _listKategori[index].namaJasa,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'montserrat medium',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 60.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.account_circle,
                                                      size: 10,
                                                    ),
                                                    Text(
                                                      _listKategori[index]
                                                          .email,
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
                                                    bottom: 8.0, left: 150),
                                                child: Text(
                                                  'Rp. ' +
                                                      _listKategori[index]
                                                          .harga,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'futura',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  // child: ListTile(
                                  //   leading:
                                  //   ConstrainedBox(
                                  //     constraints: BoxConstraints(
                                  //       minWidth: 244,
                                  //       minHeight: 244,
                                  //       maxWidth: 244,
                                  //       maxHeight: 244,
                                  //     ),
                                  //     child: Image.network(
                                  //       '${_listJasa[index]['gambar']}',
                                  //       width: 100,
                                  //       height: 100,
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  //   title: Text(
                                  //     '',
                                  //     style: TextStyle(fontSize: 24),
                                  //   ),
                                  //   subtitle: Text(
                                  //     '',
                                  //     style: TextStyle(fontSize: 18),
                                  //   ),
                                  //   onTap: () {},
                                  // ),
                                ),
                              ),
                            );
                          }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getList() {
    DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('UserJasa');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('kategori')
        .equalTo(widget.judul)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _listKategori.clear();
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
        _listKategori.add(p);
      }

      setState(() {
        print('length : $_listKategori.length');
      });
    });
  }
}
