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
import 'package:sherpa/Deliveryman/MainScreen_Deliveryman.dart';

import 'package:bottomreveal/bottomreveal.dart';
import 'package:sherpa/Controller/showReservationTimeSetting.dart';
import 'package:sherpa/UI/Button/BottomReveal.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';
import 'package:sherpa/Traveler/DecideReservationPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MainScreen_Traveler extends StatefulWidget {
  const MainScreen_Traveler({Key? key}) : super(key: key);

  @override
  State<MainScreen_Traveler> createState() => _MainScreen_TravelerState();
}

class _MainScreen_TravelerState extends State<MainScreen_Traveler> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  late GoogleMapController _controller;

  final BottomRevealController _menuController = BottomRevealController();

  int price_small = 0;
  int price_mid = 0;
  int price_big = 0;

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
        maxHeight: 720.sp,
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
                // 이게 내가 추가한 부분(호ㅏ면이 깨져서 주석 처리)
                // FloatingActionButton(
                //   onPressed: () async {
                //     LocationPermission permission = await Geolocator.requestPermission();
                //     var gps = await getCurrentLocation();
                //     var temp = await _getAllLuggage();
                //     var value = await _getCurGeoCode(gps);
                //     // addMarker(LatLng(gps.latitude, gps.longitude));
                //     _controller.animateCamera(
                //         CameraUpdate.newLatLng(LatLng(gps.latitude, gps.longitude)));
                //
                //   },
                //   child: Icon(
                //     Icons.my_location,
                //     color: Colors.black,
                //   ),
                //   backgroundColor: Colors.white,
                // ),
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
                  "예약하기",
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
                      height: 16.h,
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
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
                      height: 24.h,
                    ),
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    // 짐 설정 버튼, 문구, 선택된 화면을 포함하는 Container
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '설정하신 짐',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 160.w,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: SherpaColor.sherpa_sub,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.card_travel,
                                      size: 40.sp,
                                    ),
                                    title: Text(
                                      '${Provider.of<LuggageSettingProvider>(context).small_luggage_num * 3000} 원',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '(소) 짐 갯수 : ${Provider.of<LuggageSettingProvider>(context).small_luggage_num}',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      showLuggageSetting(context);
                                    },
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ),
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
                                      '${Provider.of<LuggageSettingProvider>(context).mid_luggage_num * 4000} 원',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '(중) 짐 갯수 : ${Provider.of<LuggageSettingProvider>(context).mid_luggage_num}',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      showLuggageSetting(context);
                                    },
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: SherpaColor.sherpa_red,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.card_travel,
                                      size: 40.sp,
                                    ),
                                    title: Text(
                                      '${Provider.of<LuggageSettingProvider>(context).big_luggage_num * 5000} 원',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '(대) 짐 갯수 : ${Provider.of<LuggageSettingProvider>(context).big_luggage_num}',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      showLuggageSetting(context);
                                    },
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 10.h,
                      width: double.infinity,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    // 시간 설정 버튼, 문구, 선택된 화면을 포함하는 Container
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  '예약시간을 설정해주세요',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              // 문구 Row 끝
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: SherpaColor.sherpa_sub,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.directions_walk,
                                      size: 32.sp,
                                    ),
                                    title: Text(
                                      '출발시간:    ' +
                                          Provider.of<ReservationTimeSettingProvider>(context).department_hours.padLeft(2, '0') + '시'
                                          + Provider.of<ReservationTimeSettingProvider>(context).department_mins.padLeft(2, '0') + '분',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      showReservationTimeSetting(context);
                                    },
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: SherpaColor.sherpa_red,
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.flag,
                                      size: 32.sp,
                                    ),
                                    title: Text(
                                      '도착시간:    ' +
                                          Provider.of<ReservationTimeSettingProvider>(context).arrive_hours.padLeft(2, '0') + '시'
                                          + Provider.of<ReservationTimeSettingProvider>(context).arrive_mins.padLeft(2, '0') + '분',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      showReservationTimeSetting(context);
                                    },
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 12.h,
                    ),

                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 16.w,),
                          Text(
                            '총 금액: ',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/images/won.png',
                              height: 20.h,
                              width: 20.w,
                              color: SherpaColor.sherpa_main,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '${Provider.of<LuggageSettingProvider>(context).small_luggage_num * 3000 + Provider.of<LuggageSettingProvider>(context).mid_luggage_num * 4000 + Provider.of<LuggageSettingProvider>(context).big_luggage_num * 5000}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            width: 80.w,
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
                                '예약하기',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: 100),
                                  reverseDuration:
                                  Duration(milliseconds: 100),
                                  type: PageTransitionType.fade,
                                  child: DecideReservationPage(),
                                  childCurrent: MainScreen_Traveler(),
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
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
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
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
                                  padding: EdgeInsets.fromLTRB(10.sp, 0, 0, 0),
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
                                      reverseDuration:
                                          Duration(milliseconds: 100),
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
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50.sp, 0, 0),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          color: Colors.red,
                          child: Scaffold(
                            body: BottomRevealBtn(),
                          ),
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
  Future<bool> _getAllLuggage() async {

    final url = Uri.parse("$rootUrl/luggage");

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  static const rootUrl = "http://sherpabackend-env.eba-4pbe4v4v.ap-northeast-2.elasticbeanstalk.com";

  Future<bool> _getCurGeoCode(gps) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${gps.latitude},${gps.longitude}&key=AIzaSyCrMf2ZtsjCreWP2F_wg-i-7dqJJUIjxgc';
    final url = Uri.parse(str);

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var json = jsonDecode(response.body);
    print("주소는" + jsonDecode(response.body)['results'][0]["formatted_address"]);
    print("placeId" + jsonDecode(response.body)['results'][0]['place_id']);
    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  addMarker(latLng) {
    int id = 1;

    setState(() {
      markers
          .add(Marker(position: latLng, markerId: MarkerId(id.toString())));
    });
  }
}
