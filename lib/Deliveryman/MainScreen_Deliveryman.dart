import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/Deliveryman/Delivery_Info_page.dart';
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
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:bottomreveal/bottomreveal.dart';
import 'package:sherpa/Deliveryman/Delivery_list.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import '../Traveler/Luggage_List.dart';
import '../Traveler/MyOrder_Page.dart';
import 'package:sherpa/key.dart';
import 'package:sherpa/Controller/showReservationTimeSetting.dart';
import 'package:sherpa/Traveler/DecideReservationPage.dart';


class MainScreen_Deliveryman extends StatefulWidget {
  const MainScreen_Deliveryman({Key? key}) : super(key: key);

  @override
  State<MainScreen_Deliveryman> createState() => _MainScreen_DeliverymanState();
}

class _MainScreen_DeliverymanState extends State<MainScreen_Deliveryman> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  late GoogleMapController _controller;


  static const rootUrl = "http://sherpa-env.eba-ptkbs2zc.ap-northeast-2.elasticbeanstalk.com";
  final List<Marker> markers = [];

  int price_small = 12000;
  int price_mid = 10000;
  int price_big = 5000;
  TextEditingController _textController = TextEditingController();
  TextEditingController luggageTextController = TextEditingController();
  TextEditingController _detailDeliveryStartTextController = TextEditingController();
  TextEditingController _detailDeliveryGoalTextController = TextEditingController();

  String userName = '?????????';
  String startPlace = "";
  String goalPlace = "?????????";
  var luggageName = ["???1", "???2", "???3", "???4", "???5", "???6"];
  var luggageId = ["", "", "", "", "", ""];
  var orderVisibility = [false, false, false, false, false, false];
  String detailDeliveryStartAddress = '';
  String detailDeliveryGoalAddress = '';
  LatLng startPlaceLatLng = new LatLng(0, 0);
  LatLng goalPlaceLatLng = new LatLng(0, 0);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5031798, 126.9572013),
    zoom: 14.4746,
  );

  final BottomRevealController _menuController = BottomRevealController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // ?????? ?????? ????????? set
                backgroundImage: AssetImage('assets/images/profile.png'), //?????? ????????? ?????? ??????
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[
                // ?????? ?????? ?????????[] set
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/delivery.png'), //?????? ????????? ?????? ??????
                ),
              ],
              accountName: Text(userName), //???????????? ??????
              accountEmail: Text('wonddang@naver.com'), //?????? ????????? ?????? ??????
              decoration: BoxDecoration(
                  color: SherpaColor.sherpa_main,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
                color: Colors.grey[850],
              ),
              title: Text('?????? ????????? ??? ??????'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Delivery_List_Page())
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('????????? ??????'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('????????? ??????'),
                    content: TextField(
                      controller: _textController,
                      onSubmitted: (text){
                        userName = _textController.text;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              userName = _textController.text;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('?????? ??????')),
                    ],
                  ),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
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
              maxHeight: 360.sp,
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
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(30.sp, 0, 0, 0),
                                child: Text(
                                  '????????? ?????? ??????????',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 48.w,
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
                                    '?????? ??? ??????',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _drawAllLuggage();
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
                                    '${startPlace}',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _navigateAndDisplaySelection(context);
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
                            ],
                          ),

                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('?????? ??????: '),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 36.h,
                                  width: 270.w,
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: TextField(
                                      controller: _detailDeliveryStartTextController,
                                      decoration: InputDecoration(
                                        hintText: '???????????? ?????? ????????? ??????????????????',
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                      onChanged: (text) {
                                        detailDeliveryStartAddress = _detailDeliveryStartTextController.text;
                                        Provider.of<LuggageSettingProvider>(context, listen: false).detailDeliveryStartAddress = detailDeliveryStartAddress;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
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
                            height: 16.h,
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
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('?????? ??????: '),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 36.h,
                                  width: 270.w,
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: TextField(
                                      controller: _detailDeliveryGoalTextController,
                                      decoration: InputDecoration(
                                        hintText: '???????????? ?????? ????????? ??????????????????',
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                      onChanged: (text) {
                                        detailDeliveryGoalAddress = _detailDeliveryGoalTextController.text;
                                        Provider.of<LuggageSettingProvider>(context, listen: false).detailDeliveryGoalAddress = detailDeliveryGoalAddress;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          Container(
                            height: 4.h,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Visibility(
                                  visible: orderVisibility[0],
                                    child: Container(
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
                                          luggageName[0],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '?????? ??????',
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                        trailing: Icon(Icons.navigate_next),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              curve: Curves.easeInOut,
                                              duration: Duration(milliseconds: 100),
                                              reverseDuration:
                                              Duration(milliseconds: 100),
                                              type: PageTransitionType.fade,
                                              child: Delivery_Info_page(str: "??????????????? ?????????", luggageId: luggageId[0]),
                                              childCurrent: MainScreen_Deliveryman(),
                                            ),
                                          );
                                          //showLuggageSetting(context);
                                        },
                                        textColor: Colors.white,
                                        iconColor: Colors.white,
                                      ),
                                    ),
                                ),

                                SizedBox(
                                  height: 8.h,
                                ),
                                Visibility(
                                  visible: orderVisibility[1],
                                    child: Container(
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
                                          luggageName[1],
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '?????? ??????',
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                        trailing: Icon(Icons.navigate_next),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              curve: Curves.easeInOut,
                                              duration: Duration(milliseconds: 100),
                                              reverseDuration:
                                              Duration(milliseconds: 100),
                                              type: PageTransitionType.fade,
                                              child: Delivery_Info_page(str: "??????????????? ?????????", luggageId: luggageId[1]),
                                              childCurrent: MainScreen_Deliveryman(),
                                            ),
                                          );
                                          //showLuggageSetting(context);
                                        },
                                        textColor: Colors.white,
                                        iconColor: Colors.white,
                                      ),
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
                        polylines: Set<Polyline>.of(polylines.values),
                        myLocationEnabled : false,
                        markers: Set.from(markers),
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (controller) {
                          setState(() {
                            _controller = controller;
                            afterBuild();
                          });
                        },
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
                                          '??????, ??????, ?????? ?????? ??????',
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

          ],
        ),
      ),
    );
  }



  _navigateAndDisplaySelection(BuildContext context) async {

    // Navigator.push??? Future??? ???????????????. Future??? ?????? ?????????
    // Navigator.pop??? ????????? ?????? ????????? ????????????.
    dynamic result = await Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 100),
        reverseDuration:
        Duration(milliseconds: 100),
        type: PageTransitionType.fade,
        child: SearchingPage(startPlace: startPlace, goalPlace: "",detailStartAddress: detailDeliveryStartAddress, detailGoalAddress: detailDeliveryGoalAddress,),
        childCurrent: MainScreen_Deliveryman(),
      ),
    );

    startPlaceLatLng = new LatLng(result[1][0][0], result[1][0][1]);
    goalPlaceLatLng = new LatLng(result[1][1][0], result[1][1][1]);

    // addMarker(startPlaceLatLng, "startPlace");
    addMarker(goalPlaceLatLng, "goalPlace");

    drawPolyline();
    // startPlace = result[0];
    // goalPlace = result[1];

    setState(() {
      startPlace = result[0][0];
      goalPlace = result[0][1];
    });
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
  _drawAllLuggage() async {


    final uri = Uri.parse("${Api.ROOTURL}/orders/distance").replace(queryParameters: {
      'startLat': '${startPlaceLatLng.latitude}',
      'startLng': '${startPlaceLatLng.longitude}',
      'endLat': '${goalPlaceLatLng.latitude}',
      'endLng': '${goalPlaceLatLng.longitude}',
    });

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );


    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);

      for(int i = 0; i < info.length; i++) {
        var luggage = info[0];
        luggageId[i] = luggage['orderId'];
        luggageName[i] = "??????????????? ?????????";
        orderVisibility[i] = true;
      }


      // info.forEach((luggage) => {
      //   if(luggage['status'] == "REGISTER"){
      //     addOrderMarker(LatLng(luggage['start']['lat'], luggage['start']['lng']), luggage['orderId'])
      //   }
      // });
      // addMarker(latLng, id)
      setState(() {

      });
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
        print("????????? ?????????");
      },));
    });
  }

  addOrderMarker(latLng, id) {

    setState(() {
      markers.add(
          Marker(
            position: latLng,
            markerId: MarkerId(id.toString()),
            onTap: () async {
              // bool carry = await confirmLuggage(id.toString());
              dynamic luggage = await findOrderById(id.toString());
              await showConfirmLuggage(id.toString(), luggage);
              // if(carry){
              confirmOrder(id.toString());
              // }
            },
          )
      );
    });
  }

  Future<dynamic> findOrderById(id) async {
    final uri = Uri.parse("${Api.ROOTURL}/orders/orderId/$id");
    List<String> luggage = ["",""];

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );


    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);

      String startAddress = await _getCurGeoCodeByLatLng(info['start']['lat'], info['start']['lng']);
      luggage[0] = startAddress;

      String endAddress = await _getCurGeoCodeByLatLng(info['end']['lat'], info['end']['lng']);
      luggage[1] = endAddress;
      // ??????
      // addMarker(latLng, id)
      return luggage;
    }
    else {
      return luggage;
    }
  }

  showConfirmLuggage(id, luggage) async {
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
                Text("??? ?????? ??????????????????????"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("?????????: ${luggage[0]}"),
                Text("?????????: ${luggage[1]}"),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("???"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),new TextButton(
                child: new Text("?????????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  showErrorLuggage() async {
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
                Text("???????????? ???????????? ???????????? ??? ?????????."),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("???"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),new TextButton(
                child: new Text("?????????"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  confirmOrder(id) async {
    final uri = Uri.parse("${Api.ROOTURL}/orders/acceptOrder/$id");

    http.Response response = await http.post(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if (jsonDecode(response.body)["errorCode"] == 4002) {
      showErrorLuggage();
    }


    if(response.statusCode == 200) {
      // ??????
      // var info = jsonDecode(response.body);
      // addMarker(latLng, id)
      return true;
    }
    else {
      return false;
    }
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
    String address = await _getCurGeoCode(gps);
    setState(() {
      startPlace = address;
    });

  }

  Future<String> _getCurGeoCode(gps) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${gps.latitude},${gps.longitude}&key=${Api.KEY}';
    final url = Uri.parse(str);
    String address = startPlace;

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'

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
    // return "";
  }

  Future<String> _getCurGeoCodeByLatLng(lat, lng) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${lat},${lng}&key=${Api.KEY}';
    final url = Uri.parse(str);
    String address = startPlace;

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'

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
    // return "";
  }

}
