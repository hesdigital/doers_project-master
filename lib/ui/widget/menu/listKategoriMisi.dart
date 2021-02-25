import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/posts.dart';
import 'package:doers_project/ui/widget/menu/detailProduk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListKategoriMisi extends StatefulWidget {
  var judul;
  ListKategoriMisi({this.judul});
  @override
  _ListKategoriMisiState createState() => _ListKategoriMisiState();
}

class _ListKategoriMisiState extends State<ListKategoriMisi> {

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
                        return Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(DetailProduk(
                                nama: _listMisi[index].email,
                                gambar: _listMisi[index].gambar1,
                                judul: _listMisi[index].namaJasa,
                                harga: _listMisi[index].harga,
                                deskripsi: _listMisi[index].deskripsi,
                                estimasiWaktu:
                                _listMisi[index].estimasiWaktu,
                              ));
                              print(
                                  'print ' + _listMisi[index].namaJasa);
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
                                              _listMisi[index].gambar1,
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
                                              _listMisi[index].namaJasa,
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
                                                  _listMisi[index]
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
                                                  _listMisi[index]
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
