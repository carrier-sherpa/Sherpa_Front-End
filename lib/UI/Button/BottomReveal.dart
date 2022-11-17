import 'package:flutter/material.dart';
import 'package:bottomreveal/bottomreveal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomRevealBtn extends StatefulWidget {
  @override
  _BottomRevealBtnState createState() => _BottomRevealBtnState();
}

class _BottomRevealBtnState extends State<BottomRevealBtn> {
  final BottomRevealController _menuController = BottomRevealController();
  @override
  Widget build(BuildContext context) {
    return BottomReveal(
      openIcon: Icons.add,
      closeIcon: Icons.close,
      revealWidth: 100.w,
      revealHeight: 100.h,
      backColor: Colors.grey.shade900,
      rightContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MaterialButton(
            minWidth: 0,
            child: Icon(Icons.cloud_circle),
            color: Colors.grey.shade200,
            elevation: 0,
            onPressed: () {},
          ),
          MaterialButton(
            minWidth: 0,
            child: Icon(Icons.network_wifi),
            color: Colors.grey.shade200,
            elevation: 0,
            onPressed: () {},
          ),
        ],
      ),
      bottomContent: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
                gapPadding: 8.0,
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(30.0))),
      ),
      controller: _menuController,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (_, index) => Card(
          child: ListTile(
            title: Text("Item $index"),
            leading: Icon(Icons.cloud_circle),
          ),
        ),
      ),
    );
  }
}
