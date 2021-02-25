import 'package:doers_project/frontmenu/homeScreen.dart';
import 'package:doers_project/frontmenu/loginScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/helper/selectable_item.dart';
import 'package:doers_project/ui/widget/menu/mainmenu.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  DragSelectGridViewController _gridController = DragSelectGridViewController();
  bool _selection = false;

  List _interestList = [
    {'gambar': 'asset/images/design.png', 'nama': 'Design'},
    {'gambar': 'asset/images/ac.png', 'nama': 'Elektronik'},
    {'gambar': 'asset/images/child_care.png', 'nama': 'Gaya Hidup'},
    {'gambar': 'asset/images/pembangunan.png', 'nama': 'Pertukangan'},
    {'gambar': 'asset/images/rumah tangga.png', 'nama': 'Rumah Tangga'},
  ];

  bool _selectedItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: InkWell(
                    onTap: () {
                     Get.off(MainMenu());
                    },
                    child: Text(
                      'Lewati',
                      style:
                      TextStyle(fontSize: 12, fontFamily: 'montserrat'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, top: 58.0),
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left:  60.0,),
              child: Text('Pilih Ketertarikanmu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'montserrat'),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left:  60.0,),
              child: Text('Anda bisa memilih lebih dari 1 atau lewati'),
            ),
            Padding(
              padding: const EdgeInsets.only( left: 58.0, right: 58.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.5,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: _interestList.length,
                    itemBuilder: (context, index) {
                      bool _selectItem = false;
                      return InkWell(
                        onTap: () {
                          if (_selectItem == false) {
                            _selectItem = true;
                            print("Item Selected");
                          } else {
                            setState(() => _selectItem = false);
                            _selectItem = false;
                            print("Item UnSelected");
                          }
                          print('selected ' + _selectItem.toString());
                        },
                        child: Card(
                          child: GridTile(
                            child: Image.asset('${_interestList[index]['gambar']}'),
                            footer: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: Text('${_interestList[index]['nama']}'),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 58.0, left: 58.0),
              child: MaterialButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  minWidth: double.maxFinite,
                  child: Text(
                    'KONFIRMASI',
                    style: TextStyle(
                        fontFamily: 'montserrat medium',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
