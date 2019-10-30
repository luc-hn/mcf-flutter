import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../product/shopItem.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('shops')
          .where('active', isEqualTo: true)
          .where('display', isEqualTo: true)
          .limit(20)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Image.asset('images/abc.gif'),
            alignment: Alignment(0.0, 0.0),
          );
        else {
          return Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 2150,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
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
