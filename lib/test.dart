import 'package:flutter/material.dart';


void main()
{
  runApp(MaterialApp(home: DragAndDropScreen()));
}
class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  bool _isTargetOccupied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop'),
      ),
      body: Center(
        child: Stack(
          children: [
            DragTarget(
              builder: (context, candidateData, rejectedData) {
                return _isTargetOccupied
                    ? Container() // Empty container if target is occupied
                    : Image.asset('assets/newUi/tap.png');
              },
              onWillAccept: (data) {
                return !_isTargetOccupied; // Only accept if target is not occupied
              },
              onAccept: (data) {
                setState(() {
                  _isTargetOccupied = true;
                });
              },
              onLeave: (data) {
                // Reset the occupied flag if dragged image leaves the target
                setState(() {
                  _isTargetOccupied = false;
                });
              },
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Draggable(
                child: Image.asset('assets/newUi/fish.png'),
                feedback: Image.asset('assets/newUi/fish.png'),
                childWhenDragging: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
