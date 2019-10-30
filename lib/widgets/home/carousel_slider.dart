import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/mongcaifood.appspot.com/o/banners%2Ftrua-nay-an-gi.png?alt=media&token=0c9f77bd-95c4-49ff-a4e5-1dd84928d531',
  'https://firebasestorage.googleapis.com/v0/b/mongcaifood.appspot.com/o/banners%2Fan-dem-2.png?alt=media&token=ef1fbb9d-bfa2-46e9-8d74-22d22e9faa1f',
  'https://firebasestorage.googleapis.com/v0/b/mongcaifood.appspot.com/o/banners%2Ftra-sua-coffee-banner.png?alt=media&token=a06e63f1-8d07-4e80-912e-5cb74acda9b9'
];

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CarouselSlider autoPlayDemo = CarouselSlider(
      viewportFraction: 1.0,
      aspectRatio: 2.6,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              // child: Image.network(
              //   url,
              //   width: 1000.0,
              // ),
              child: FadeInImage.assetNetwork(
                placeholder: 'images/abc.gif',
                image: url,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );
    return autoPlayDemo;
  }
}
