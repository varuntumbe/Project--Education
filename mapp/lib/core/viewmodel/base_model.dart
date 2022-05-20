import 'package:flutter/material.dart';
import '../enums.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    print(_state);
    notifyListeners();
  }
}
