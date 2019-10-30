import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/image_gallery.dart';
import '../models/header_search.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Product extends StatelessWidget {
  final shop;
  Product(this.shop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _blockTop(context),
                ),
                _noticeBar(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      _blockAddress(context),
                      _buildButton(),
                      _blockInfo(),
                      _blockRating()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _noticeBar() {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFffeeef)),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.notifications_active,
            color: Color(0xFFff5b60),
            size: 18,
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Text(
              'Click vào ảnh trên để xem nhiều ảnh hơn nhé',
              style: TextStyle(color: Color(0xFFff5b60), fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Icon(
            Icons.arrow_upward,
            color: Color(0xFFff5b60),
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget gradientAppBar(context) {
    return GradientAppBar(
      title: Text(shop['name']),
      gradient: LinearGradient(
          stops: [0.1, 0.5, 0.9],
          colors: [Color(0xFFff4f18), Color(0xFFff2000), Color(0xFFf10000)]),
      //  centerTitle: true,
      actions: <Widget>[
        HeaderSearch(),
      ],
    );
  }

  Widget _blockTop(context) {
    int image_count = shop['image_gallery']['product_images'].length +
        shop['image_gallery']['space_images'].length +
        shop['image_gallery']['menu_images'].length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      shop['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  shop['rating']['average'] > 0
                      ? RatingBar(
                          initialRating: shop['rating']['average'].toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        )
                      : Text(
                          'Chưa có đánh giá',
                          style: TextStyle(color: Color(0XFF999999)),
                        )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text('Lượt xem: ' + shop['views'].toString(),
                      style: TextStyle(color: Color(0XFF999999)))
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  image_count > 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageGallery(shop)))
                      : null
                  // image_count > 0
                  //     ? Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ImageGallery(shop)))
                  //     : null
                },
                child: Stack(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: 'images/loading.gif',
                      image: shop['image_gallery']['main_image'].length > 0
                          ? shop['image_gallery']['main_image']
                          : 'images/logo-mcf.jpg',
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                    image_count > 0
                        ? Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              child: Text(
                                image_count.toString(),
                                style: TextStyle(
                                    color: Color(0xFFff5b60), fontSize: 10),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _blockAddress(context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(TextSpan(children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.place,
                        size: 17,
                      ),
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      width: 5.0,
                    )),
                    TextSpan(
                        text: shop['address'] + ', ' + shop['sub_district'])
                  ]))
                ],
              ),
            ),
            //  Row(
            //       children: <Widget>[
            //         Icon(
            //           Icons.home,
            //           size: 18,
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 5),
            //         ),
            //         Text(shop['address'] + ', ' + shop['sub_district'])
            //       ],
            //     )
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[Text('Gọi taxi')],
                            ),
                            content: SizedBox(
                              height: 250.0,
                              width: 400.0,
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    child: ListTile(
                                      title: Text('Taxi 883'),
                                      subtitle: Text('02033883883'),
                                      onTap: () {
                                        _launchURL('tel:' + '02033883883');
                                      },
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Taxi Bắc Luân'),
                                      subtitle: Text('02033555555'),
                                      onTap: () {
                                        _launchURL('tel:' + '02033555555');
                                      },
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text('Taxi 766'),
                                      subtitle: Text('02033766766'),
                                      onTap: () {
                                        _launchURL('tel:' + '02033766766');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Đóng'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        })
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.directions_car,
                        size: 18,
                        color: Color(0xFF5878b4),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                      Text(
                        'Gọi Taxi',
                        style: TextStyle(color: Color(0xFF5878b4)),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _blockInfo() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'THÔNG TIN GIAN HÀNG',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Thời gian làm việc',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              Row(
                children: <Widget>[Text(shop['opening_time'])],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Text(
                    'Số điện thoại',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              Row(
                children: <Widget>[Text(shop['phone'])],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
              ),
              Divider(),
            ],
          ),
        )
      ],
    );
  }

  Widget _blockRating() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'ĐÁNH GIÁ GIAN HÀNG',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              )
            ],
          ),
          shop['rating']['data'].length > 0
              ? _buildComments()
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/empty.png',
                          height: 150,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text('Gian hàng chưa có đánh giá')],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Icon(
          //       Icons.message,
          //       color: Color(0xFF2f86f6),
          //       size: 16,
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(left: 5.0),
          //     ),
          //     Text(
          //       'Viết đánh giá',
          //       style: TextStyle(color: Color(0xFF2f86f6)),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _buildComments() {
    void open(BuildContext context, final List image_array, final int index,
        final String comment) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GalleryPhotoViewer(image_array, index, comment)));
    }

    return SizedBox(
      height: 350,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: shop['rating']['data'].length,
        itemBuilder: (context, index) {
          var rating = shop['rating']['data'][index];
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: NetworkImage(rating['user_avata']),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  rating['user_name'],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              RatingBar(
                                initialRating: rating['star'].toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(rating['comment']),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          rating['images'].length > 0
                              ? Row(
                                  children: <Widget>[
                                    Wrap(
                                      spacing: 5.0,
                                      alignment: WrapAlignment.start,
                                      children: rating['images']
                                          .map<Widget>(
                                              (item) => GestureDetector(
                                                  onTap: () => {
                                                        open(
                                                            context,
                                                            rating['images'],
                                                            rating['images']
                                                                .indexOf(item),
                                                            rating['comment'])
                                                      },
                                                  child: SizedBox(
                                                    height: 55.0,
                                                    width: 55.0,
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'images/loading.gif',
                                                      image: item,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )))
                                          .toList(),
                                    )
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          );
          // return Card(
          //   child: Center(
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         radius: 40.0,
          //         backgroundImage: NetworkImage(rating['user_avata']),
          //       ),
          //       title: Text(rating['user_name']),
          //       subtitle: Text(rating['comment']),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(stops: [
                0.1,
                0.5,
                0.9
              ], colors: [
                Color(0xFFff4f18),
                Color(0xFFff2000),
                Color(0xFFf10000)
              ]),
            ),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.phone,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                ),
                Text('Gọi mua hàng',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 15))
              ],
            ),
          ),
          onPressed: () => {_launchURL('tel:' + shop['phone'])},
          textColor: Colors.white,
        ),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class GalleryPhotoViewer extends StatelessWidget {
  int currentIndex;
  List image_array;
  String comment;
  GalleryPhotoViewer(this.image_array, this.currentIndex, this.comment);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.comment,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.only(bottom: 40.0),
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: BouncingScrollPhysics(),
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(image_array[index]),
                  );
                },
                itemCount: image_array.length,
                backgroundDecoration: BoxDecoration(color: Colors.white),
                pageController: PageController(initialPage: currentIndex),
              ),
            ],
          )),
    );
  }
}
