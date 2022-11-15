import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LuggageSizeTileMid extends StatelessWidget {

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
                  Text('중',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  Text('45cm x 65cm (24인치)',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text('(화물용 캐리어 / 등산가방)',
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
