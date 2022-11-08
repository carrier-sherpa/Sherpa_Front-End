import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'LoginScreen.dart';
import 'MainScreen_Traveler.dart';
import 'style.dart';
import 'package:page_transition/page_transition.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, designSize: Size(1440,3200));
    return MaterialApp(
      title: '셰르파',
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/Sherpa_MainColor.png',
            color: Colors.white
        ),
        splashIconSize: 150,
        nextScreen: InitialPage(),
        backgroundColor: Color.fromARGB(255, 161, 196, 253),
        splashTransition: SplashTransition.fadeTransition,
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
