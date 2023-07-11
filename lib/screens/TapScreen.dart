import 'dart:async';
import 'package:dragdrop/model/user_model.dart';
import 'package:dragdrop/screens/TimeUpNew.dart';
import 'package:dragdrop/screens/WinScreen.dart';
import 'package:dragdrop/screens/exit_dialog.dart';
import 'package:dragdrop/screens/rememberscreen.dart';
import 'package:dragdrop/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../model/Audio.dart';

class TapImageScreen extends StatefulWidget {
  GameDataModel dataList;
  List<String> emptyList;
  int currentIndex;
  TapImageScreen(this.dataList, this.emptyList,this.currentIndex);


  @override
  State<TapImageScreen> createState() => _TapImageScreenState(dataList,emptyList,currentIndex);
}

class _TapImageScreenState extends State<TapImageScreen> {
  bool isTab=false;
  Map<int, String> caughtImages = {};
  final GameDataModel dataList;
  bool _isTargetOccupied=false;
  int selectedIndex=-1;

  _TapImageScreenState(this.dataList, this.emptyList,this.currentIndex);

  AudioService audioService=AudioService();
  int currentIndex=0;
  List<String> emptyList;
  late FlutterSoundPlayer soundPlayer;
  PlayerState audioPlayerState = PlayerState.isStopped;

  int length=0;
  int abovelistlength=0;
  bool isChangeImage=false;
  bool showListView = true;
  String textContent = 'Hello, Flutter!';
  bool showWinDialog = false;
  bool showTextView = false;

  void navigateToNextScreen() {
    int currentdata=currentIndex;
    if(currentIndex>=widget.dataList.data!.length-1)
    {
      currentdata=0;
    }
    else{
      currentdata++;
    }
    print(currentdata);


    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RememberNewScreen(dataList,currentdata,)
        ),
      );
    });
  }
  void navigateToCorrectScreen() {

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TimeUpScreen(currentIndex: currentIndex,dataList: dataList)
          )
      );
    });

  }

  @override
  void dispose() {
    soundPlayer.stopPlayer();
    soundPlayer.closeAudioSession();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    soundPlayer = FlutterSoundPlayer();
    // Wait for 5 seconds and then update the widget tree

  }

  Future<void> playAudio(String audioUrl) async {
    await soundPlayer.openAudioSession();
    if(audioUrl.contains("http")) {
      await soundPlayer.startPlayer(
        fromURI: audioUrl,
        codec: Codec.mp3,
      );
    }else{
      await soundPlayer.startPlayer(
        fromDataBuffer: (await rootBundle.load(audioUrl)).buffer.asUint8List(),
      );
    }
    setState(() {
      audioPlayerState = PlayerState.isPlaying;
    });
  }


  Future<void> pauseAudio() async {
    await soundPlayer.pausePlayer();
    setState(() {
      audioPlayerState = PlayerState.isPaused;
    });
  }

  Future<void> stopAudio() async {
    await soundPlayer.stopPlayer();
    setState(() {
      audioPlayerState = PlayerState.isStopped;
    });
  }

  int count = 0;
  int successCount=0;
  bool showSuccessDialog=false;
  @override
  Widget build(BuildContext context) {
     isTab=ScreenUtilClass().getIsTab(context);
     print("EmptyData");
     print(emptyList);

    return WillPopScope(

      onWillPop: () async {
       return true;
      },
      child: Scaffold(
           backgroundColor: Color(0xFF6555C0),
      body: SafeArea(
          child: Container(
            padding:isTab?const EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 0):const EdgeInsets.only(left: 10,right: 20,top: 20,bottom: 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => exitDialog())
                              ;
                            },
                            child: Center(
                              child: Image.asset(
                                'assets/newUi/CancelButton.png',
                                width: isTab?60:40,
                                height:isTab?60:40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 150,),

                        Padding(
                          padding: isTab?const EdgeInsets.only(top: 100,bottom: 10):const EdgeInsets.only(top: 10,bottom: 10),
                          child: Expanded(
                            flex: 8,
                            child: Container(
                              //Media Query
                              width: isTab ? 700 : 400,
                              height: isTab ? MediaQuery.sizeOf(context).height*0.1:50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFF7F6AF6),
                                borderRadius: BorderRadius.all(Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Tab options you saw in same order.',
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                    fontFamily: 'Grandstander',
                                    fontSize: isTab?30:20,
                                    fontWeight:FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 140,),
                        Expanded(
                            flex: 1,
                            child: Container(
                              width: 65,
                              height: isTab?50:40,
                              decoration: const BoxDecoration(
                                color: Color(0xFF7F6AF6),
                                borderRadius: BorderRadius.all(Radius.circular(40),
                                ),
                              ),
                              child:  Center(
                                child: Text('1/10',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Fredoka-Regular',
                                      fontSize: isTab?25:20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)
                                  ,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    // width: 1280,
                    // height: 100,
                    alignment: Alignment.center,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return  SizedBox(width: isTab?50.0:30.0); // Adjust the vertical spacing here
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dataList!.data![currentIndex].correctAnswer!.split(",").length,
                      itemBuilder: (context, index) {

                        return DragTarget<int>(
                            onAccept: (data) {
                              setState(() {
                                stopAudio();
                                playAudio("assets/mp3/Click.mp3");
                                 selectedIndex=data;
                                  if(selectedIndex==emptyList[index])
                                  {
                                    successCount++;
                                    print("successCount $successCount");
                                  }
                                  else
                                  {
                                    widget.dataList.data![currentIndex].options![count].isError = true;

                                  }
                                  // dataList[currentIndex].options[count].image = image.image;
                                  widget.dataList.data![currentIndex].options![count].isCorrect = true;
                                  count++;

                              });
                              if (successCount==widget.dataList.data![currentIndex].correctAnswer!.split(',').length) {

                                stopAudio();
                                playAudio('assets/mp3/Right.mp3');
                                Future.delayed(
                                  Duration.zero,
                                      () =>
                                      showDialog(
                                          context: context,
                                          builder: (context) => WinDialog()),
                                );
                                Timer(const Duration(seconds: 2), () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    showListView = false;
                                    navigateToNextScreen();
                                  });
                                });



                              }
                              else if(widget.dataList!.data![currentIndex].correctAnswer!.split(',').length==count)
                              {
                                stopAudio();
                                playAudio('assets/mp3/Wrong.mp3');
                                isChangeImage=true;
                                showListView = false;
                                navigateToCorrectScreen();

                              }
                            },
                            builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                                ) {
                              return
                                Container(
                                    margin:isTab?const EdgeInsets.only(left: 10, right: 10,top: 10):const EdgeInsets.only(left: 20, right: 20,top: 0),
                                    padding: isTab ? const EdgeInsets.only(right: 40):const EdgeInsets.all(0),
                                    height:isTab?180:111,
                                    width:isTab?180:111,
                                    alignment: Alignment.center,
                                    decoration:BoxDecoration(
                                      image: DecorationImage(
                                          // image: AssetImage(caughtImages.containsKey(index)?'assets/newUi/innerimage.png':'assets/newUi/tap.png'),

                                          // image: AssetImage(caughtImages.containsKey(index)?widget.dataList.data![0].options![index].isError?'assets/newUi/wrongimage.png':'assets/newUi/correctimage.png':widget.dataList.data![0].options![index].isCorrect?'assets/newUi/innerimage.png':'assets/newUi/tap.png'),
                                          image: AssetImage(
                                              caughtImages.containsKey(index)?(widget.dataList.data![currentIndex].correctAnswer!.split(",").length!=count)?'assets/newUi/innerimage.png':
                                           (count==widget.dataList.data![currentIndex].correctAnswer!.split(",").length&&widget.dataList.data![currentIndex].options![index].isError)?'assets/newUi/wrongimage.png':"assets/newUi/correctimage.png"
                                              // ?(count==widget.dataList.data![currentIndex].correctAnswer!.split(",").length&&widget.dataList.data![currentIndex].options![index].isCorrect)?'assets/newUi/correctimage.png':
                                              // 'assets/newUi/innerimage.png'
                                                  :'assets/newUi/tap.png'
                                          ),

                                          fit: BoxFit.fitWidth
                                      ),
                                    ),

                                    child:Center(

                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: isTab?const EdgeInsets.only(left:40,right: 10,top:10,bottom: 10):const EdgeInsets.all(30),
                                        // padding: isTab?const EdgeInsets.all(40):EdgeInsets.all(15),
                                        child: ClipRect(
                                          child: Center(
                                            child: caughtImages.containsKey(index)?Image.asset(caughtImages[index]!,
                                              width: isTab?120:106.0,
                                              height:isTab?120:106.0,
                                              fit: BoxFit.fitWidth,
                                            ):null,

                                          ),
                                        ),
                                      ),
                                    )
                                );
                            },
                          );
                      },
                    ),
                  ),
                ),
                showListView ? buildListView() : buildText(),
                // Building Drag Target Widgets

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildListView() {
    length=widget.dataList.data![currentIndex].options!.length;
    print("Ooptions $length");
    // Build your ListView widget here
    return Expanded(
      child: Padding(
        padding:isTab?const EdgeInsets.only(bottom: 100):const EdgeInsets.all(0),
        child: Container(
          width: isTab?1000:MediaQuery.sizeOf(context).width/0.5,
          height: isTab?MediaQuery.sizeOf(context).height*0.22:MediaQuery.sizeOf(context).height,
          alignment: Alignment.center,
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xff4CDAD4),
            borderRadius: BorderRadius.circular(50),
          ),

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.dataList.data![currentIndex].options!.length,
            itemBuilder: (context, index) {


              return Center(
                child: GestureDetector(
                  onTap: ()
                  {
                    print("Onclick $index");
                  },
                  child: Draggable<int>(

                        data: selectedIndex,
                        onDraggableCanceled: (velocity, offset) {

                        },
                        feedback: Container(
                          margin: EdgeInsets.only(left: 25),
                          alignment: Alignment.center,
                          width:130,
                          height:MediaQuery.sizeOf(context).height*0.23,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/newUi/innerimage.png'),
                            ),
                          ),
                          child: AnimatedContainer(
                            padding:const EdgeInsets.all(20),
                            duration: const Duration(milliseconds: 500),
                            child: ClipRect(
                              child: Center(
                                child: Image.asset(widget.dataList.data![currentIndex].options![index].image.toString(),
                                  width: isTab?115:70.0,
                                  height: isTab?MediaQuery.sizeOf(context).height*.23:106.0,

                                ),
                              ),
                            ),
                          ),
                        ),
                        child:Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 25),
                          alignment: Alignment.center,
                          width: 130,
                          height:MediaQuery.sizeOf(context).height*0.23,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/newUi/innerimage.png'),
                            ),
                          ),
                          child:Image.asset(widget.dataList.data![currentIndex].options![index].image.toString(),
                            width: isTab?115:70.0,
                            height: isTab?MediaQuery.sizeOf(context).height*.23:106.0,
                          ),
                        )
                      ),
                ),
              );
            },
          ),
        ),

      ),

    );
  }
  Widget buildText() {

    return Expanded(
        child: Container(
          width: 1280,
          height: 300,
          alignment: Alignment.center,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/new-ui/options/bg.png'),
          //     fit: BoxFit.fill,
          //   ),

          child: Center(
            child: GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration.zero,
                      () =>
                      showDialog(
                          context: context,
                          builder: (context) => WinDialog()),
                );
                Timer(const Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.asset(isChangeImage?'assets/newUi/CancelButton.png':
                    'assets/newUi/correct.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                      isChangeImage?'Oops!':'ALL DONE',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily:
                      'Grandstander',
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 0.9975,
                        color: Color(0xffffffff),
                      )
                  ),
                ],
              ),
            ),
          ),
        ));


  }
}
