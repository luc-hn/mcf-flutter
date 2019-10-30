import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './shopItem.dart';

class Listing extends StatelessWidget {
  final id;
  Listing(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('shops')
          .where('categories', arrayContains: this.id)
          .where('active', isEqualTo: true)
          .where('display', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Image.asset('images/abc.gif'),
            alignment: Alignment(0.0, 0.0),
          );
        else {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 3.14,
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot shop = snapshot.data.documents[index];
                        return shopItem(Item: shop);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
