import 'package:flutter/material.dart';
import 'package:sherpa/Traveler/LuggageSetting_Page_Small.dart';
import 'package:sherpa/Traveler/LuggageSetting_Page_Mid.dart';
import 'package:sherpa/Traveler/LuggageSetting_Page_Big.dart';
import 'package:sherpa/UI/style.dart';
import 'package:provider/provider.dart';
import 'package:sherpa/provider/luggagesetting_provider.dart';
import 'package:sherpa/Traveler/LuggageSizeTile_Small.dart';
import 'package:sherpa/Traveler/LuggageSizeTile_Mid.dart';
import 'package:sherpa/Traveler/LuggageSizeTile_Big.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLuggageSetting(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('맡기실 짐을 설정해주세요!'),
          content: Container(
            height: 500.h,
            width: 300.w,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: SherpaColor.sherpa_sub,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        LuggageSizeTileSmall(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingSmall(),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: SherpaColor.sherpa_main,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        LuggageSizeTileMid(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingMid(),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: SherpaColor.sherpa_red,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        LuggageSizeTileBig(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingBig(),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: SherpaColor.sherpa_main),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('완료')),
          ],
        );
      });
}
