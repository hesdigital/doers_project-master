import 'package:doers_project/frontmenu/homeScreen.dart';
import 'package:doers_project/frontmenu/profileScreen.dart';
import 'package:doers_project/helper/constColor.dart';
import 'package:doers_project/ui/widget/chat/chatRoom.dart';
import 'package:doers_project/ui/widget/jasa/buatJasaScreen.dart';
import 'package:doers_project/ui/widget/menu/profilPeramalScreen.dart';
import 'package:doers_project/ui/widget/misi/buatMisi.dart';
import 'package:doers_project/ui/widget/notifikasi/notifikasiScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat/chatScreen.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  TabController _controller;

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomeScreen(),
    ChatRoom(),
    NotifikasiScreen(),
    ProfilPeramalScreen(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen(); // Our first view in viewport

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
   _configNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          backgroundColor: themeColors,
          child: Icon(Icons.add),
          onPressed: () {
            _onFabPress();
            // Get.to(BuatJasaScreen());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomeScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      color: currentTab == 0 ? Colors.black : Colors.amber,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ChatRoom(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.chat,
                      color: currentTab == 1 ? Colors.black : Colors.amber,
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            NotifikasiScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: currentTab == 2 ? Colors.black : Colors.amber,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ProfileScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: currentTab == 3 ? Colors.black : Colors.amber,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onFabPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: _builderBottomSheet(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(30),
                topLeft: const Radius.circular(30)
            )
            ),
          );
        });
  }

  Column _builderBottomSheet() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.note_add),
          title: Text('Jasa'),
          onTap: () {
            Get.to(BuatJasaScreen());
          },
        ),
        ListTile(
          leading: Icon(Icons.note_add),
          title: Text('Misi'),
          onTap: () {
            Get.to(BuatMisiScreen());
          },
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => null;

  _configNotification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
    );
  }
}

// class CircularButton extends StatelessWidget {
//
//   final double width;
//   final double height;
//   final Color color;
//   final Icon icon;
//   final Function onClick;
//
//   CircularButton({this.color, this.width, this.height, this.icon, this.onClick});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: color,shape: BoxShape.circle),
//       width: width,
//       height: height,
//       child: IconButton(icon: icon,enableFeedback: true, onPressed: onClick),
//     );
//   }

// }
