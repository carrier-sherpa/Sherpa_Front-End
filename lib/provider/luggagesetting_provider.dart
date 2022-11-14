import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LuggageSettingProvider with ChangeNotifier{
  int _small_luggage_num=0;
  int get small_luggage_num => _small_luggage_num;

  int _mid_luggage_num=0;
  int get mid_luggage_num => _mid_luggage_num;

  int _big_luggage_num=0;
  int get big_luggage_num => _big_luggage_num;


  String _luggage_size = '소';
  String get luggage_size => _luggage_size;

  void small_increment() {
    _small_luggage_num++;
    notifyListeners();
  }

  void small_decrement() {
    _small_luggage_num--;
    notifyListeners();
  }

  void mid_increment() {
    _mid_luggage_num++;
    notifyListeners();
  }

  void mid_decrement() {
    _mid_luggage_num--;
    notifyListeners();
  }

  void big_increment() {
    _big_luggage_num++;
    notifyListeners();
  }

  void big_decrement() {
    _big_luggage_num--;
    notifyListeners();
  }

}