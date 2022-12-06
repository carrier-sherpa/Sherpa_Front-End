import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/Deliveryman/MainScreen_Deliveryman.dart';
import 'package:sherpa/UI/Delivery_List_Tile.dart';

class Luggage_List_Page extends StatefulWidget {
  const Luggage_List_Page({Key? key}) : super(key: key);

  @override
  State<Luggage_List_Page> createState() => _Luggage_List_PageState();
}

class _Luggage_List_PageState extends State<Luggage_List_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 예약 리스트',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: SherpaColor.sherpa_main,
      ),
      body: Column(
        children: [
          ListView(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              Delivery_List_Tile(str: '깜찍이님의 캐리어'),
              Delivery_List_Tile(str: '원동연님의 캐리어'),

            ],
          ),
        ],
      ),



    );
  }
}
