import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';

class ReservationTimeSetting_Layout extends StatefulWidget {
  const ReservationTimeSetting_Layout({Key? key}) : super(key: key);

  @override
  State<ReservationTimeSetting_Layout> createState() => _ReservationTimeSetting_LayoutState();
}

class _ReservationTimeSetting_LayoutState extends State<ReservationTimeSetting_Layout> {


  @override
  Widget build(BuildContext context) {
    return TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle: TextStyle(fontSize: 24.sp, color: SherpaColor.sherpa_red),
      highlightedTextStyle: TextStyle(fontSize: 24.sp, color: SherpaColor.sherpa_main),
      spacing: 32.sp,
      itemHeight: 32.sp,
      isForce2Digits: true,
      minutesInterval: 1,
      onTimeChange: (time) {
        setState(() {
          Provider.of<ReservationTimeSettingProvider>(context, listen: false).department_hours = time.hour.toString();
          Provider.of<ReservationTimeSettingProvider>(context, listen: false).department_mins = time.minute.toString();
        });
      },
    );
  }
}
