import 'package:flutter/material.dart';
import 'package:sherpa/Traveler/LuggageNumTile.dart';
import 'package:sherpa/Traveler/LuggageSizeTile_Small.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sherpa/provider/luggagesetting_provider.dart';
import 'package:provider/provider.dart';


class LuggageSettingBig extends StatefulWidget {
  const LuggageSettingBig({Key? key}) : super(key: key);


  @override
  State<LuggageSettingBig> createState() => _LuggageSettingBigState();
}

class _LuggageSettingBigState extends State<LuggageSettingBig> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LuggageSettingProvider>(
      create: (_) => LuggageSettingProvider(),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        Provider.of<LuggageSettingProvider>(context, listen: false).big_decrement();
                        print('짐 갯수: ${Provider.of<LuggageSettingProvider>(context).big_luggage_num}');
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Text(
                  '${Provider.of<LuggageSettingProvider>(context).big_luggage_num}',
                  style: TextStyle(fontSize: 30.sp),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Container(
                  width: 40.w,
                  height: 40.h,
                  child: FittedBox(
                    child:FloatingActionButton(
                      onPressed: () {
                        Provider.of<LuggageSettingProvider>(context, listen: false).big_increment();
                        print('짐 갯수: ${Provider.of<LuggageSettingProvider>(context).big_luggage_num}');
                      },
                      child: new Icon(Icons.add, color: Colors.black,),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            /*
            Expanded(
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 0.5,
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 10,
                    builder: (context, index) {
                      return LuggageNumTile(
                        luggage_num: index + 1,
                      );
                    }),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}
