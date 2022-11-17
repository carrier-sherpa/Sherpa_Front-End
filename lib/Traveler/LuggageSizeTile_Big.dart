import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LuggageSizeTileBig extends StatelessWidget {

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
                  Text('대',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  Text('50cm x 75cm (28인치)',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text('(대형 캐리어 / 골프가방)',
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
