import 'package:doers_project/helper/constColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailPembelian extends StatefulWidget {
  var judul,
      url,
      judulJasa,
      penyediaJasa,
      tanggal,
      estimasiWaktu,
      alamat,
      catatan,
      harga,
      metodePembayaran;
  DetailPembelian(
      {this.judul,
      this.url,
      this.penyediaJasa,
      this.judulJasa,
      this.tanggal,
      this.estimasiWaktu,
      this.metodePembayaran,
      this.alamat,
      this.catatan,
      this.harga});
  @override
  _DetailPembelianState createState() => _DetailPembelianState();
}

class _DetailPembelianState extends State<DetailPembelian> {
  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f4e1),
      appBar: AppBar(
        title: Text(widget.judul, style: TextStyle(
            color: Colors.black,
            fontFamily: 'montserrat',
            fontSize: 16)
        ),
        backgroundColor: themeColors,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Menunggu Konfirmasi',
                      style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'futura',
                          fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      now.toString(),
                      style: TextStyle(fontFamily: 'futura', fontSize: 12),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                      child: widget.url != null
                          ? Image.network(widget.url, fit: BoxFit.cover,)
                          : Icon(Icons.image),
                    ),
                    widget.judulJasa != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.judulJasa,
                              style: TextStyle(
                                  fontFamily: 'futura', fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Judul Jasa',
                              style: TextStyle(
                                  fontFamily: 'futura',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  'Detail Pesanan',
                  style: TextStyle(
                      fontFamily: 'futura',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Penyedia Jasa :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.penyediaJasa != null
                        ? Text(
                            widget.penyediaJasa,
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          )
                        : Text(
                            'Penyedia Jasa',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Waktu Pengerjaan :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.tanggal != null
                        ? Text(
                            widget.tanggal,
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          )
                        : Text(
                            'Tanggal Pengerjaan',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Durasi :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.estimasiWaktu != null
                        ? Text(
                            widget.estimasiWaktu + ' Hari',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          )
                        : Text(
                            'Estimasi Waktu',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 22.0),
                child: Text(
                  'Alamat',
                  style: TextStyle(
                    fontFamily: 'futura',
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: widget.alamat != null
                    ? Text(
                        widget.alamat,
                        style: TextStyle(
                          fontFamily: 'futura',
                          fontSize: 10,
                        ),
                      )
                    : Text(
                        'Jl. Teuku Umar no. 34a, Bandar Lampung',
                        style: TextStyle(
                          fontFamily: 'futura',
                          fontSize: 10,
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Catatan :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.catatan != null
                        ? Text(
                            widget.catatan ,
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          )
                        : Text(
                            'Tidak Ada',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          ),
                  ],
                ),
              ),
              Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  'Detail Pembayaran',
                  style: TextStyle(
                      fontFamily: 'futura',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Metode Pembayaran :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.metodePembayaran != null
                        ? Text(
                            widget.metodePembayaran,
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 12,
                            ),
                          )
                        : Text(
                            'Transfer',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 10,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Container(
                  color: Color(0xffd4d4d4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Sub Total :',
                          style: TextStyle(
                            fontFamily: 'futura',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Spacer(),
                      widget.harga != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                widget.harga,
                                style: TextStyle(
                                  fontFamily: 'futura',
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                'Rp. 0000000',
                                style: TextStyle(
                                  fontFamily: 'futura',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Total :',
                      style: TextStyle(
                        fontFamily: 'futura',
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    widget.harga != null
                        ? Text(
                            'Rp. ' + widget.harga,
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 14,
                            ),
                          )
                        : Text(
                            'Rp. 0000000',
                            style: TextStyle(
                              fontFamily: 'futura',
                              fontSize: 14,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: themeColors,
                    minWidth: double.maxFinite,
                    child: Text(
                      'Batalkan Pesanan',
                      style: TextStyle(
                          fontFamily: 'montserrat medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      batalkanPesanan();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void batalkanPesanan() {
    User _user = FirebaseAuth.instance.currentUser;

    FirebaseDatabase.instance
        .reference()
        .child('menunggu konfirmasi')
        .orderByChild('penyedia jasa')
        .equalTo(_user.email)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        FirebaseDatabase.instance
            .reference()
            .child('menunggu konfirmasi')
            .child(key)
            .remove()
            .whenComplete(() => print("Berhasil ditolak"));
      });
    });
  }
}
