import 'package:doers_project/helper/constColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMisi extends StatefulWidget {
  var gambar, nama, lokasi, judul, harga, deskripsi, estimasiwaktu;
  DetailMisi(
      {this.harga,
      this.gambar,
      this.nama,
      this.lokasi,
      this.judul,
      this.deskripsi,
      this.deskripsi});
  @override
  _DetailMisiState createState() => _DetailMisiState();
}

class _DetailMisiState extends State<DetailMisi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: widget.gambar != null
                      ? Image.network(
                          widget.gambar,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width,
                  color: themeColors,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png'),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      //   height: 5,
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.nama != null
                                  ? Text(
                                      widget.nama,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  : Text(
                                      'Nama Jasa',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                              widget.lokasi != null
                                  ? Text(
                                      widget.lokasi,
                                      style: (TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'montserrat',
                                          color: Colors.black)),
                                    )
                                  : Text(
                                      'widget.lokasi',
                                      style: (TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'montserrat',
                                          color: Colors.black)),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 2,
                    child: widget.judul != null
                        ? Text(
                            widget.judul,
                            style: (TextStyle(
                                fontSize: 16,
                                fontFamily: 'montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                          )
                        : Text(
                            'Judul jasa',
                            style: (TextStyle(
                                fontSize: 16,
                                fontFamily: 'montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: widget.deskripsi != null
                      ? Text(
                    widget.deskripsi,
                    style: (TextStyle(
                      fontSize: 12,
                      fontFamily: 'montserrat',
                      color: Colors.black,
                    )),
                  )
                      : Text(
                    'Deskripsi produk',
                    style: (TextStyle(
                      fontSize: 12,
                      fontFamily: 'montserrat',
                      color: Colors.black,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 46.0),
                  child: widget.estimasiwaktu != null
                      ? Text(
                    'Estimasi Waktu : ' + widget.estimasiwaktu + ' Hari',
                    style: (TextStyle(
                      fontSize: 12,
                      fontFamily: 'montserrat',
                      color: Colors.black,
                    )),
                  )
                      : Text(
                    'Estimasi Waktu : ',
                    style: (TextStyle(
                      fontSize: 12,
                      fontFamily: 'montserrat',
                      color: Colors.black,
                    )),
                  ),
                ),
                widget.harga != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text('IDR ' + widget.harga)),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'IDR. Harga ',
                            style: (TextStyle(
                                fontSize: 12,
                                fontFamily: 'montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                Divider(
                  height: 35,
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Deskripsi',
                    style: (TextStyle(
                        fontSize: 16,
                        fontFamily: 'montserrat',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                  ),
                ),
                Divider(
                  height: 35,
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24.0, left: 24.0, right: 24.0, bottom: 8),
                  child: MaterialButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: themeColors,
                      minWidth: double.maxFinite,
                      child: Text(
                        'TERIMA MISI',
                        style: TextStyle(
                            fontFamily: 'montserrat medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        // // Get.to(OrderPage(
                        // //   namaJasa: widget.judul,
                        // //   harga: widget.harga,
                        // //   estimasiWaktu: widget.estimasiWaktu,
                        // //   gambar: widget.gambar,
                        // //   penyediaJasa: widget.nama,
                        // ));
                      }),
                ),

              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                      onPressed: null),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8),
                  child: IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                      onPressed: null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
