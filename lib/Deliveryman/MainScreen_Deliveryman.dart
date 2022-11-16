import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/Login_Page.dart';
import 'package:sherpa/UI/Searching_Page.dart';
import 'package:sherpa/UI/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:sherpa/provider/luggagesetting_provider.dart';
import 'package:sherpa/Traveler/LuggageSetting_Page_Small.dart';
import 'package:sherpa/Controller/showLuggageSetting.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';


class MainScreen_Deliveryman extends StatefulWidget {
  const MainScreen_Deliveryman({Key? key}) : super(key: key);

  @override
  State<MainScreen_Deliveryman> createState() => _MainScreen_DeliverymanState();
}

class _MainScreen_DeliverymanState extends State<MainScreen_Deliveryman> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  int price_small = 12000;
  int price_mid = 10000;
  int price_big = 5000;


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5031798, 126.9572013),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
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
      body: SlidingUpPanel(
        //여행객 설정 화면
        minHeight: 64.sp,
        maxHeight: 480.sp,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        collapsed: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                SherpaColor.sherpa_main,
                SherpaColor.sherpa_sub,
              ],
              stops: [
                0,
                1,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  width: 64.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "목적지와 짐 설정하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        panel: Column(
          children: [
            Container(
              width: double.infinity,
              child: Center(

              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled : true,
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
                          width: 300.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(12),
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

                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: GestureDetector(
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: SherpaColor.sherpa_main,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.run_circle_outlined),
                          ),
                          onTap: (){

                            Navigator.push(
                              context,
                              PageTransition(
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 100),
                                reverseDuration:
                                Duration(milliseconds: 100),
                                type: PageTransitionType.fade,
                                child: MainScreen_Traveler(),
                                childCurrent: MainScreen_Deliveryman(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
