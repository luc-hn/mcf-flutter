import 'package:flutter/material.dart';
import '../../presentation/mcficons_icons.dart';
import '../../screens/category.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 15),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child:
                      _buildMenuItem('Ăn sáng', 'an-sang', Mcficons.breakfast),
                ),
                Expanded(
                  child: _buildMenuItem('Ăn trưa', 'an-trua', Mcficons.lunch),
                ),
                Expanded(
                  child:
                      _buildMenuItem('Ăn đêm', 'an-dem', Mcficons.night_meal),
                ),
                Expanded(
                  child: _buildMenuItem('Ăn vặt', 'an-vat', Mcficons.fast_food),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildMenuItem(
                    'Lẩu - Nướng', 'lau-nuong', Mcficons.fast_food),
              ),
              Expanded(
                child:
                    _buildMenuItem('Nhà hàng', 'nha-hang', Mcficons.restaurent),
              ),
              Expanded(
                child: _buildMenuItem('Quán nhậu', 'quan-nhau', Mcficons.beer),
              ),
              Expanded(
                child: _buildMenuItem('Đồ uống', 'do-uong', Mcficons.milk_tea),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _buildMenuItem extends StatelessWidget {
  String name;
  IconData menu_icon;
  String id;
  _buildMenuItem(this.name, this.id, this.menu_icon);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Category(id, name)))
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [
                    0.2,
                    0.4,
                    0.9
                  ],
                  colors: [
                    Color(0xFFff4f18),
                    Color(0xFFff2000),
                    Color(0xFFf10000)
                  ]),
              borderRadius: BorderRadius.circular(100.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.all(10.0),
            width: 50.0,
            height: 50.0,
            child: Icon(
              menu_icon,
              color: Colors.white,
            ),
          ),
          Text(name,
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
