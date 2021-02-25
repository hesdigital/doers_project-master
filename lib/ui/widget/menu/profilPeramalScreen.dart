import 'package:doers_project/frontmenu/profileScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/ui/widget/menu/dataDiriScreen.dart';
import 'package:doers_project/ui/widget/views/tentangSayaPelamar.dart';
import 'package:flutter/material.dart';

class ProfilPeramalScreen extends StatefulWidget {
  @override
  _ProfilPeramalScreenState createState() => _ProfilPeramalScreenState();
}

class _ProfilPeramalScreenState extends State<ProfilPeramalScreen> {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final tab = new DefaultTabController(
    length: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tentang Pekerja'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 220,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://i.pinimg.com/originals/a6/58/32/a65832155622ac173337874f02b218fb.png')),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Container(
                        //color: Colors.white,
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FutureBuilder(
                            // future: getData(),
                            builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30.0, left: 8.0),
                                child: Text(
                                  'Nama Orang',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'montserrat',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Verified',
                                  style: (TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'montserrat')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 12,
                                    ),
                                    Text(
                                      '4.2',
                                      style: (TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'montserrat')),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      )
                    ])
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: TabBar(
                    indicatorColor: themeColors,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black38,
                    tabs: [
                      Tab(
                        text: 'Tentang Saya',
                      ),
                      Tab(
                        text: 'Jasa',
                      ),
                      Tab(
                        text: 'Review',
                      ),
                    ],
                  ),
                  body: TabBarView(children: [
                    ScreenTentangSayaPlamar(),
                    DataDiriScreen(),
                    DataDiriScreen()
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
