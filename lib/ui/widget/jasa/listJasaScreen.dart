import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/posts.dart';
import 'package:doers_project/ui/widget/jasa/buatJasaScreen.dart';
import 'package:doers_project/ui/widget/menu/detailProduk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListJasaScreen extends StatefulWidget {
  @override
  _ListJasaScreenState createState() => _ListJasaScreenState();
}

class _ListJasaScreenState extends State<ListJasaScreen> {
  List _listJasa = [
    {
      'judul': 'Design an elegant weeding invitation',
      'profil': 'Tukang Design',
      'harga': '60000',
      'gambar':
          'https://i.pinimg.com/originals/f6/35/b8/f635b8400ad6169156f75be9b823518a.jpg'
    }
  ];

  List<Posts> _jasaList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlistJasa();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: themeColors,
        title: Text(
          'Jasa Saya',
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
        child: _jasaList.length == 0
            ? Center(
                child: new Text('Tidak ada jasa terdaftar',
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _jasaList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailProduk(
                            nama: _jasaList[index].email,
                            gambar: _jasaList[index].gambar1,
                            judul: _jasaList[index].namaJasa,
                            harga: _jasaList[index].harga,
                          deskripsi: _jasaList[index].deskripsi,
                            estimasiWaktu: _jasaList[index].estimasiWaktu,
                        ));
                        print('print ' + _jasaList[index].namaJasa);
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
                                          MediaQuery.of(context).size.height / 5,
                                      width:
                                          MediaQuery.of(context).size.width / 2.5,
                                      child: Image.network(
                                        _jasaList[index].gambar1,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                 right: 8, left: 150),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 18.0),
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 18,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                  color: Colors.amber,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: Text(
                                        _jasaList[index].namaJasa,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'montserrat medium', fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 60.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.account_circle, size: 10,),
                                          Text(
                                            _jasaList[index].email,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'montserrat medium'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0, left: 150),
                                      child: Text(
                                       'Rp. ' + _jasaList[index].harga,
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
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: themeColors,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          label: Text(
            'Tambah Jasa',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'montserrat',
              fontSize: 12,
            ),
          ),
          onPressed: () {
            Get.off(BuatJasaScreen());
          }),
    );
  }

  void getlistJasa() {
    DatabaseReference _ref =
    FirebaseDatabase.instance.reference().child('UserJasa');

    User _user = FirebaseAuth.instance.currentUser;

    _ref
        .orderByChild('email')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      var Keys = snapshot.value.keys;
      var Data = snapshot.value;

      _jasaList.clear();
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
        _jasaList.add(p);
      }

      setState(() {
        print('length : $_jasaList.length');
      });
    });
  }
}
