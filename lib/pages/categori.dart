import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'detail.dart';

class Kategori extends StatefulWidget {
  final String kategori;
  final String kunci;
  const Kategori({
    required this.kategori,
    required this.kunci,
    Key? key,
  }) : super(key: key);

  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  all() async {
    Uri url = Uri.parse(
        "https://masak-apa-tomorisakura.vercel.app/api/categorys/recipes/" +
            widget.kunci);
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5AB886),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(widget.kategori),
          elevation: 0,
        ),
        body: FutureBuilder(
          future: all(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("DiPerlukan Internet"));
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Detail(
                              keyApi: snapshot.data[index]["key"],
                            );
                          }),
                        );
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 150,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data[index]["thumb"]),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Color(0xFF5B5B5B),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index]["title"].toString(),
                                      style: TextStyle(
                                        color: Color(0xFF303030),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.restaurant,
                                            color: Color(0xFFFFB83D)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(snapshot.data[index]
                                                  ["dificulty"]
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.alarm,
                                            color: Color(0xff58B985)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(snapshot.data[index]
                                                  ["times"]
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
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

class ContentImage extends StatelessWidget {
  final String gambar;
  final String judul;
  final String views;
  final String keyapi;
  const ContentImage({
    required this.gambar,
    required this.judul,
    required this.views,
    required this.keyapi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Detail(
              keyApi: keyapi,
            );
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 15,
        ),
        child: Container(
          padding: EdgeInsets.only(
            bottom: 10,
            left: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                judul,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                views,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        height: 170,
        width: 230,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(gambar),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
