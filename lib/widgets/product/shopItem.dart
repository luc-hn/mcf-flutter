import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../screens/product.dart';

class shopItem extends StatelessWidget {
  final Item;
  shopItem({Key, key, @required this.Item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Product(Item)))
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: ClipRRect(
                      // child: Image.network(Item['image_gallery']['main_image'],
                      //     height: 80, fit: BoxFit.cover),
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/loading.gif',
                          image: Item['image_gallery']['main_image'].length > 0
                              ? Item['image_gallery']['main_image']
                              : 'images/logo-mcf.jpg',
                          height: 80.0,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 90.0,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Item['name'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Item['address'] + ', ' + Item['sub_district'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Color(0xFF999999)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Kiem tra xem co danh gia chua
                            Item['rating']['average'] > 0
                                ? RatingBar(
                                    initialRating:
                                        Item['rating']['average'].toDouble(),
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
                                : Text('')
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Lượt xem: ' + Item['views'].toString(),
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 13.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFe5e5e5),
          )
        ],
      ),
    );
  }
}
