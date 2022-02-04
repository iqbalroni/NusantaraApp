import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'cari.dart';
import 'categori.dart';
import 'detail.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  resipe() async {
    Uri url =
        Uri.parse("https://masak-apa-tomorisakura.vercel.app/api/recipes/1");
    var respon = await http.get(url);
    var data = json.decode(respon.body)["results"];
    return data;
  }

  Future fresh() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeApp();
    }));
  }
  
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: Color(0xff5AB886),
          onRefresh: fresh,
          child: ListView(
            children: [
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg2.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 15,
                        left: 15,
                        top: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hallo, Chef!!",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                          Text(
                            "Ayo Memasak Bersama Ku",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: search,
                                    onSubmitted: (value) {
                                      setState(() {
                                        search == value;
                                      });
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Cari(
                                          keySearch: value,
                                        );
                                      }));
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search In Here",
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    if (search.text == "") {
                                    } else {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Cari(
                                          keySearch: search.text,
                                        );
                                      }));
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Color(0xff5AB886),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child:
                                        Icon(Icons.search, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Masakan Jepang",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF303030),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Sashimi Japanese"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Color(0xffFFA930)),
                                    Icon(Icons.star, color: Color(0xffFFA930)),
                                    Icon(Icons.star, color: Color(0xffFFA930)),
                                    Icon(Icons.star, color: Color(0xffFFA930)),
                                    Icon(Icons.star, color: Color(0xFF979797)),
                                  ],
                                ),
                                Text("4.2 (200 Suka)"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hot Place",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF8F8F8F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ContentImage(
                        gambar:
                            "https://www.masakapahariini.com/wp-content/uploads/2019/02/udang-saus-pedas-780x440.jpg",
                        views: "4.4 (2876 views)",
                        judul: "Resep Tumis Udang Pedas",
                        keyapi: 'resep-tumis-udang-rasa-pedas',
                      ),
                      ContentImage(
                        gambar:
                            "https://www.masakapahariini.com/wp-content/uploads/2020/04/Nugget-Ayam-Pedas-780x440.jpg",
                        views: "4.4 (2876 views)",
                        judul: "Resep Nugget Ayam Pedas",
                        keyapi: 'resep-nugget-ayam-pedas',
                      ),
                      ContentImage(
                        gambar:
                            "https://www.masakapahariini.com/wp-content/uploads/2020/12/opor-ayam-putih-780x440.jpg",
                        views: "4.4 (2876 views)",
                        judul: "Resep Opor Ayam Putih",
                        keyapi: 'resep-opor-ayam-putih',
                      ),
                      ContentImage(
                        gambar:
                            "https://www.masakapahariini.com/wp-content/uploads/2021/09/03.-Nasi-Goreng-Gila-400x240.jpg",
                        views: "4.4 (2876 views)",
                        judul: "Resep Nasi Gila",
                        keyapi: 'resep-nasi-gila',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    kategori(
                      nama: "Dessert",
                      keyApi: "resep-dessert",
                    ),
                    kategori(
                      nama: "Masakan Hari Raya",
                      keyApi: "masakan-hari-raya",
                    ),
                    kategori(
                      nama: "Masakan Tradisional",
                      keyApi: "masakan-tradisional",
                    ),
                    kategori(
                      nama: "Menu Makan Malam",
                      keyApi: "makan-malam",
                    ),
                    kategori(
                      nama: "Menu Makan Siang",
                      keyApi: "makan-siang",
                    ),
                    kategori(
                      nama: "Resep Ayam",
                      keyApi: "resep-ayam",
                    ),
                    kategori(
                      nama: "Resep Daging",
                      keyApi: "resep-daging",
                    ),
                    kategori(
                      nama: "Resep Sayuran",
                      keyApi: "resep-sayuran",
                    ),
                    kategori(
                      nama: "Resep Seafood",
                      keyApi: "resep-seafood",
                    ),
                    kategori(
                      nama: "Sarapan",
                      keyApi: "sarapan",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rekomendasi",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff303030),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: resipe(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("DiPerlukan Internet"));
                    }
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
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
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index]["title"]
                                                  .toString(),
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
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(snapshot
                                                      .data[index]["dificulty"]
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
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(snapshot
                                                      .data[index]["times"]
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
                      // child: CircularProgressIndicator(
                      //   backgroundColor: Color(0xff5AB886),
                      //   color: Color(0xffF7F5FF),
                      // ),
                      child: SpinKitThreeBounce(
                        color: Color(0xff5AB886),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class kategori extends StatelessWidget {
  final String nama;
  final String keyApi;
  const kategori({
    required this.nama,
    required this.keyApi,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Kategori(
            kategori: nama,
            kunci: keyApi,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        // width: 150,
        // height: 50,
        child: Center(
          child: Text(
            nama,
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xff5AB886),
          borderRadius: BorderRadius.circular(15),
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
