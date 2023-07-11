import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dragdrop/screens/rememberscreen.dart';
import 'package:dragdrop/model/user_model.dart';
import 'package:dragdrop/services/helpers.dart';
import '../model/memoryGame.dart';
import '../services/api_service.dart';
import 'exit_dialog.dart';

class TimeUpScreen extends StatefulWidget {
  final GameDataModel dataList;

  int currentIndex;
  TimeUpScreen( {
  required this.currentIndex,required this.dataList});
  @override
  State<StatefulWidget> createState() => MyApp(currentIndex:currentIndex,dataList:dataList);
}

class MyApp extends State<TimeUpScreen> with WidgetsBindingObserver{
  late  GameDataModel dataList;

  int currentIndex;
  MyApp({required this.currentIndex, required this.dataList});


  @override
  void initState() {
    super.initState();
    print("TimeUp Init");

  }

  @override
  Widget build(BuildContext context) {
    print("Cirrent $currentIndex");
   int currentdata=currentIndex;
    if(currentIndex>=dataList.data!.length-1)
    {
      currentdata=0;
    }
    else{
      currentdata++;
    }
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) =>
                RememberNewScreen(dataList,currentdata))));
    bool isTab = ScreenUtilClass().getIsTab(context);
    ThemeData themeData = Theme.of(context);
    List<int> correctIndices = dataList.data![currentIndex].correctAnswer!.split(',').map((index) => int.parse(index.trim())).toList();



    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
              context: context,
              builder: (context) => exitDialog());

        },
      child: Scaffold(
        backgroundColor: Color(0xFF6555C0),

        body: SafeArea(
          child: Container(
            padding: isTab ? const EdgeInsets.only(
                left: 0, right: 0, top: 0, bottom: 0) : const EdgeInsets.only(
                left: 10, right: 20, top: 30, bottom: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: false,
                      child: Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Image.asset(
                            'assets/newUi/CancelButton.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    isTab ? const SizedBox(width: 50,) : const SizedBox(
                      width: 150,),
                    Expanded(
                      flex: 6,
                      child: Container(
                        //Media Query
                        width: isTab ? 700 : 50,
                        height: isTab ? 80 : 50,
                        alignment: Alignment.center,
                        margin: isTab
                            ? const EdgeInsets.only(top: 140)
                            : const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF7F6AF6),
                          borderRadius: BorderRadius.all(Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'You correct answer is ',
                          textAlign: TextAlign.center,
                            style:TextStyle(
                                fontFamily: 'Grandstander',
                                fontSize:isTab?30:20,
                                fontWeight:FontWeight.w800,
                                color: Colors.white)
                        )
                      ),
                    ),
                    isTab ? const SizedBox(width: 50,) : const SizedBox(
                      width: 150,),
                    Visibility(
                      visible: false,
                      child: Expanded(
                          flex: 1,
                          child: Container(
                            width: isTab ? 100 : 65,
                            height: isTab ? 50 : 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7F6AF6),
                              borderRadius: BorderRadius.all(Radius.circular(40),
                              ),
                            ),
                            child: isTab ? const Center(
                              child: Text(
                                '01/10',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Grandstander',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ) :
                            const Center(
                              child: Text(
                                '01/10',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Grandstander',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dataList.data![currentIndex].correctAnswer!.split(",").length,
                      padding: isTab
                          ? const EdgeInsets.only(bottom: 300)
                          : const EdgeInsets.only(top: 50.0),
                      itemBuilder: (BuildContext context, int index) {
                        int imageIndex = correctIndices[index] - 1;
                        print("imageIndex $imageIndex");

                        Options imageUrls=dataList.data![currentIndex].options![imageIndex];
                        return Container(

                          margin: isTab ? const EdgeInsets.only(
                              left: 30, right: 30, top: 0) : const EdgeInsets
                              .only(left: 20, right: 20, top: 0),
                          alignment: Alignment.center,
                          width: isTab ? 200 : 121.0,
                          height: isTab ? 200 : 121.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/newUi/innerimage.png'),
                                fit: BoxFit.fitWidth
                            ),
                          ),
                          child: Container(
                            padding: isTab
                                ? const EdgeInsets.all(60)
                                : EdgeInsets.all(20),
                            child: Center(
                              child: Image.asset(
                                  imageUrls.image.toString(),
                                width: 150,
                                height: 110,
                                  fit: BoxFit.fitWidth
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

