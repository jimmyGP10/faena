import 'package:carousel_slider/carousel_slider.dart';
import 'package:faena/src/home/models/category.dart';
import 'package:flutter/material.dart';

class Carrousel extends StatefulWidget {
  final List<Category> categoryList;
  const Carrousel({Key key, this.categoryList}) : super(key: key);

  @override
  _CarrouselState createState() => _CarrouselState();
}

class _CarrouselState extends State<Carrousel> {
  List imgList = [
    'https://image.freepik.com/foto-gratis/familia-feliz-ninos-desempacando-cajas-que-mudan-su-nuevo-hogar_1163-4830.jpg',
    'https://image.freepik.com/foto-gratis/familia-feliz-ninos-desempacando-cajas-que-mudan-su-nuevo-hogar_1163-4830.jpg',
    'https://image.freepik.com/foto-gratis/familia-feliz-ninos-desempacando-cajas-que-mudan-su-nuevo-hogar_1163-4830.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          pauseAutoPlayOnTouch: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: widget.categoryList.map((i) {
          return Builder(builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: NetworkImage(i.photoURL), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: Color.fromRGBO(255, 255, 255, 0.92)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(i.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Expanded(child: Text(i.description))
                              ]))
                    ]));
          });
        }).toList(),
      ),
    );
  }
}
