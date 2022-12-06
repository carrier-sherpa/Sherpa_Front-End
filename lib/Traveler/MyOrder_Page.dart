import 'package:flutter/material.dart';


class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
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
                Text("예약되었습니다")
                // 선택 사항 확인하는 페이지

              ],
            ),
          ),
        ),
      ),
    );
  }
}
