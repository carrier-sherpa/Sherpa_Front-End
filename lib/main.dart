import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '미소숯불닭갈비',
      home: AnimatedSplashScreen(
        splash: Image.asset('Assets/Image/title.png'),
        nextScreen: MyLoginPage(title: '로그인 화면'),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

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
                  // 뒤로 가서 로그인 메뉴 선택하는 화면으로 넘어가는 기능 구현해야함.
                },
                alignment: Alignment.topLeft,
                iconSize: 30,
                icon: Icon(Icons.navigate_before),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('로그인',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,//
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 0,
              // 셰르파 로고 넣을 에정
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('안녕하세요.\n'
                '셰르파입니다.',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700, //bold
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('회원 서비스 이용을 위해 로그인 해주세요.',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
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
            const SizedBox(
              height: 0,
            ),
            TextFormField(
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
            const SizedBox(
              height: 30,
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
                        fontSize: 10,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("아이디");
                    // 아이디 찾기 기능 추가해야 함.
                  },
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text('|',
                    style: TextStyle(
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
                        fontSize: 10,
                      ),
                    ),
                  ),
                  onTap: () {
                    print("비번");
                    // 아이디 찾기 기능 추가해야 함.
                  },
                ),
                Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text('|',
                    style: TextStyle(
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
                        fontSize: 10,
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
            const SizedBox(
                height: 120
            ),
            Container(
              height: 1,
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
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                //로그인 돼서 메인화면으로 넘어가는 기능 추가하기
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