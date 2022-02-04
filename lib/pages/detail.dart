import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final String keyApi;
  const Detail({
    required this.keyApi,
    Key? key,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  detailResipe() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  resipe() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"]["ingredient"];
    return data;
  }

  step() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/recipe/" +
            widget.keyApi);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"]["step"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: detailResipe(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("DiPerlukan Internet"));
            }
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    height: 420,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data["thumb"]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 15,
                            left: 15,
                            top: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.notifications_none_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data["title"],
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Resep By " +
                                          snapshot.data["author"]["user"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContentBox(
                          text: snapshot.data["times"],
                          logo: Icon(
                            Icons.alarm,
                            size: 50,
                            color: Color(0xff58B985),
                          ),
                          warna: Color(0xff58B985),
                        ),
                        ContentBox(
                          text: snapshot.data["dificulty"],
                          logo: Icon(
                            Icons.insert_emoticon,
                            size: 50,
                            color: Color(0xffF7C776),
                          ),
                          warna: Color(0xffF7C776),
                        ),
                        ContentBox(
                          text: snapshot.data["servings"],
                          logo: Icon(
                            Icons.restaurant,
                            size: 50,
                            color: Color(0xff80B1E2),
                          ),
                          warna: Color(0xff80B1E2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Bahan-bahan :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: resipe(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10, left: 30),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5AB886),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Text(snapshot.data[index]),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                          child: SpinKitThreeBounce(
                        color: Color(0xff5AB886),
                        size: 40.0,
                      ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Langkah-langkah :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: step(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10, left: 30),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      width: 5,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0xff5AB886),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Text(snapshot.data[index]),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Color(0xff5AB886),
                          size: 40.0,
                        ),
                      );
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, top: 10),
                  //   child: Text(
                  //     "Deskripsi :",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 25,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 20, right: 20, top: 5, bottom: 15),
                  //   child: Text(snapshot.data["desc"]),
                  // ),
                ],
              );
            }
            return Center(
              child: SpinKitThreeBounce(
                color: Color(0xff5AB886),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  final Icon logo;
  final String text;
  final Color warna;
  const ContentBox({
    required this.logo,
    required this.text,
    required this.warna,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: warna.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          Text(
            text,
            style: TextStyle(
              color: warna,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
