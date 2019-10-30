import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/product/shopItem.dart';

class HeaderSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: ArticleSearch(),
          );
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         title: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[Text('Thông báo')],
          //         ),
          //         content: Text(
          //             'Chức năng tìm kiếm đang trong giai đoạn phát triển'),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text('Đóng'),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           )
          //         ],
          //       );
          //     });
        },
        icon: Icon(Icons.search));
  }
}

class ArticleSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder(
      stream: Firestore.instance
          .collection('shops')
          .where('active', isEqualTo: true)
          .where('display', isEqualTo: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("No Data"),
          );
        }

        final results = snapshot.data.documents.where((a) =>
            a['name'].toLowerCase().contains(query) ||
            a['tags'].contains(query));

        return Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 2150,
                  // child: ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: snapshot.data.documents.length,
                  //   itemBuilder: (context, index) {
                  //     DocumentSnapshot shop = snapshot.data.documents[index];
                  //     return shopItem(Item: shop);
                  //   },
                  // ),
                  child: ListView(
                    children: results
                        .map<shopItem>((shop) => shopItem(Item: shop))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Nhập từ khóa';

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container(
      // decoration: BoxDecoration(color: Colors.white),
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('search_suggestions')
            .document('data')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Data'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: snapshot.data['suggestions']
                  .map<Widget>((item) => InkWell(
                        child: Chip(
                          label: Text(item),
                          backgroundColor: Color(0xFFebebeb),
                        ),
                        onTap: () {
                          query = item.toLowerCase();
                          showResults(context);
                        },
                      ))
                  .toList(),
            ),
          );
          // return ListView.builder(
          //   itemCount: snapshot.data['suggestions'].length,
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       child: Chip(
          //         label: Text(snapshot.data['suggestions'][index]),
          //         backgroundColor: Color(0xFFebebeb),
          //       ),
          //       onTap: () {
          //         query = snapshot.data['suggestions'][index].toLowerCase();
          //         showResults(context);
          //       },
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
