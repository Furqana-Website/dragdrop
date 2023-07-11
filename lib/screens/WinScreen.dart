import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:dragdrop/services/helpers.dart';
class WinDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAnimation(),
    );
  }
}

class MyAnimation extends StatefulWidget {
  @override
  WinDialogChallenge createState() => WinDialogChallenge();
}
class WinDialogChallenge extends State<MyAnimation> {

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
  // WinDialogChallenge(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isTab=ScreenUtilClass().getIsTab(context);
    return Center(
      child: Column(


        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon at the top
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 25,
            emissionFrequency: 0.05,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.orange,
            ],
          ),
          Padding(
            padding:isTab?EdgeInsets.only(right: 800,bottom: 10):EdgeInsets.only(right: 500),
            child: Container(
              // margin: EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/newUi/blub.png',
                width: isTab?300:100.0,
                height: isTab?300:150.0,
              ),
            ),
          ),
          // Image at the center
          // Container(
          //   // margin: EdgeInsets.only(top: 16.0),
          //   child: Image.asset(
          //     'assets/new-ui/images/bg.png',
          //     width: 200.0,
          //     height: 200.0,
          //   ),
          // ),
          Container(
            width: isTab?800:400,
            height:isTab?300: 150,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/newUi/alert.png'),
                // fit: BoxFit.cover,
              ),
            ),
            child: const Center(child:Text(
              "You Won",
              style: TextStyle(fontFamily:
              'Grandstander',
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 0.9975,
                color: Color(0xffffffff),
              )
              ),
            ),
            ),
        ],
      ),
    );

  }



}
