import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LuggageSizeTileSmall extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220.w,
        child: Row(
          children: [
            Icon(Icons.backpack,
            size: 80.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              child: Column(
                children: [
                  Text('소',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  Text('35cm x 55cm (20인치)',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text('(기내용 캐리어 / 백팩)',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
