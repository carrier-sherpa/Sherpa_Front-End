import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/style.dart';

class Delivery_Info_page extends StatefulWidget {
  String str = '';
  Delivery_Info_page({
    Key? key,
    required this.str
  }) : super(key: key);

  @override
  State<Delivery_Info_page> createState() => _Delivery_Info_pageState();
}

class _Delivery_Info_pageState extends State<Delivery_Info_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.str),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 320.w,
                height: 480.h,
                color: Colors.blue,
                //TODO 여기에 출발지 목적지 나오는 지도 화면 넣으면 됩니당
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('출발: ' + '12시', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 32.sp
                    ),
                  ),
                  Text('도착: ' + '12시', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 32.sp
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 64.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      '취소'
                    ),
                    onPressed: (){
                      //TODO travel_energy 감소해야함.
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(20)),
                        primary: SherpaColor.sherpa_red,
                        minimumSize: Size(120.sp, 60.sp),
                        textStyle: TextStyle(fontSize: 24.sp)
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                        '배송시작'
                    ),
                    onPressed: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Column(
                                children: [
                                  Text("배송을 시작합니다!",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                              content: Container(
                                width: 320.w,
                                height: 120.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "깜찍이님의 짐을 배송합니다!",   //TODO 깜찍이를 유저 닉네임으로 고쳐야합니다.
                                      style: TextStyle(
                                      fontSize: 20.sp,
                                     ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: Text("확인"),
                                  onPressed: () {
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                                          borderRadius: BorderRadius.circular(20)),
                                      primary: SherpaColor.sherpa_main,
                                      minimumSize: Size(120.sp, 60.sp),
                                      textStyle: TextStyle(fontSize: 24.sp)
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(20)),
                        primary: SherpaColor.sherpa_main,
                        minimumSize: Size(120.sp, 60.sp),
                        textStyle: TextStyle(fontSize: 24.sp)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
