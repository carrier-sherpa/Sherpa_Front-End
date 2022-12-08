import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sherpa/UI/Login_Page.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sherpa/UI/style.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sherpa/key.dart';


class TravelerSearchingPage extends StatefulWidget {
  const TravelerSearchingPage({Key? key, required this.startPlace, required this. goalPlace}) : super(key: key);
  final startPlace;
  final goalPlace;

  @override
  State<TravelerSearchingPage> createState() => _TravelerSearchingPageState();
}

class _TravelerSearchingPageState extends State<TravelerSearchingPage> {
  List<String> listTexts = ["","","","",""];
  List<String> placeIdTexts = ["","","","",""];
  List<String> places = ["","", "", ""];
  List<String> placeIds = ["",""];
  String startPlaceId = "";
  String goalPlaceId = "";
  bool curStartInput = true;

  TextEditingController startTextController = TextEditingController();
  TextEditingController goalTextController = TextEditingController();

  TextEditingController startDetailsController = TextEditingController();
  TextEditingController goalDetailsController = TextEditingController();

  void initText() {
    // setState(() {
    startTextController.text = widget.startPlace;
    goalTextController.text = widget.goalPlace;
    // });
  }

  @override
  void initState() {
    super.initState();
    initText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400.h,
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
                                  color: Colors.white,
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

                          onTap: () async {
                            places[0] = startTextController.text.toString();
                            places[1] = goalTextController.text.toString();
                            places[2] = startDetailsController.text.toString();
                            places[3] = goalDetailsController.text.toString();

                            dynamic placeInfo = [places, await getPlaceLatLng(placeIds)];
                            Navigator.pop(context, placeInfo);
                          },
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
                          height: 30.h,
                          width: 300.w,
                          alignment: Alignment.center,

                          //color: Colors.amber,
                          child: Flexible(
                            child: TextField(
                              controller: startTextController,
                              decoration: InputDecoration(
                                hintText: '출발지',
                              ),
                              // '현위치: 근처 가게명 가져오기',
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                              onChanged: (input) {
                                // curStartInput = true;
                                _getAutocompletePlaces(startTextController.text.toString());
                              },

                              onTap: (){
                                curStartInput = true;
                              },

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 55.w),
                      GestureDetector(
                        child: Container(
                          height: 30.h,
                          width: 300.w,
                          alignment: Alignment.center,

                          //color: Colors.amber,
                          child: Flexible(
                            child: TextField(
                              controller: startDetailsController,
                              decoration: InputDecoration(
                                hintText: '상세주소',
                              ),
                              // '현위치: 근처 가게명 가져오기',
                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                              onChanged: (input) {
                                // curStartInput = true;
                                // _getAutocompletePlaces(startTextController.text.toString());
                              },

                              onTap: (){
                                curStartInput = true;
                              },

                            ),
                          ),
                        ),
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
                            height: 30.h,
                            width: 300.w,
                            alignment: Alignment.center,
                            //color: Colors.amber,
                            child: Flexible(
                              child: TextField(
                                controller: goalTextController,
                                decoration: InputDecoration(
                                  hintText: '목적지',
                                ),
                                onChanged: (input) {
                                  _getAutocompletePlaces(input);
                                  // goalTextController.text();
                                },
                                onTap: () {
                                  curStartInput = false;
                                },
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      SizedBox(width: 55.w),

                      GestureDetector(
                        child: Container(
                            height: 30.h,
                            width: 300.w,
                            alignment: Alignment.center,
                            //color: Colors.amber,
                            child: Flexible(
                              child: TextField(
                                controller: goalDetailsController,
                                decoration: InputDecoration(
                                  hintText: '상세주소',
                                ),
                                onChanged: (input) {
                                  // _getAutocompletePlaces(input);
                                  // goalTextController.text();
                                },
                                onTap: () {
                                  curStartInput = false;
                                },
                              ),
                            )
                        ),
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
          GestureDetector(
              child: SizedBox(
                height: 200,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                          child: new GestureDetector(
                            onTap: () {
                              changeLocation(listTexts[0], placeIdTexts[0]);
                            },
                            child: new Text('${listTexts[0]}'),
                          )
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                          child: new GestureDetector(
                            onTap: () {
                              changeLocation(listTexts[1], placeIdTexts[1]);
                            },
                            child: new Text('${listTexts[1]}'),
                          )
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                          child: new GestureDetector(
                            onTap: () {
                              changeLocation(listTexts[2], placeIdTexts[2]);
                            },
                            child: new Text('${listTexts[2]}'),
                          )
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                          child: new GestureDetector(
                            onTap: () {
                              changeLocation(listTexts[3], placeIdTexts[3]);
                            },
                            child: new Text('${listTexts[3]}'),
                          )
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                          child: new GestureDetector(
                            onTap: () {
                              changeLocation(listTexts[4], placeIdTexts[4]);
                            },
                            child: new Text('${listTexts[4]}'),
                          )
                      ),
                    ),
                  ],

                ),
              )

          ),
        ],
      ),

    );
  }

  void _findPlaceByText(text) async {
    final str = 'https://maps.googleapis.com/maps/api/place/textsearch/json?input=${text}&language=ko&key=${Api.KEY}';
    final url = Uri.parse(str);
    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    changeAutocompleteText(info);
    return;
  }

  Future<bool> _getAutocompletePlaces(input) async {
    final str = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&region=kr&language=ko&key=${Api.KEY}';
    final url = Uri.parse(str);

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    changeAutocompleteText(info);
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

  void changeAutocompleteText(info){
    setState(() {
      listTexts[0] = info['predictions'][0]['structured_formatting']['main_text'];
      placeIdTexts[0] = info['predictions'][0]["place_id"];
      listTexts[1] = info['predictions'][1]['structured_formatting']['main_text'];
      placeIdTexts[1] = info['predictions'][0]["place_id"];
      listTexts[2] = info['predictions'][2]['structured_formatting']['main_text'];
      placeIdTexts[2] = info['predictions'][0]["place_id"];
      listTexts[3] = info['predictions'][3]['structured_formatting']['main_text'];
      placeIdTexts[3] = info['predictions'][0]["place_id"];
      listTexts[4] = info['predictions'][4]['structured_formatting']['main_text'];
      placeIdTexts[4] = info['predictions'][0]["place_id"];
    });
  }

  void changeLocation(clickedLocation, clickedPlaceId) {
    setState(() {
      if (curStartInput){
        startTextController.text = clickedLocation;
        startPlaceId = clickedPlaceId;
      } else {
        goalTextController.text = clickedLocation;
        goalPlaceId = clickedPlaceId;
      }
    });
  }

  Future<dynamic> getPlaceLatLng(placeIds) async {
    dynamic placesLatLng = [await getPlaceLocation(0), await getPlaceLocation(1)];
    return placesLatLng;
  }

  Future<List<double>> getPlaceLocation(placeNum) async {
    if(placeNum == 0){
      return await getPlaceLocationByText(startTextController.text.toString());
    } else{
      return await getPlaceLocationByText(goalTextController.text.toString());
    }
    // if(placeIds[placeNum] == "") {
    //   if(placeNum == 0){
    //     return await getPlaceLocationByText(startTextController.text.toString());
    //   } else{
    //     return await getPlaceLocationByText(goalTextController.text.toString());
    //   }
    // } else {
    //   return await getPlaceLocationById(placeIds[placeNum]);
    // }
  }

  Future<List<double>> getPlaceLocationByText(placeText) async {
    final str = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$placeText&key=${Api.KEY}";
    final url = Uri.parse(str);

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    double lat = info["results"][0]["geometry"]["location"]["lat"];
    double lng = info["results"][0]["geometry"]["location"]["lng"];

    List<double> locationsInfo = [lat, lng];

    return locationsInfo;
  }

  Future<List<double>> getPlaceLocationById(placeId) async {
    final str = "https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&fields=geometry&key=${Api.KEY}";
    final url = Uri.parse(str);

    http.Response response = await http.get(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
    );
    var info = jsonDecode(response.body);
    double lat = info["result"]["geometry"]["location"]["lat"];
    double lng = info["result"]["geometry"]["location"]["lng"];

    List<double> locationsInfo = [lat, lng];

    return locationsInfo;
  }

}