import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/helpers.dart';

class exitDialog extends StatefulWidget {
  @override
  _exitDialogState createState() => _exitDialogState();
}

class _exitDialogState extends State<exitDialog> {

  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //     contentPadding: EdgeInsets.zero,
    //     backgroundColor: Colors.transparent,
    //     content: Container(
    //       height: 500,
    //       width: 500,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage(
    //             _isImage1Selected
    //                 ? 'assets/new-ui/images/alert.png'
    //                 : 'assets/new-ui/images/alert.png',
    //           ),
    //         ),
    //       ),
    //       child: Stack(
    //         alignment: Alignment.bottomCenter,
    //         children: [
    //           // Image.asset(
    //           //   _isImage1Selected
    //           //       ? 'assets/new-ui/images/alert.png'
    //           //       : 'assets/new-ui/images/alert.png',
    //           //   fit: BoxFit.cover,
    //           // ),
    //           const Center(
    //               child: Text(
    //                 'Are you Sure you \n \t want to exit',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 40,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               )),
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 20),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.pop(context, true);
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     elevation: 0,
    //                     primary: Colors.transparent,
    //                     onPrimary: Colors.white,
    //                     shape: CircleBorder(),
    //                   ),
    //                   child: Image.asset(
    //                     'assets/new-ui/images/group-14746.png',
    //                     width: 80,
    //                     height: 80,
    //                   ),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.pop(context, false);
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     elevation: 0,
    //                     primary: Colors.transparent,
    //                     onPrimary: Colors.white,
    //                     shape: CircleBorder(),
    //                   ),
    //                   child: Image.asset(
    //                     'assets/new-ui/images/exit.png',
    //                     width: 80,
    //                     height: 80,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //   //
    //   // Stack(
    //   //   alignment: Alignment.bottomCenter,
    //   //   children: [
    //   //     Image.asset(
    //   //       _isImage1Selected
    //   //           ? 'assets/new-ui/images/alert.png'
    //   //           : 'assets/new-ui/images/alert.png',
    //   //         fit: BoxFit.cover,
    //   //     ),
    //   //
    //   //     Column(
    //   //       mainAxisSize: MainAxisSize.min,
    //   //       children: [
    //   //         const Center(child:Text(
    //   //           'Are you Sure you \n \t want to exit',
    //   //           style: TextStyle(
    //   //             color: Colors.white,
    //   //             fontSize: 40,
    //   //             fontWeight: FontWeight.bold,
    //   //           ),
    //   //         )
    //   //         ),
    //   //         SizedBox(height: 16),
    //   //         Positioned(
    //   //           top: 20,
    //   //           child: Row(
    //   //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   //             children: [
    //   //               Padding(
    //   //                 padding: const EdgeInsets.only(left: 16,top:30),
    //   //                 child: ElevatedButton(
    //   //                   onPressed: () {
    //   //                     Navigator.pop(context, true);
    //   //                   },
    //   //                   style: ElevatedButton.styleFrom(
    //   //                     elevation: 0,
    //   //                     primary: Colors.transparent,
    //   //                     onPrimary: Colors.white,
    //   //                     shape: CircleBorder(),
    //   //
    //   //                   ),
    //   //                   child: Image.asset(
    //   //                     'assets/new-ui/images/group-14746.png',
    //   //                       width: 80,
    //   //                       height: 80,
    //   //                   ),
    //   //                 ),
    //   //               ),
    //   //               Padding(
    //   //                   padding: EdgeInsets.only(right: 16,top:30),
    //   //                   child: ElevatedButton(
    //   //                     onPressed: () {
    //   //                       Navigator.pop(context, false);
    //   //                     },
    //   //                     style: ElevatedButton.styleFrom(
    //   //                       elevation: 0,
    //   //                       primary: Colors.transparent,
    //   //                       onPrimary: Colors.white,
    //   //                       shape: CircleBorder(),
    //   //
    //   //                     ),
    //   //
    //   //                     child: Image.asset(
    //   //                       'assets/new-ui/images/exit.png',
    //   //                       width: 80,
    //   //                       height: 80,
    //   //                     ),
    //   //                 )
    //   //               ),
    //   //             ],
    //   //           ),
    //   //         ),
    //   //       ],
    //   //     ),
    //   //   ],
    //   // ),
    // );
    bool isTab = ScreenUtilClass().getIsTab(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: isTab?512:400,
                height: isTab?320:200,
                margin: EdgeInsets.all(3),
                child: Image.asset(
                  'assets/newUi/exitbg.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  width:isTab?447:200,
                  height:isTab?173:100,
                  margin: EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/newUi/exitbgtext.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isTab?const Text(
                      "Do you really \nwant to exit?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Degular"),
                    ):const Text(
                      "Do you really \nwant to exit?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Degular"),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: isTab?112:100,
                                height:50,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(false);

                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('assets/newUi/nobtn.png'),
                                      const Text("No",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              height: 1.0,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "Degular")),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width:isTab?112:100,
                              height:50,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(true);
                                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                                  // Navigator.of(context, rootNavigator: true)
                                  //     .pop();
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/newUi/yes.png',
                                    ),
                                    const Text("Yes",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            height: 1.0,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Degular"))
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}