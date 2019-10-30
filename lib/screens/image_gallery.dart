import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../models/header_search.dart';

class ImageGallery extends StatelessWidget {
  final shop;
  ImageGallery(this.shop);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: gradientAppBar(context),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[
            ChoiceCard([
              ...shop['image_gallery']['product_images'],
              ...shop['image_gallery']['space_images'],
              ...shop['image_gallery']['menu_images']
            ]),
            ChoiceCard(shop['image_gallery']['product_images']),
            ChoiceCard(shop['image_gallery']['space_images']),
            ChoiceCard(shop['image_gallery']['menu_images']),
          ],
        ),
      ),
    );
  }

  Widget gradientAppBar(context) {
    return GradientAppBar(
        title: Text('Thư viện ảnh'),
        gradient: LinearGradient(
            stops: [0.1, 0.5, 0.9],
            colors: [Color(0xFFff4f18), Color(0xFFff2000), Color(0xFFf10000)]),
        //  centerTitle: true,
        actions: <Widget>[
          HeaderSearch(),
        ],
        bottom: TabBar(
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: 'Tât cả ảnh'),
            Tab(text: 'Món ăn'),
            Tab(text: 'Không gian'),
            Tab(text: 'Menu'),
          ],
        ));
  }
}

class ChoiceCard extends StatelessWidget {
  final image_array;
  ChoiceCard(this.image_array);
  void open(BuildContext context, final int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GalleryPhotoViewer(image_array, index)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: image_array.length > 0
          ? GridView.builder(
              itemCount: image_array.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {open(context, index)},
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/loading.gif',
                    image: image_array[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          : Image.asset(
              'images/no-image-news.png',
            ),
    );
    // return PhotoViewGallery.builder(
    //   scrollPhysics: const BouncingScrollPhysics(),
    //   builder: _buildItem,
    //   itemCount: image_array.length,
    //   backgroundDecoration: BoxDecoration(color: Colors.white),
    // );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(image_array[index]),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
    );
  }
}

class GalleryPhotoViewer extends StatelessWidget {
  int currentIndex;
  List image_array;
  GalleryPhotoViewer(this.image_array, this.currentIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thư viện ảnh',
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
