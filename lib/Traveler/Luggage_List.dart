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

  var orderId = ["", "", "", "", "", ""];
  var orderName = ["", "", "", "", "", ""];
  var orderStatus = ["", "", "", "", "", ""];
  var orderVisibility = [false, false, false, false, false, false];
  var orderDay = ["", "", "", "", "", ""];

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
              Visibility(
                visible: orderVisibility[0],
                child: Container(
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
                        '${orderDay[0]}에 맡긴 짐',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${orderStatus[0]}',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => Order_Info_page(str: '${orderDay[0]}에 맡긴 짐', luggageId: orderId[0],))
                        );
                        // showLuggageSetting(context);
                      },
                      textColor: Colors.white,
                      iconColor: Colors.white,
                    ),
                  ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Visibility(
                visible: orderVisibility[1],
                  child: Container(
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
                        '${orderDay[1]}에 맡긴 짐',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${orderStatus[1]}',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => Order_Info_page(str: '${orderDay[1]}에 맡긴 짐', luggageId: orderId[1],))
                        );
                        // showLuggageSetting(context);
                      },
                      textColor: Colors.white,
                      iconColor: Colors.white,
                    ),
                  ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Visibility(
                visible: orderVisibility[2],
                  child: Container(
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
                        '${orderDay[2]}에 맡긴 짐',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${orderStatus[2]}',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => Order_Info_page(str: '${orderDay[2]}에 맡긴 짐', luggageId: orderId[2],))
                        );
                        // showLuggageSetting(context);
                      },
                      textColor: Colors.white,
                      iconColor: Colors.white,
                    ),
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


    final uri = Uri.parse("${Api.ROOTURL}/orders/travelerId");

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);
      for(int i = 0; i < info.length; i++) {
          var order = info[i];
          orderId[i] = order['orderId'];
          orderName[i] = '원동연';
          orderDay[i] = order['orderDay'];
          orderStatus[i] = _changeButtonByStatus(order["status"]);
          orderVisibility[i] = true;
      }

      setState(() {

      });
      return true;
    }
    else {
      return false;
    }

  }



  String _changeButtonByStatus(status) {
    if (status == "ACCEPT") {
      return "배송 중";
    } else if (status == "REGISTER") {
      return "등록 완료";
    } else if (status == "ARRIVE") {
      return "배송 완료";
    }

    return "세부 정보";
  }
}
