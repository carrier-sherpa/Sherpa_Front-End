import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'LoginScreen.dart';
import 'MainScreen_Traveler.dart';
import 'package:page_transition/page_transition.dart';
import 'style.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300.h,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: SherpaColor.sherpa_sub,
                              border: Border.all(
                                color: Colors.white30,
                              ),
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0.sp, 1.0.sp), //(x,y)
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Text(
                              '짐 설정하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /*
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ));
                            },
                            */
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.sp, 0, 0, 0),
                        child: Text(
                          '어디로 짐을 보내실건가요?',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.directions_walk,
                        color: SherpaColor.sherpa_main,
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          //color: Colors.amber,
                          child: Text(
                            '현위치: 근처 가게명 가져오기',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 600),
                              type: PageTransitionType.bottomToTopJoined,
                              child: SearchingPage(),
                              childCurrent: MainScreen_Traveler(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 1.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        colors: <Color>[
                          Color.fromRGBO(161, 196, 253, 100),
                          Color.fromRGBO(252, 195, 195, 100),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.flag,
                        color: Color.fromRGBO(252, 119, 119, 100),
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          //color: Colors.amber,
                          child: Text(
                            '어디로 갈까요?',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 600),
                              type: PageTransitionType.bottomToTopJoined,
                              child: SearchingPage(),
                              childCurrent: MainScreen_Traveler(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 10.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                colors: <Color>[
                  Color.fromRGBO(161, 196, 253, 100),
                  Color.fromRGBO(252, 195, 195, 100),
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}