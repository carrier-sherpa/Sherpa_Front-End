import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sherpa/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order_Info_page extends StatefulWidget {
  String str = '';
  String luggageId = '';
  Order_Info_page({
    Key? key,
    required this.str,
    required this.luggageId
  }) : super(key: key);

  @override
  State<Order_Info_page> createState() => _Order_Info_pageState(luggageId);
}

class _Order_Info_pageState extends State<Order_Info_page> {
  // static const rootUrl = "http://sherpa-env.eba-ptkbs2zc.ap-northeast-2.elasticbeanstalk.com";

  String startTime = '';
  String endTime = '';

  late GoogleMapController _controller;
  String luggageId = '';

  int smallLuggageNum = 0;
  int middleLuggageNum = 0;
  int bigLuggageNum = 0;
  String startPlace = "";
  String goalPlace = "";

  _Order_Info_pageState(this.luggageId);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5031798, 126.9572013),
    zoom: 14.4746,
  );

  final List<Marker> markers = [];


  @override
  void initState() {
    super.initState();
    _setOrderInfo();
  }

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
                                '${startPlace}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                            onTap: () {
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
                                '${goalPlace}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onTap: () {
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
                                        '${smallLuggageNum * 3000} 원',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '(소) 짐 갯수 : ${smallLuggageNum}',
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: () {
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
                                        '${middleLuggageNum * 4000} 원',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '(중) 짐 갯수 : ${middleLuggageNum}',
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: () {
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
                                        '${bigLuggageNum * 5000} 원',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '(대) 짐 갯수 : ${bigLuggageNum}',
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: () {
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
                              height: 4.h,
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
                                        '출발시간:    ${startTime}',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: () {
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
                                        '도착시간:    ${endTime}',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                      onTap: () {
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
                              '${smallLuggageNum * 3000 + middleLuggageNum * 4000 + bigLuggageNum * 5000}',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              width: 50.w,
                            ),

                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 90.w,
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
                                  '신고하기',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                showReportForm();
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
        ),
      ),
    );
  }

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  LatLng startPlaceLatLng = new LatLng(0, 0);
  LatLng goalPlaceLatLng = new LatLng(0, 0);

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

  _setOrderInfo() async {


    final uri = Uri.parse("${Api.ROOTURL}/orders/orderId/$luggageId");

    http.Response response = await http.get(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode == 200) {
      var info = jsonDecode(response.body);

      startTime = info['startTime'];
      endTime = info['endTime'];
      startPlaceLatLng = getLatLng(info['start']);
      goalPlaceLatLng = getLatLng(info['end']);
      _setLuggageInfo(info['luggages']);
      drawPolyline();

      dynamic luggage = await findOrderById(luggageId);
      startPlace = luggage[0];
      goalPlace = luggage[1];
      addMarker(startPlaceLatLng, "startPlace", true);
      addMarker(goalPlaceLatLng, "goalPlace", false);

      setState(() {

      });
      // addMarker(latLng, id)
      return true;
    }
    else {
      return false;
    }
  }

  LatLng getLatLng(latLng) {
    return new LatLng(latLng['lat'], latLng['lng']);
  }

  _setLuggageInfo(dynamic luggages) {
    luggages.forEach((luggage) {
      if(luggage['size'] == 'BIG'){
        bigLuggageNum = luggage['number'];
      } else if(luggage['size'] == 'MEDIUM'){
        middleLuggageNum = luggage['number'];
      } else {
        smallLuggageNum = luggage['number'];
      }
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
      // 성공
      // addMarker(latLng, id)
      return luggage;
    }
    else {
      return luggage;
    }
  }

  Future<String> _getCurGeoCodeByLatLng(lat, lng) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${lat},${lng}&key=${Api.KEY}';
    final url = Uri.parse(str);
    String address = startPlace;

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    print("주소는" + info['results'][0]["formatted_address"]);
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

  void afterBuild() async {
    // var gps;
    // LatLng curLatLng = LatLng(gps.latitude, gps.longitude);
    // _showCurLocation(curLatLng, gps);
    // // startPlaceLatLng = curLatLng;
    // // executes after build is done
  }
//
  // void _showCurLocation(latLng, gps) async {
  //   String address = await _getCurGeoCode(gps);
  //   setState(() {
  //     startPlace = address;
  //   });
  //
  // }

  addMarker(latLng, id, start) {

    setState(() {
      markers.add(
          Marker(
            position: latLng,
            markerId: MarkerId(id.toString()),
            onTap: () {
              print("마커가 클릭됨");
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(
                (start) ? BitmapDescriptor.hueRed : BitmapDescriptor.hueBlue
            ),
          ));
    });
  }

  acceptLuggage() async {
    final uri = Uri.parse("${Api.ROOTURL}/orders/acceptOrder/$luggageId");

    http.Response response = await http.post(
      uri,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'
      },
    );

    if(response.statusCode != 200) {
      print('짐 수락 실패..');
    }
  }

  void showReportForm() {
    final List<String> _valueList = ['신고타입', '도난', '분실'];
    String? _selectedValue = '신고타입';

    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                Text("신고"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton(
                    isExpanded: true,
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    }
                ),
                const SizedBox(
                  height: 200,
                  child: TextField(
                    maxLines: 5,
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("신고하기"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new TextButton(
                child: new Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
