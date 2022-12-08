import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/Deliveryman/MainScreen_Deliveryman.dart';
import 'package:sherpa/UI/Delivery_List_Tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sherpa/key.dart';

import '../provider/luggagesetting_provider.dart';
import 'Order_Info_page.dart';

class Luggage_List_Page extends StatefulWidget {
  const Luggage_List_Page({Key? key}) : super(key: key);

  @override
  State<Luggage_List_Page> createState() => _Luggage_List_PageState();
}

class _Luggage_List_PageState extends State<Luggage_List_Page> {

  String name = "";
  String orderId = '';
  String orderName = '';

  @override
  void initState() {
    super.initState();
    _setOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('배송 완료 리스트',
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

              SizedBox(
                height: 8.h,
              ),
              Container(
                margin:
                EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: SherpaColor.sherpa_main,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.card_travel,
                    size: 40.sp,
                  ),
                  title: Text(
                    '내가 맡긴 짐',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '세부 정보',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () {

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Order_Info_page(str: "내가 맡긴 짐", luggageId: orderId,))
                    );
                    // showLuggageSetting(context);
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
              // Delivery_List_Tile(str: '${orderName}님의 캐리어', orderId: orderId),
              // Delivery_List_Tile(str: '원동연님의 캐리어', orderId: '',),

            ],
          ),
        ],
      ),



    );
  }


  _setOrders() async {
    await _getMyOrders();
  }

  _getMyOrders() async {


    final uri = Uri.parse("${Api.ROOTURL}/orders/memberId");

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);
      var order = info[0];
      orderId = order['orderId'];
      orderName = '원동연';
      setState(() {

      });
      // info.forEach((order) => {
      //   name = _getUsername(order['travelerId'])
      // });
      // addMarker(latLng, id)
      return true;
    }
    else {
      return false;
    }

  }
}
