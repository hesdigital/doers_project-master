import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doers_project/helper/database.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByTag(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.amberAccent,
                  // leading: Image.network(searchResultSnapshot.docs[index].data()["url"]),
                  // title: searchResultSnapshot.docs[index].data()["judul"],
                  //   subtitle: searchResultSnapshot.docs[index].data()["deskripsi"],
                  leading: Image.network(searchResultSnapshot.docs[index]
                      .data()["gambar1"]
                      .toString()),
                  title: Text(searchResultSnapshot.docs[index]
                      .data()["namaJasa"]
                      .toString()),
                  subtitle: Text(searchResultSnapshot.docs[index]
                      .data()["deskripsi"]
                      .toString()),

                  onTap: () {},
                ),
              );
            })
        : Container();
  }

  Widget userTile(String judul, String deskripsi) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                deskripsi,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Lihat Jasa",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.amber,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchEditingController,
                          decoration: InputDecoration(
                              hintText: "search ...",
                              fillColor: Colors.amber,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        initiateSearch();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xffffffff),
                                  const Color(0xffffffff)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              userList()
            ],
          ),
        ),
      ),
    );
  }
}
