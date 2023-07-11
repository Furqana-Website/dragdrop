import 'package:flutter/material.dart';

class ScreenUtilClass {
  bool getIsTab(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    if (queryData.size.width > 1200) {
      return true;
    }

    return false;
  }
}
