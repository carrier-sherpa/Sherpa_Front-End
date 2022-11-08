import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LoginScreen.dart';
import 'SearchingPage.dart';
import 'style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';

class MainScreen_Traveler extends StatefulWidget {
  const MainScreen_Traveler({Key? key}) : super(key: key);

  @override
  State<MainScreen_Traveler> createState() => _MainScreen_TravelerState();
}

class _MainScreen_TravelerState extends State<MainScreen_Traveler> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5031798, 126.9572013),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(384, 854));
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // 현재 계정 이미지 set
                //backgroundImage: AssetImage('assets/profile.png'), //유저 프로필 사진 넣기
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[
                // 다른 계정 이미지[] set
                CircleAvatar(
                  backgroundColor: Colors.white,
                  //backgroundImage: AssetImage('사진 추가해야함'), //유저 프로필 사진 추가
                ),
              ],
              accountName: Text('유저 이름 넣기'), //유저이름 넣기
              accountEmail: Text('유저 이메일 주소 넣기'), //유저 이메일 주소 넣기
              onDetailsPressed: () {
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                  color: SherpaColor.sherpa_main,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: Text('Home'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('Setting'),
              onTap: () {
                print('Setting is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey[850],
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A is clicked');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: SherpaColor.sherpa_main,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 350.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0.sp, 1.0.sp), //(x,y)
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              icon: Icon(
                                Icons.menu,
                                size: 40.sp,
                              ),
                              onPressed: () {
                                _drawerKey.currentState!.openDrawer();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  '장소, 카페, 호텔 주소 검색',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.easeInOut,
                                    duration: Duration(milliseconds: 100),
                                    reverseDuration: Duration(milliseconds: 100),
                                    type: PageTransitionType.fade,
                                    child: SearchingPage(),
                                    childCurrent: MainScreen_Traveler(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    /*
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 30, 0),
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                     */
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
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
            );
          }),
    );
  }
}
