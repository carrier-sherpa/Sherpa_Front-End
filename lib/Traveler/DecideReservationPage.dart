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


class DecideReservationPage extends StatefulWidget {
  const DecideReservationPage({Key? key}) : super(key: key);

  @override
  State<DecideReservationPage> createState() => _DecideReservationPageState();
}

class _DecideReservationPageState extends State<DecideReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('예약 정보 확인 부탁드려요',
          style: TextStyle(
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              children: [

                // 선택 사항 확인하는 페이지

              ],
            ),
          ),
        ),
      ),
    );
  }
}
