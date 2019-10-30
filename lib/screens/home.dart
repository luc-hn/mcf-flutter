import 'package:flutter/material.dart';
import '../widgets/home/carousel_slider.dart';
import '../widgets/home/home_menu.dart';
import '../widgets/home/home_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'search_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/header_search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(context),
      drawer: AppDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CarouselDemo(),
            HomeMenu(),
            ProductList(),
          ],
        ),
      ),
    );
  }

  Widget gradientAppBar(context) {
    return GradientAppBar(
      title: Text('Móng Cái Food'),
      gradient: LinearGradient(
          stops: [0.1, 0.5, 0.9],
          colors: [Color(0xFFff4f18), Color(0xFFff2000), Color(0xFFf10000)]),
      centerTitle: true,
      // leading: IconButton(
      //   icon: Icon(Icons.menu),
      //   onPressed: () {},
      // ),
      actions: <Widget>[HeaderSearch()],
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(color: Color(0xFFff2000)),
          //   accountName: Text('Hoàng Ngọc Lực'),
          //   accountEmail: Text('hoanglucmc@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: NetworkImage(
          //         'https://scontent.fhph1-2.fna.fbcdn.net/v/t1.0-9/15826567_955862091211636_7704479604883057804_n.jpg?_nc_cat=108&_nc_oc=AQkwvmv_0gfE8RC23EHC2TzW80RJyg6wcW1JsIu_BmLdH3zv5dUps1bZiy1F-jWukV4&_nc_ht=scontent.fhph1-2.fna&oh=b33b4adc1a9712f6a0faa8b762f7b1de&oe=5DF2AF97'),
          //   ),
          // ),
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/header-background.jpg'))),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("Móng Cái Food",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500))),
              ])),
          // ListTile(
          //   title: Text("Mở gian hàng miễn phí"),
          //   onTap: () => {},
          // ),
          // Divider(),
          ListTile(
            title: Text("Fanpage Móng Cái Food"),
            onTap: () => {
              _launchURL(
                  'https://www.facebook.com/Móng-Cái-Food-322489285328087/')
            },
          ),
          Divider(
            height: 0.0,
          ),
          ListTile(
            title: Text("Nhóm bán hàng trên Facebook"),
            onTap: () => {
              _launchURL('https://www.facebook.com/groups/389134778389813/')
            },
          )
        ],
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
