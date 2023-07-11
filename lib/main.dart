import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/SplashScreen.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();

    SystemChrome.setPreferredOrientations([
      Platform.isAndroid
          ? DeviceOrientation.landscapeLeft
          : DeviceOrientation.landscapeRight
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashNewScreenUi(),
      ),
    );

}
