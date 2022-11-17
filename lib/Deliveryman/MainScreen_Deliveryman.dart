import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/Searching_Page.dart';
import 'package:sherpa/UI/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sherpa/key.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sherpa/key.dart';
import 'dart:convert';

class MainScreen_Deliveryman extends StatefulWidget {
  const MainScreen_Deliveryman({Key? key}) : super(key: key);

  @override
  State<MainScreen_Deliveryman> createState() => _MainScreen_DeliverymanState();
}

class _MainScreen_DeliverymanState extends State<MainScreen_Deliveryman> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  static const rootUrl = "http://sherpabackend-env.eba-4pbe4v4v.ap-northeast-2.elasticbeanstalk.com";
  final List<Marker> markers = [];

  int price_small = 12000;
  int price_mid = 10000;
  int price_big = 5000;

  static LatLng startPlaceLatLng = new LatLng(0, 0);
  static LatLng goalPlaceLatLng = new LatLng(0, 0);

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
                  "운송 짐 목록",
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
                            '운송하기로 한 짐 목록',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
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
                              '주변 짐 찾기',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            // showLuggageSetting(context);
                          },
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
                              '짐 1',
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          onTap: () {
                            // _navigateAndDisplaySelection(context);
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     curve: Curves.easeInOut,
                            //     duration: Duration(milliseconds: 600),
                            //     reverseDuration: Duration(milliseconds: 600),
                            //     type: PageTransitionType.bottomToTopJoined,
                            //     child: SearchingPage(),
                            //     childCurrent: MainScreen_Traveler(),
                            //   ),
                            // );
                          },
                        ),
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
                              '운송 취소하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            // showLuggageSetting(context);
                          },
                        ),
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
                              '운송 시작하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            // showLuggageSetting(context);
                          },
                        ),
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
                              '운송 종료하기',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            // showLuggageSetting(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Container(
                    //   height: 1.h,
                    //   width: 350.w,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: FractionalOffset(0.0, 0.0),
                    //       end: FractionalOffset(1.0, 0.0),
                    //       colors: <Color>[
                    //         Color.fromRGBO(161, 196, 253, 100),
                    //         Color.fromRGBO(252, 195, 195, 100),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     SizedBox(width: 20.w),
                    //     Icon(
                    //       Icons.flag,
                    //       color: Color.fromRGBO(252, 119, 119, 100),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     GestureDetector(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         //color: Colors.amber,
                    //         child: Text(
                    //           '어디로 갈까요?',
                    //           style: TextStyle(
                    //             fontSize: 15.sp,
                    //             color: Colors.grey,
                    //           ),
                    //         ),
                    //       ),
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           PageTransition(
                    //             curve: Curves.easeInOut,
                    //             duration: Duration(milliseconds: 600),
                    //             reverseDuration: Duration(milliseconds: 600),
                    //             type: PageTransitionType.bottomToTopJoined,
                    //             child: SearchingPage(),
                    //             childCurrent: MainScreen_Traveler(),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 24.h,
                    // ),
                    // Container(
                    //   height: 10.h,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: FractionalOffset(0.0, 0.0),
                    //       end: FractionalOffset(1.0, 0.0),
                    //       colors: <Color>[
                    //         Color.fromRGBO(161, 196, 253, 100),
                    //         Color.fromRGBO(252, 195, 195, 100),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 20.w,
                    //       ),
                    //       Container(
                    //         child: Row(
                    //           children: [
                    //             Text(
                    //               '총 금액: ',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10.w,
                    //             ),
                    //             Container(
                    //               child: Image.asset('assets/images/won.png',
                    //                 height:20.h,
                    //                 width: 20.w,
                    //                 color: SherpaColor.sherpa_main,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10.w,
                    //             ),
                    //             Text(
                    //               '${Provider.of<LuggageSettingProvider>(context).small_luggage_num * 3000 +
                    //                   Provider.of<LuggageSettingProvider>(context).mid_luggage_num * 4000+
                    //                   Provider.of<LuggageSettingProvider>(context).big_luggage_num * 5000}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 80.w,
                    //       ),
                    //       Text(
                    //         '설정하신 짐',
                    //         style: TextStyle(
                    //           fontSize: 20.sp,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 20.w,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   child: ListView(
                    //     shrinkWrap: true,
                    //     children: [
                    //       Container(
                    //         height: 1.h,
                    //         color: SherpaColor.sherpa_main,
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         width: double.infinity,
                    //         child: Row(
                    //           children: [
                    //             SizedBox(
                    //               width: 20.w,
                    //             ),
                    //             Icon(
                    //               Icons.card_travel,
                    //               size: 50.sp,
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Text(
                    //               '소 갯수: ${Provider.of<LuggageSettingProvider>(context).small_luggage_num}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Container(
                    //               child: Image.asset('assets/images/won.png',
                    //                 height:20.h,
                    //                 width: 20.w,
                    //                 color: SherpaColor.sherpa_main,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 30.w,
                    //             ),
                    //             Text('${Provider.of<LuggageSettingProvider>(context).small_luggage_num * 3000}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         height: 1.h,
                    //         color: SherpaColor.sherpa_main,
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         width: double.infinity,
                    //         child: Row(
                    //           children: [
                    //             SizedBox(
                    //               width: 20.w,
                    //             ),
                    //             Icon(
                    //               Icons.backpack,
                    //               size: 50.sp,
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Text(
                    //               '중 갯수: ${Provider.of<LuggageSettingProvider>(context).mid_luggage_num}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Container(
                    //               child: Image.asset('assets/images/won.png',
                    //                 height:20.h,
                    //                 width: 20.w,
                    //                 color: SherpaColor.sherpa_main,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 30.w,
                    //             ),
                    //             Text('${Provider.of<LuggageSettingProvider>(context).mid_luggage_num * 4000}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         height: 1.h,
                    //         color: SherpaColor.sherpa_main,
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         width: double.infinity,
                    //         child: Row(
                    //           children: [
                    //             SizedBox(
                    //               width: 20.w,
                    //             ),
                    //             Icon(
                    //               Icons.backpack,
                    //               size: 50.sp,
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Text(
                    //               '대 갯수: ${Provider.of<LuggageSettingProvider>(context).big_luggage_num}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 50.w,
                    //             ),
                    //             Container(
                    //               child: Image.asset('assets/images/won.png',
                    //                 height:20.h,
                    //                 width: 20.w,
                    //                 color: SherpaColor.sherpa_main,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 30.w,
                    //             ),
                    //             Text('${Provider.of<LuggageSettingProvider>(context).big_luggage_num * 5000}',
                    //               style: TextStyle(
                    //                 fontSize: 20.sp,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 5.h,
                    //       ),
                    //       Container(
                    //         height: 1.h,
                    //         color: SherpaColor.sherpa_main,
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                  // 이거 마커 추가 하려면 하면 됨
                  markers: Set.from(markers),
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
                                  _navigateAndDisplaySelection(context);
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

  _navigateAndDisplaySelection(BuildContext context) async {
    String startPlace = "출발지";
    String goalPlace = "도착지";

    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    dynamic result = await Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 100),
        reverseDuration:
        Duration(milliseconds: 100),
        type: PageTransitionType.fade,
        child: SearchingPage(startPlace: startPlace, goalPlace: goalPlace),
        childCurrent: MainScreen_Deliveryman(),
      ),
    );

    startPlaceLatLng = new LatLng(result[1][0][0], result[1][0][1]);
    goalPlaceLatLng = new LatLng(result[1][1][0], result[1][1][1]);

    addMarker(startPlaceLatLng, "startPlace");
    addMarker(goalPlaceLatLng, "goalPlace");

    drawPolyline();

    _drawAllLuggage();

    // setState(() {
    //   startPlace = result[0];
    //   goalPlace = result[1];
    // });
    // 선택 창으로부터 결과 값을 받은 후, 이전에 있던 snackbar는 숨기고 새로운 결과 값을
    // 보여줍니다.
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  void drawPolyline () async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Api.KEY,
      PointLatLng(startPlaceLatLng.latitude, startPlaceLatLng.longitude),
      PointLatLng(goalPlaceLatLng.latitude, goalPlaceLatLng.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _drawAllLuggage() async {
    final url = Uri.parse("$rootUrl/orders/distance");
    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
      // body: jsonEncode({
      //   "start" : {
      //     "lat" : startPlaceLatLng.latitude,
      //     "lng" : startPlaceLatLng.longitude
      //   },
      //   "end" : {
      //     "lat" : goalPlaceLatLng.latitude,
      //     "lng" : goalPlaceLatLng.longitude
      //   }
      // })
    );

    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);

      return true;
    }
    else {
      return false;
    }

  }

  addMarker(latLng, id) {

    setState(() {
      markers
          .add(Marker(position: latLng, markerId: MarkerId(id.toString()), onTap: () {
        print("마커가 클릭됨");
      },));
    });
  }

  void afterBuild() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var gps = await getCurrentLocation();
    LatLng curLatLng = LatLng(gps.latitude, gps.longitude);
    _showCurLocation(curLatLng, gps);
    // startPlaceLatLng = curLatLng;
    // executes after build is done
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void _showCurLocation(latLng, gps) async {
    // String address = await _getCurGeoCode(gps);
    // setState(() {
    //   startPlace = address;
    // });

  }

  Future<String> _getCurGeoCode(gps) async {
    // final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${gps.latitude},${gps.longitude}&key=${Api.KEY}';
    // final url = Uri.parse(str);
    // String address = startPlace;
    //
    // http.Response response = await http.get(
    //   url,
    //   headers: <String, String> {
    //     'Content-Type': 'application/json',
    //   },
    // );
    // var info = jsonDecode(response.body);
    // print("주소는" + info['results'][0]["formatted_address"]);
    // print("placeId" + info['results'][0]['place_id']);
    //
    // address = info['results'][0]["formatted_address"];
    //
    // if(response.statusCode == 200) {
    //   return address;
    // }
    // else {
    //   return address;
    // }
    return "";
  }
}
