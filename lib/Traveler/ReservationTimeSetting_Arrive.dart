import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sherpa/UI/style.dart';
import 'package:sherpa/provider/ReservationTimeSetting_Provider.dart';


class ReservationTimeSetting_Arrive extends StatefulWidget {

  @override
  _ReservationTimeSetting_Arrive createState() => _ReservationTimeSetting_Arrive();
}

class _ReservationTimeSetting_Arrive extends State<ReservationTimeSetting_Arrive> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReservationTimeSettingProvider>(
      create: (_) => ReservationTimeSettingProvider(),
      child: Container(
        padding: EdgeInsets.only(top: 64.sp,bottom: 64.sp),
        child: new Column(
          children: <Widget>[
            hourMinute12HCustomStyle(),
            new Container(
              margin: EdgeInsets.all(24.sp),
              child: Column(
                children: [
                  Text('출발시간:    ' +
                      Provider.of<ReservationTimeSettingProvider>(context).department_hours.toString().padLeft(2, '0') + ':'
                      + Provider.of<ReservationTimeSettingProvider>(context).department_mins.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.normal),
                  ),

                  Text('도착시간:    ' +
                      Provider.of<ReservationTimeSettingProvider>(context).arrive_hours.padLeft(2, '0') + ':'
                      + Provider.of<ReservationTimeSettingProvider>(context).arrive_mins.padLeft(2, '0'),
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget hourMinute12HCustomStyle() {
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
          _dateTime = time;
          Provider.of<ReservationTimeSettingProvider>(context, listen: false).arrive_hours = time.hour.toString();
          Provider.of<ReservationTimeSettingProvider>(context, listen: false).arrive_mins = time.minute.toString();
        });
      },
    );
  }
}
