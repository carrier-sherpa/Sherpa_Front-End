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
                    child: Column(
                      children: [
                        LuggageSizeTileSmall(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingSmall(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    child: Column(
                      children: [
                        LuggageSizeTileMid(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingMid(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    child: Column(
                      children: [
                        LuggageSizeTileBig(),
                        SizedBox(
                          height: 12.h,
                        ),
                        LuggageSettingBig(),
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
