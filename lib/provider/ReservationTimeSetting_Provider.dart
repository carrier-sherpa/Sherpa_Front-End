import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class ReservationTimeSettingProvider with ChangeNotifier{

  String department_hours = '';
  String get _department_hours => _department_hours;

  String department_mins = '';
  String get _department_mins => _department_mins;

  String department_ampm = '';
  String get _department_ampm => _department_ampm;


  String arrive_hours = '';
  String get _arrive_hours => _arrive_hours;

  String arrive_mins = '';
  String get _arrive_mins => _arrive_mins;

  void updateTime(){
    notifyListeners();
  }

}