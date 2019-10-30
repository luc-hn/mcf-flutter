import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../widgets/product/listing.dart';
import '../models/header_search.dart';

class Category extends StatelessWidget {
  final id;
  final name;
  Category(this.id, this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(context),
      body: SafeArea(
        child: Listing(this.id),
      ),
    );
  }

  Widget gradientAppBar(context) {
    return GradientAppBar(
      title: Text(this.name),
      gradient: LinearGradient(
          stops: [0.1, 0.5, 0.9],
          colors: [Color(0xFFff4f18), Color(0xFFff2000), Color(0xFFf10000)]),
      //  centerTitle: true,
      actions: <Widget>[HeaderSearch()],
    );
  }
}
