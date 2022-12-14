import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/Login_Page.dart';
import 'package:sherpa/UI/Searching_Page.dart';
import 'package:sherpa/UI/Traveler_Searching_Page.dart';
import 'package:sherpa/UI/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sherpa/key.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:sherpa/provider/luggagesetting_provider.dart';
import 'package:sherpa/Traveler/LuggageSetting_Page_Small.dart';
import 'package:sherpa/Controller/showLuggageSetting.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:sherpa/Deliveryman/MainScreen_Deliveryman.dart';
import 'package:sherpa/Traveler/Luggage_List.dart';

import 'package:bottomreveal/bottomreveal.dart';
import 'package:sherpa/Controller/showReservationTimeSetting.dart';
import 'package:sherpa/UI/Button/BottomReveal.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';
import 'package:sherpa/Traveler/DecideReservationPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'MyOrder_Page.dart';


class MainScreen_Traveler extends StatefulWidget {
  const MainScreen_Traveler({Key? key}) : super(key: key);

  @override
  State<MainScreen_Traveler> createState() => _MainScreen_TravelerState();
}

class _MainScreen_TravelerState extends State<MainScreen_Traveler> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  late GoogleMapController _controller;


  int price_small = 0;
  int price_mid = 0;
  int price_big = 0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5031798, 126.9572013),
    zoom: 14.4746,
  );

  String startPlace = "";
  String goalPlace = "?????????";
  LatLng startPlaceLatLng = new LatLng(0, 0);
  LatLng goalPlaceLatLng = new LatLng(0, 0);

  bool startTerminal = false;

  String orderCafeId = "";

  String startDetails = "";
  String goalDetails = "";

  String startHour = "10";
  String startMin = "00";
  String endHour = "18";
  String endMin = "00";

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) => afterBuild);
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // ?????? ?????? ????????? set
                //backgroundImage: AssetImage('assets/profile.png'), //?????? ????????? ?????? ??????
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[
                // ?????? ?????? ?????????[] set
                CircleAvatar(
                  backgroundColor: Colors.white,
                  //backgroundImage: AssetImage('?????? ???????????????'), //?????? ????????? ?????? ??????
                ),
              ],
              accountName: Text('?????? ?????? ??????'), //???????????? ??????
              accountEmail: Text('?????? ????????? ?????? ??????'), //?????? ????????? ?????? ??????
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
            // Container(
            //   width: double.infinity,
            //   height: double.infinity,
            //   child: GoogleMap(
            //     mapType: MapType.normal,
            //     initialCameraPosition: _kGooglePlex,
            //   ),
            // ),

            SlidingUpPanel(
              //????????? ?????? ??????
              minHeight: 64.sp,
              maxHeight: 760.sp,
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
                        "????????????",
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
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(30.sp, 0, 0, 0),
                                child: Text(
                                  '????????? ?????? ???????????????????',
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
                            height: 16.h,
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
                                    '${startPlace}',
                                    style: TextStyle(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 55.w),
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  //color: Colors.amber,
                                  child: Text(
                                    '${startDetails}',
                                    style: TextStyle(
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
                          SizedBox(
                            height: 10.h,
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
                                    '${goalPlace}',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _navigateAndDisplaySelection(context);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 55.w),
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  //color: Colors.amber,
                                  child: Text(
                                    '${goalDetails}',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _navigateAndDisplaySelection(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(
                            height: 4.h,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          // ??? ?????? ??????, ??????, ????????? ????????? ???????????? Container
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
                                        '???????????? ???',
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
                                            '${Provider.of<LuggageSettingProvider>(context).small_luggage_num * 3000} ???',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '(???) ??? ?????? : ${Provider.of<LuggageSettingProvider>(context).small_luggage_num}',
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
                                            '${Provider.of<LuggageSettingProvider>(context).mid_luggage_num * 4000} ???',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '(???) ??? ?????? : ${Provider.of<LuggageSettingProvider>(context).mid_luggage_num}',
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
                                            '${Provider.of<LuggageSettingProvider>(context).big_luggage_num * 5000} ???',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '(???) ??? ?????? : ${Provider.of<LuggageSettingProvider>(context).big_luggage_num}',
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
                            height: 4.h,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),

                          // ?????? ?????? ??????, ??????, ????????? ????????? ???????????? Container
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
                                        '??????????????? ??????????????????',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                    // ?????? Row ???
                                  ),
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
                                            '????????????:    ' +
                                                Provider.of<ReservationTimeSettingProvider>(context).department_hours.padLeft(2, '0') + '???'
                                                + Provider.of<ReservationTimeSettingProvider>(context).department_mins.padLeft(2, '0') + '???',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Icon(Icons.navigate_next),
                                          onTap: () {
                                            showReservationTimeSetting(context);
                                          },

                                          onLongPress: () {
                                            // startHour = Provider.of<ReservationTimeSettingProvider>(context).department_hours;
                                            // startMin = Provider.of<ReservationTimeSettingProvider>(context).department_mins;
                                            // endHour = Provider.of<ReservationTimeSettingProvider>(context).arrive_hours;
                                            // endMin = Provider.of<ReservationTimeSettingProvider>(context).arrive_mins;
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
                                            '????????????:    ' +
                                                Provider.of<ReservationTimeSettingProvider>(context).arrive_hours.padLeft(2, '0') + '???'
                                                + Provider.of<ReservationTimeSettingProvider>(context).arrive_mins.padLeft(2, '0') + '???',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Icon(Icons.navigate_next),
                                          onTap: () {
                                            showReservationTimeSetting(context);
                                          },
                                          onLongPress: () {
                                            // startHour = Provider.of<ReservationTimeSettingProvider>(context).department_hours;
                                            // startMin = Provider.of<ReservationTimeSettingProvider>(context).department_mins;
                                            // endHour = Provider.of<ReservationTimeSettingProvider>(context).arrive_hours;
                                            // endMin = Provider.of<ReservationTimeSettingProvider>(context).arrive_mins;
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
                                  '??? ??????: ',
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
                                      '????????????',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    int smallNum = Provider.of<LuggageSettingProvider>(context, listen: false).small_luggage_num;
                                    int midNum = Provider.of<LuggageSettingProvider>(context, listen: false).mid_luggage_num;
                                    int bigNum = Provider.of<LuggageSettingProvider>(context, listen: false).big_luggage_num;
                                    startHour = Provider.of<ReservationTimeSettingProvider>(context,listen: false).department_hours;
                                    startMin = Provider.of<ReservationTimeSettingProvider>(context,listen: false).department_mins;
                                    endHour = Provider.of<ReservationTimeSettingProvider>(context,listen: false).arrive_hours;
                                    endMin = Provider.of<ReservationTimeSettingProvider>(context,listen: false).arrive_mins;
                                    createOrder(smallNum, midNum, bigNum);
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     curve: Curves.easeInOut,
                                    //     duration: Duration(milliseconds: 100),
                                    //     reverseDuration:
                                    //     Duration(milliseconds: 100),
                                    //     type: PageTransitionType.fade,
                                    //     child: DecideReservationPage(),
                                    //     childCurrent: MainScreen_Traveler(),
                                    //   ),
                                    // );
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
                        // ?????? ?????? ?????? ????????? ?????? ???
                        polylines: Set<Polyline>.of(polylines.values),
                        markers: Set.from(markers),
                        onMapCreated: (controller) {
                          setState(() {
                            _controller = controller;
                            afterBuild();
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
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) => Luggage_List_Page())
                                        );
                                        // _drawerKey.currentState!.openDrawer();
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10.sp, 0, 0, 0),
                                        child: Text(
                                          '??????, ??????, ?????? ?????? ??????',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        _navigateAndDisplaySelection(context);
                                        // Provider.of<ReservationTimeSettingProvider>(context).department_hours = "00";
                                        // Provider.of<ReservationTimeSettingProvider>(context).department_mins = "00";
                                        // Provider.of<ReservationTimeSettingProvider>(context).arrive_hours = "00";
                                        // Provider.of<ReservationTimeSettingProvider>(context).arrive_mins = "00";
                                        // // Provider.of<LuggageSettingProvider>(context).small_luggage_num;
                                        // Provider.of<LuggageSettingProvider>(context).mid_luggage_num = 0;
                                        // Provider.of<LuggageSettingProvider>(context).big_luggage_num = 0;
                                        //TODO:
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
                                  child: Icon(Icons.directions_walk),
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
                                      child: MainScreen_Deliveryman(),
                                      childCurrent: MainScreen_Traveler(),
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

          ],
        ),
      ),
    );
  }

  void afterBuild() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var gps = await getCurrentLocation();
    LatLng curLatLng = LatLng(gps.latitude, gps.longitude);
    _showCurLocation(curLatLng, gps);
    startPlaceLatLng = curLatLng;
    // executes after build is done
  }

  void _showCurLocation(latLng, gps) async {
    String address = await _getCurGeoCode(gps);
    setState(() {
      startPlace = address;
    });
  }

  Future<bool> _getAllLuggage() async {

    final url = Uri.parse("${Api.ROOTURL}/luggage");

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'

      },
    );

    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  // static const rootUrl = "http://sherpa-env.eba-ptkbs2zc.ap-northeast-2.elasticbeanstalk.com";

  Future<String> _getCurGeoCode(gps) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${gps.latitude},${gps.longitude}&key=${Api.KEY}';
    final url = Uri.parse(str);
    String address = startPlace;

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    print("?????????" + info['results'][0]["formatted_address"]);
    print("placeId" + info['results'][0]['place_id']);

    address = info['results'][0]["formatted_address"];

    if(response.statusCode == 200) {
      return address;
    }
    else {
      return address;
    }
  }
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  // ?????? ?????? ??? ????????? ????????? ?????? ?????? ??????
  final List<Marker> markers = [];

  addMarker(latLng, id) {

    setState(() {
      markers
          .add(Marker(position: latLng, markerId: MarkerId(id.toString()), onTap: () {
            print("????????? ?????????");
      },));
    });
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push??? Future??? ???????????????. Future??? ?????? ?????????
    // Navigator.pop??? ????????? ?????? ????????? ????????????.
    // List<String> result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SearchingPage()),
    // );

    dynamic result = await Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 600),
        reverseDuration: Duration(milliseconds: 600),
        type: PageTransitionType.bottomToTopJoined,
        child: TravelerSearchingPage(startPlace: startPlace, goalPlace: ""),
        childCurrent: MainScreen_Traveler(),
      ),
    );

    startPlaceLatLng = new LatLng(result[1][0][0], result[1][0][1]);
    goalPlaceLatLng = new LatLng(result[1][1][0], result[1][1][1]);
    // startDetails = result[1][1][1];
    // goalDetails = result[1][1][1];

    await checkTerminal(startPlaceLatLng, goalPlaceLatLng);
    
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: goalPlaceLatLng, zoom: 14)
      //17 is new zoom level
    ));

    // addMarker(startPlaceLatLng, "startPlace");
    addMarker(goalPlaceLatLng, "goalPlace");

    setState(() {
      startPlace = result[0][0];
      goalPlace = result[0][1];
      startDetails = result[0][2];
      goalDetails = result[0][3];
    });

    drawPolyline();
    // ?????? ??????????????? ?????? ?????? ?????? ???, ????????? ?????? snackbar??? ????????? ????????? ?????? ??????
    // ???????????????.
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

  createOrder (small, mid, big) async {
    if(isValidOrder(small, mid, big)){

      await sendOrderToServer(small, mid, big);
      completeOrder();
      // showCompletedOrder();
    } else {
      showInvalidOrder();
      // showReportForm();
    }

  }

  bool isValidOrder(small, mid, big) {
    return !(small == 0 && mid == 0 && big == 0);
  }

  void showInvalidOrder() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog??? ????????? ?????? ?????? ?????? x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog ?????? ????????? ????????? ??????
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                Text("?????? 1??? ?????? ??????????????????!"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("??????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void completeOrder() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog??? ????????? ?????? ?????? ?????? x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog ?????? ????????? ????????? ??????
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                Text("????????? ?????? ???????????????."),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("??????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void showCompletedOrder() {
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
  }

  void showMyOrder() {
    Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 100),
        reverseDuration:
        Duration(milliseconds: 100),
        type: PageTransitionType.fade,
        child: MyOrderPage(),
        childCurrent: MainScreen_Traveler(),
      ),
    );
  }

  Future<void> sendOrderToServer(small, mid, big) async {
    String str = '${Api.ROOTURL}/orders';
    final url = Uri.parse(str);

    http.Response response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
      body:
        jsonEncode({
          "start" : {
            "lat" : startPlaceLatLng.latitude,
            "lng" : startPlaceLatLng.longitude
          },
          "end" : {
            "lat" : goalPlaceLatLng.latitude,
            "lng" : goalPlaceLatLng.longitude
          },
          // Provider.of<ReservationTimeSettingProvider>(context).department_hours.padLeft(2, '0') + '???'
          //     + Provider.of<ReservationTimeSettingProvider>(context).department_mins.padLeft(2, '0') + '???',
          // TODO: ?????? ???????????? ?????? ?????? ?????????
          "startTime" : {
            "hour" :  startHour,
            "minute" : startMin
          },
          "endTime" : {
            "hour" :  endHour,
            "minute" : endMin
          },
          // "cafeId" : orderCafeId,
          "start_detail" : startDetails,
          "end_detail" : goalDetails,
          "luggages" : [
            {
              "size" : "SMALL",
              "num" : '$small'
            },
            {
              "size" : "MEDIUM",
              "num" : '$mid'
            },
            {
              "size" : "BIG",
              "num" : '$big'
            }
          ]
        }),
    );
    var info = jsonDecode(response.body);
    if(info["status"] == "ACCEPT"){
      //??????
    }
  }

  checkTerminal(LatLng startPlace, LatLng goalPlace) async {
    final uri = Uri.parse("${Api.ROOTURL}/orders/isAddress").replace(queryParameters: {
      'startLat': '${startPlace.latitude}',
      'startLng': '${startPlace.longitude}',
      'endLat': '${goalPlace.latitude}',
      'endLng': '${goalPlace.longitude}',
    });

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=utf-8',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode == 200) {
      if (response.body == "none") {
        return;
      }
      if(response.body == "start"){
        startTerminal = true;
        addStartMarketMarker(startPlace);
      } else if(response.body == "end"){
        addStartMarketMarker(goalPlace);

        // startTerminal = false;
      }

      return true;
    }
    else {
      return false;
    }
  }

  addStartMarketMarker(latLng) {
    confirmAddMarketMarker();

    addProperMarketMarkers();


  }

  confirmAddMarketMarker() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog??? ????????? ?????? ?????? ?????? x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog ?????? ????????? ????????? ??????
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                Text("????????? ??????????????? \n ????????? ????????? ???????????????????"),
              ],
            ),
            //
            actions: <Widget>[
              new TextButton(
                child: new Text("???"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new TextButton(
                child: new Text("?????????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void addProperMarketMarkers() {
    if (startTerminal) {
      findMarketMarkers(startPlaceLatLng);
    } else {
      findMarketMarkers(goalPlaceLatLng);
    }

    setState(() {
      // markers
      //     .add(Marker(position: latLng, markerId: MarkerId(id.toString()), onTap: () {
        // goalPlace = ""
      // },));
    });
  }

  findMarketMarkers(LatLng latLng) async {
    final uri = Uri.parse("${Api.ROOTURL}/cafe").replace(queryParameters: {
      'lat': '${latLng.latitude}',
      'lng': '${latLng.longitude}',
    });

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode == 200) {
      var info = jsonDecode(utf8.decode(response.bodyBytes));

      info.forEach((cafe) => {
        addMarketMarkers(LatLng(cafe["address"]["lat"], cafe["address"]["lng"]), cafe["id"], cafe["name"])
      });

      return true;
    }
    else {
      return false;
    }
  }

  addMarketMarkers(LatLng latLng, String cafeId, String cafeName) {
    setState(() {
      markers
          .add(Marker(position: latLng, markerId: MarkerId(cafeId.toString()), onTap: () {
            orderCafeId = cafeId.toString();
            if(startTerminal){
              startPlaceLatLng = latLng;
              startPlace = cafeName;
              setState(() {});
              confirmCafeToPlace(cafeName, 4);
            } else {
              goalPlaceLatLng = latLng;
              goalPlace = cafeName;
              setState(() {});
              confirmCafeToPlace(cafeName, 4);
            }
      },));
    });
  }

  confirmCafeToPlace(String cafeName, int restNum) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog??? ????????? ?????? ?????? ?????? x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog ?????? ????????? ????????? ??????
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                Text("$cafeName?????? ???????????? ????????????????"),
              ],
            ),

            content: Text('?????? $restNum??? ??? ?????? ??? ?????????'),

              //
            actions: <Widget>[
              new TextButton(
                child: new Text("???"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new TextButton(
                child: new Text("?????????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
