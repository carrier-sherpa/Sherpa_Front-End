import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sherpa/Traveler/MainScreen_Traveler.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),  상단에 뜨는 창
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  static const rootUrl = "http://localhost:5000/members";
  String email = "";
  String password = "";
  String userInfo = "";

  static final storage = FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> _signupRequest() async {
    email = emailController.text;
    password = passwordController.text;

    final url = Uri.parse("$rootUrl/signup");

    http.Response response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body:
        jsonEncode({
            'email': email,
            'password': password
        })
      ,
    );

    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> _signinRequest() async {
    email = emailController.text;
    password = passwordController.text;

    final url = Uri.parse("$rootUrl/signin");

    http.Response response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body:
      jsonEncode({
        'email': email,
        'password': password
      })
      ,
    );

    if(response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InitialPage()),
                  );
                },
                alignment: Alignment.topLeft,
                iconSize: 40,
                icon: Icon(Icons.navigate_before),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text('로그인',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,
                fontSize: 30.h,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Text('안녕하세요.\n'
                '셰르파입니다.',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700, //bold
                fontSize: 30.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('회원 서비스 이용을 위해 로그인 해주세요.',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '아이디',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '아이디를 입력해주세요';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    //color: Colors.amber,
                    child: Text('아이디 찾기',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("아이디");
                    // 아이디 찾기 기능 추가해야 함.
                  },
                ),
                Container(
                  width: 30.w,
                  alignment: Alignment.center,
                  child: Text('|',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    //color: Colors.amber,
                    child: Text('비밀번호 찾기',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("비번");
                    // 아이디 찾기 기능 추가해야 함.
                  },
                ),
                Container(
                  width: 30.w,
                  alignment: Alignment.center,
                  child: Text('|',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    //color: Colors.amber,
                    child: Text('회원가입',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("회원가입");
                    // 아이디 찾기 기능 추가해야 함.
                  },
                ),
              ],
            ),
            SizedBox(
                height: 120.h
            ),
            Container(
              height: 1.h,
              decoration: BoxDecoration (
                //color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1.0,
                    blurRadius: 1.0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            FloatingActionButton.extended(
              backgroundColor: SherpaColor.sherpa_main,
              onPressed: () async {
                bool response = await _signupRequest();

                if(response){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen_Traveler()),
                  );//로그인 돼서 메인화면으로 넘어가는 기능 추가하는 중
                } else {

                }

                // await storage.write(
                //     key: "login",
                //     value: "id " +
                //         emailController.text.toString() +
                //         " " +
                //         "password " +
                //         passwordController.text.toString());

                // postRequest();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MainScreen_Traveler()),
                // );//로그인 돼서 메인화면으로 넘어가는 기능 추가하는 중
              },
              label: Text('로그인하기',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}