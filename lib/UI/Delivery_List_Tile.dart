import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/Deliveryman/Accept_Info_page.dart';
import 'package:sherpa/Deliveryman/Delivery_Info_page.dart';

class Delivery_List_Tile extends StatelessWidget {
  String str = '';
  String orderId = '';
  Delivery_List_Tile({
    Key? key,
    required this.str,
    required this.orderId
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => Accept_Info_page(str: str, luggageId: orderId,))
              );
            },
            child: Container(
              width: 360.w,
              padding: EdgeInsets.all(8.0),
              child: Text(
                str,
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
