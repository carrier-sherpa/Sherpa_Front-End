import 'package:flutter/material.dart';
import 'package:sherpa/UI/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';
import 'package:sherpa/Traveler/ReservationTimeSetting_Arrive.dart';
import 'package:sherpa/Traveler/ReservationTimeSetting_Depart.dart';

void showReservationTimeSetting(context) {
  DateTime _dateTime = DateTime.now();
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 360.w,
            height: 540.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
            ),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Text(
                    '예약시간 설정',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TabBar 구현. 각 컨텐트를 호출할 탭들을 등록
                  bottom: TabBar(
                    tabs: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.sp),
                        child: Text(
                          '출발시간 설정',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.sp),
                        child: Text(
                          '도착시간 설정',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // TabVarView 구현. 각 탭에 해당하는 컨텐트 구성
                body: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBarView(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            ReservationTimeSetting_Depart(),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '밀어서 도착시간 설정하기 >>',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ReservationTimeSetting_Arrive(),
                            SizedBox(
                              height: 8.h,
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: SherpaColor.sherpa_main,
                                  border: Border.all(
                                    color: Colors.white30,
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0.sp, 1.0.sp), //(x,y)
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '완료',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Provider.of<ReservationTimeSettingProvider>(
                                    context,
                                    listen: false)
                                    .updateTime();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
