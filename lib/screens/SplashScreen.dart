import 'dart:async';

import 'package:dragdrop/screens/rememberscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/user_model.dart';
import '../services/api_service.dart';
import '../services/helpers.dart';

class SplashNewScreenUi extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashNewScreenUi>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late GameDataModel  dataModels;

  @override
  void initState() {
    super.initState();
    DataServiceClass().loadDummyData().then((value) {
      setState(() {
        dataModels = value!;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTab = ScreenUtilClass().getIsTab(context);
    // if(isTab) {
    //   Timer(
    //       Duration(seconds: 5),
    //           () =>
    //           Navigator.of(context).pushReplacement(MaterialPageRoute(
    //               builder: (BuildContext context) => RememberTabScreen())));
    // }
    // else{
    try {
      Timer(
          const Duration(seconds: 5),
              () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RememberNewScreen(dataModels,0)
                      )
                  ));
    }
    catch(e)
    {
        print("object");
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/newUi/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SlideTransition(
          position: _animation,
          child: Center(
            child: Image.asset(
              'assets/newUi/splashtext.png',
              width: 500,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }


}
