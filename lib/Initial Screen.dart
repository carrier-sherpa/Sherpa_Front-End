import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '셰르파',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: Colors.blueAccent,
      ),
      home: const InitialPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key, required this.title});

  final String title;

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),  상단에 뜨는 창
      body: InitialForm(),
    );
  }
}

class InitialForm extends StatefulWidget {
  const InitialForm({Key? key}) : super(key: key);

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 180, 0),
            child: Text(
              "떠나봐요",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Helvetica",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(
              "Sherpa",
              style: TextStyle(
                fontSize: 60,
                fontFamily: "Helvetica",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(180, 10, 0, 0),
            child: Text(
              "가벼운 마음으로",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Helvetica",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

