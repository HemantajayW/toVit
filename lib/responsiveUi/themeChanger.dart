import 'package:flutter/material.dart';
import 'package:tovit/enums/viewState.dart';

import 'baseViewModel.dart';

class ThemeChanger extends BaseViewModel {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    setViewState(ViewState.BUSY);

    _themeData = theme;
    setViewState(ViewState.IDLE);
  }
}
