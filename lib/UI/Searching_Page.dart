import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sherpa/UI/Login_Page.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sherpa/UI/style.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


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
                    children: <Widget> [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.flag,
                        color: Color.fromRGBO(252, 119, 119, 100),
                      ),
                      SizedBox(width: 15.w),

                      GestureDetector(
                        child: Container(
                          width: 20.h,
                          height: 10.h,
                          alignment: Alignment.center,
                          //color: Colors.amber,

                          child:new Flexible(
                            child: new TextField(
                              // decoration: const InputDecoration(helperText: "어디로 짐을 보내실건가요"),
                              style: TextStyle(
                                fontSize: 20.sp,
                              ),
                              onChanged: (input){
                                _getAutocompletePlaces(input);
                              },
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
      ),

    );
  }

  Future<bool> _getAutocompletePlaces(input) async {
    final str = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&language=ko&key=AIzaSyCrMf2ZtsjCreWP2F_wg-i-7dqJJUIjxgc';
    final url = Uri.parse(str);

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var json = jsonDecode(response.body);
    print("주소는" + jsonDecode(response.body)['predictions'][0]["description"]);
    print("주소는" + jsonDecode(response.body)['predictions'][0]["place_id"]);
    print("placeId" + jsonDecode(response.body)['results'][0]['structured_formatting']['main_text']);
    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
}