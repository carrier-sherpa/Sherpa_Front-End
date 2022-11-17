import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sherpa/UI/Login_Page.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:sherpa/UI/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'provider/luggagesetting_provider.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';
import 'package:sherpa/provider/luggagesetting_provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LuggageSettingProvider>(create: (_) => LuggageSettingProvider()),
          ChangeNotifierProvider<ReservationTimeSettingProvider>(create: (_) => ReservationTimeSettingProvider()),
        ],
      child: MaterialApp(
        title: '셰르파',
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/Sherpa_MainColor.png',
              color: Colors.white
          ),
          splashIconSize: 150,
          nextScreen: InitialPage(),
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Color.fromARGB(255, 161, 196, 253),
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}


class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(384, 854),);
    return Scaffold(
      body: Container(
        //color: SherpaColor.sherpa_main,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              SherpaColor.sherpa_main,
              SherpaColor.sherpa_sub
            ],
            stops: [
              0,
              1,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300.w,
                height: 300.h,
                child: Image.asset('assets/images/Sherpa_MainColor.png', color: Colors.white),
              ),
              SizedBox(
                height: 200.h,
              ),
              GestureDetector(
                child:
                Container(
                  alignment: Alignment.center,
                  width: 240.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
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
                    '셰르파와 함께하기  >',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: SherpaColor.sherpa_main,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => MyLoginPage(title: '로그인 하기'))
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
