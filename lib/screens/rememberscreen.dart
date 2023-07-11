import 'dart:async';
import 'package:dragdrop/model/memoryGame.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'TapScreen.dart';
import '../model/Audio.dart';
import '../model/user_model.dart';
import '../model/user_model.dart';
import '../services/api_service.dart';
import '../services/helpers.dart';
import 'dart:math' as math;

import 'exit_dialog.dart';


class RememberNewScreen extends StatefulWidget {
  late GameDataModel dataModels;
  int currentIndex;
  RememberNewScreen(this.dataModels, this.currentIndex);


  @override
  TwoRowsWithCards createState() =>
      TwoRowsWithCards(dataModels,currentIndex);
}

class TwoRowsWithCards extends State<RememberNewScreen>
    with TickerProviderStateMixin {
  late FlutterSoundPlayer soundPlayer;
  final AudioService audioService=AudioService();
  PlayerState audioPlayerState = PlayerState.isStopped;
  late AnimationController _controller;
  late Animation<int> _animation;
  late Animation<double> _progressAnimation;
  int currentIndex;
  GameDataModel? gameplayData;
  TwoRowsWithCards(this.gameplayData,  this.currentIndex);
  @override
  void initState() {
    super.initState();
    soundPlayer = FlutterSoundPlayer();
    // audioService.playAudio('assets/mp3/BG_Music.mp3');
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    loadData();
    startTimer();

  }

  Future<void> loadData() async {
    DataServiceClass().loadDummyData().then((value) {
      setState(() {
        gameplayData = value!;
      });
    });
    emptyList.length=gameplayData!.data![currentIndex].correctAnswer!.split(",").length;
  }
  void startTimer() {
    _animation = IntTween(begin: 10, end: 0).animate(_controller);
    _progressAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _controller.forward();
  }

  void stopAnimation() {
    _controller.stop();
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


  @override
  void dispose() {
    soundPlayer.stopPlayer();
    soundPlayer.closeAudioSession();
    _controller.dispose();
    super.dispose();

  }

  void restartTimer() {
    startTimer();
    // Start the timer again
  }

  final List<String> imagePaths = [
    'assets/newUi/fish.png',
    'assets/newUi/plain.png',
    'assets/newUi/car.png',
    'assets/newUi/plain.png',
    'assets/newUi/car.png'
  ];

  List<String> emptyList=[

  ];
  final List<String> row1Items = [
    'assets/newUi/innerimage.png',
    'assets/newUi/innerimage.png',
    'assets/newUi/innerimage.png',
    'assets/newUi/remrec.png',
    'assets/newUi/remrec.png',
  ];
  final List<String> imageUrls = [
    'assets/new-ui/images/bg.png',
    'assets/new-ui/images/bg.png',
    'assets/new-ui/images/bg.png',
    'assets/new-ui/images/bg.png',
    'assets/new-ui/images/bg.png',
    // 'assets/new-ui/images/bg.png',
    // 'assets/new-ui/images/bg.png',
  ];

  List<int> getCorrectAnswerIndices() {
    return gameplayData!.data![currentIndex].correctAnswer!.split(',').map((index) => int.parse(index.trim())).toList();
  }


  @override
  Widget build(BuildContext context) {
      bool isTab = ScreenUtilClass().getIsTab(context);
      ThemeData themeData = Theme.of(context);
      try{
        Timer(
            Duration(seconds: 10),
                () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TapImageScreen(gameplayData!,emptyList,currentIndex)
                          // TapScreen(dataList: gameplayData,
                          //   currentIndex: currentIndex,
                          //   emptyList: emptyList,
                          //
                          // )
                  ));
                });
        // Future.delayed(
        //   Duration.zero,
        //       () =>
        //       showDialog(
        //           context: context,
        //           builder: (context) => AlertDialogChallenge("Challenge\t$text")),
        // );
        // Timer(Duration(seconds: 2), () {
        //   Navigator.of(context).pop();
        // });
      }
      catch(e)
    {

    }
      List<int> correctIndices = gameplayData!.data![currentIndex].correctAnswer!.split(',').map((index) => int.parse(index.trim())).toList();

      return WillPopScope(
        onWillPop: () async {
          stopAnimation();
        return await showDialog(
            context: context,
            builder: (context) => exitDialog());

        },
        child: Scaffold(
          backgroundColor: Color(0xFF6555C0),
          body: SafeArea(
            child: Container(
              padding:isTab?const EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 0):const EdgeInsets.only(left: 5,right: 20,top: 40,bottom: 10),
              child: Column(
                children: [
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
                                stopAnimation();
                                showDialog(
                                    context: context,
                                    builder: (context) => exitDialog()).then((value) => restartTimer())
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
                                  'Remember this order',
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
                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: gameplayData!.data![currentIndex].correctAnswer!.split(",").length,
                        padding: isTab
                            ? const EdgeInsets.all(0.0)
                            : const EdgeInsets.only(top: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          print(index);
                          int imageIndex = correctIndices[index] - 1;
                          print("imageIndex $imageIndex");

                          Options imageUrls=gameplayData!.data![currentIndex].options![imageIndex];
                          emptyList.insert(index,gameplayData!.data![currentIndex].options![imageIndex].image.toString());
                          print("Lenghth of card");
                          print(emptyList.length);
                          return Row(
                          children: [
                          Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Container(
                          margin: isTab ? const EdgeInsets.only(
                          left: 10, right: 10, top: 0) : const EdgeInsets
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
                          ? const EdgeInsets.all(10)
                          : EdgeInsets.all(20),
                          child: Center(
                          child: Image.asset(
                          imageUrls.image.toString(),
                          width: 110,
                          height: 110,
                          fit: BoxFit.fitWidth,
                          ),
                          ),
                          ),
                          )
                          ),

                          ],

                          );

                        },
                      )

                    ),
                  Expanded(
                    child: Padding(
                      padding: isTab
                          ? const EdgeInsets.only(bottom: 200)
                          : const EdgeInsets.all(0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: isTab ? 113 : 80,
                            height: isTab ? 113 : 80,
                            alignment: Alignment.center,
                            margin: isTab ? const EdgeInsets.all(0.0) : EdgeInsets
                                .only(bottom: 50, top: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF40309F),
                            ),
                            child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Align(
                                                alignment: FractionalOffset
                                                    .topCenter,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned.fill(
                                                      child: CustomPaint(
                                                          painter: CustomTimerPainter(
                                                            animation: _controller,
                                                            backgroundColor: Color(
                                                                0xFF40309F),
                                                            color: themeData
                                                                .indicatorColor,
                                                          )),
                                                    ),
                                                    Center(
                                                        child: Text(
                                                            _animation.value
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: isTab
                                                                  ? 40
                                                                  : 30,
                                                              color: Colors.white,
                                                            )))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
