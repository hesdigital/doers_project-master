import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doers_project/frontMenu/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PenjelasanScreen extends StatefulWidget {
  @override
  _PenjelasanScreenState createState() => _PenjelasanScreenState();
}

class _PenjelasanScreenState extends State<PenjelasanScreen> {
  List _teksList = [
    'Cari dan daftarkan jasa anda bersama Doers',
    'Berbagai kategori jasa bisa anda temukan',
    'Mudahnya melakukan penawaran dengan fitur chat dan nego'
  ];

  List _imgList = [
    'asset/images/illustrasi1 1.png',
    'asset/images/illustrasi 1.png',
    'asset/images/illustrasi3 1.png'
  ];

  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 58.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.off(LoginScreen());
                  },
                  child: Text(
                    'Lewati',
                    style: TextStyle(fontSize: 12, fontFamily: 'montserrat'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: CarouselSlider.builder(
              itemCount: _imgList.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Image.asset(
                      _imgList[i],
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        _teksList[i],
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'futura',
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                );
              },
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    if(_current == 3) {
                      Get.to(LoginScreen());
                    }
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imgList.map((url) {
              int index = _imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.amber
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
