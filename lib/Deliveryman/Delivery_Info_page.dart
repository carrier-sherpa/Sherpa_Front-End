import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/UI/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sherpa/key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Delivery_Info_page extends StatefulWidget {
  String str = '';
  String luggageId = '';
  Delivery_Info_page({
    Key? key,
    required this.str,
    required this.luggageId
  }) : super(key: key);

  @override
  State<Delivery_Info_page> createState() => _Delivery_Info_pageState(luggageId);
}

class _Delivery_Info_pageState extends State<Delivery_Info_page> {
  // static const rootUrl = "http://sherpa-env.eba-ptkbs2zc.ap-northeast-2.elasticbeanstalk.com";

  String startTime = '';
  String endTime = '';
  String startDetails = "";
  String endDetails = "";
  String startAddress = "";
  String goalAddress = "";

  int smallLuggageNum = 0;
  int middleLuggageNum = 0;
  int bigLuggageNum = 0;

  late GoogleMapController _controller;
  String luggageId = '';



  _Delivery_Info_pageState(this.luggageId);

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
                width: 320.w,
                height: 360.h,
                color: Colors.blue,
                child: GoogleMap(
                  mapType: MapType.normal,
                  polylines: Set<Polyline>.of(polylines.values),
                  // 이거 마커 추가 하려면 하면 됨
                  markers: Set.from(markers),
                  myLocationEnabled : true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                      afterBuild();
                    });
                  },
                ),
                //TODO 여기에 출발지 목적지 나오는 지도 화면 넣으면 됩니당
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('출발: ', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.red,
                    ),
                  ),
                  Text(startAddress, //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 15.sp,
                        // color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(startDetails, //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 15.sp,
                        // color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('도착: ', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.blue,
                    ),
                  ),
                  Text(goalAddress, //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 15.sp,
                      // color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text( endDetails, //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 15.sp,
                      // color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('제한시간: ' + '$endTime', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                        fontSize: 20.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('소: ' + '${smallLuggageNum}개', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  Text('중: ' + '${middleLuggageNum}개', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  Text('대: ' + '${bigLuggageNum}개', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('총액: ' + '${smallLuggageNum * 3000 + middleLuggageNum * 4000 + bigLuggageNum * 5000}원', //TODO 12시 대신에 이용객이 설정한 데이터 들어가야합니다.
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      '취소'
                    ),
                    onPressed: (){
                      //TODO travel_energy 감소해야함.
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(20)),
                        primary: SherpaColor.sherpa_red,
                        minimumSize: Size(120.sp, 60.sp),
                        textStyle: TextStyle(fontSize: 24.sp)
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                        '배송하기'
                    ),
                    onPressed: (){
                      acceptLuggage();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Column(
                                children: [
                                  Text("배송을 시작합니다!",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                              content: Container(
                                width: 320.w,
                                height: 120.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "원동연님의 짐을 배송합니다!",   //TODO 깜찍이를 유저 닉네임으로 고쳐야합니다.
                                      style: TextStyle(
                                      fontSize: 20.sp,
                                     ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: Text("확인"),
                                  onPressed: () {

                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    Navigator.pop(context);
                                    // Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                                          borderRadius: BorderRadius.circular(20)),
                                      primary: SherpaColor.sherpa_main,
                                      minimumSize: Size(120.sp, 60.sp),
                                      textStyle: TextStyle(fontSize: 24.sp)
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                            borderRadius: BorderRadius.circular(20)),
                        primary: SherpaColor.sherpa_main,
                        minimumSize: Size(120.sp, 60.sp),
                        textStyle: TextStyle(fontSize: 24.sp)
                    ),
                  ),
                ],
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
      var info = jsonDecode(utf8.decode(response.bodyBytes));

      startTime = info['startTime'];
      endTime = info['endTime'];
      startPlaceLatLng = getLatLng(info['start']);
      goalPlaceLatLng = getLatLng(info['end']);
      _setLuggageInfo(info['luggages']);
      startDetails = info['start_detail'];
      endDetails = info['end_detail'];

      startAddress = await _getCurGeoCodeByLatLng(startPlaceLatLng.latitude, startPlaceLatLng.longitude);

      goalAddress = await _getCurGeoCodeByLatLng(goalPlaceLatLng.latitude, goalPlaceLatLng.longitude);

      drawPolyline();
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

  Future<String> _getCurGeoCodeByLatLng(lat, lng) async {
    final str = 'https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&latlng=${lat},${lng}&key=${Api.KEY}';
    final url = Uri.parse(str);
    String address = "";

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Cookie' : '${Api.JSESSIONID}'

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

}
