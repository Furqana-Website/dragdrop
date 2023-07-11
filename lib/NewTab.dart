// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drag and Drop Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DragAndDropScreen(),
//     );
//   }
// }
//
// class DragAndDropScreen extends StatefulWidget {
//   @override
//   _DragAndDropScreenState createState() => _DragAndDropScreenState();
// }
//
// class _DragAndDropScreenState extends State<DragAndDropScreen> {
//   List<String> sourceList = ['Item 1', 'Item 2', 'Item 3'];
//   List<String> targetList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Drag and Drop Demo'),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           buildDragTarget(),
//           buildDraggableList(),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDraggableList() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: sourceList.length,
//         itemBuilder: (context, index) {
//           return Draggable<String>(
//             data: sourceList[index],
//             child: Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(vertical: 8),
//               color: Colors.blue,
//               child: Text(
//                 sourceList[index],
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             feedback: Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(vertical: 8),
//               color: Colors.blue.withOpacity(0.7),
//               child: Text(
//                 sourceList[index],
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             childWhenDragging: Container(),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildDragTarget() {
//     return DragTarget<String>(
//       builder: (context, candidateData, rejectedData) {
//         return Container(
//           width: 50,
//           height: 200,
//           color: Colors.grey,
//           alignment: Alignment.center,
//           child: Text(
//             'Drop Here',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//         );
//       },
//       onAccept: (data) {
//         setState(() {
//           targetList.add(data);
//           sourceList.remove(data);
//         });
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag and Drop Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DragAndDropScreen(),
    );
  }
}

class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<String> sourceList = ['Image 1', 'Image 2', 'Image 3'];
  List<String> targetList = ['list1', 'Image 2', 'Image 3'];

  List<String> occupiedDestinations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Demo'),
      ),
      body: Row(
        children: [
          buildDraggableList(),
          buildDragTargetList(),
        ],
      ),
    );
  }

  Widget buildDraggableList() {
    return Expanded(
      child: ListView.builder(
        itemCount: sourceList.length,
        itemBuilder: (context, index) {
          return Draggable<String>(
            data: sourceList[index],
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Colors.blue,
              child: Text(
                sourceList[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
            feedback: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Colors.blue.withOpacity(0.7),
              child: Text(
                sourceList[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
            childWhenDragging: Container(),
          );
        },
      ),
    );
  }

  Widget buildDragTargetList() {
    return Expanded(
      child: ListView.builder(
        itemCount: targetList.length,
        itemBuilder: (context, index) {
          return DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 8),
                color:  Colors.grey,
                child: Text(
                  occupiedDestinations.contains(targetList[index])?targetList.isEmpty?"Drop here":targetList[index]:targetList.isEmpty?'Drop here':targetList[index],
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            },
            // onWillAccept: (data) {
            //   return !occupiedDestinations.contains(targetList[index]);
            // },
            onAccept: (data) {
              setState(() {
                targetList.add(data);
                occupiedDestinations.add(targetList[index]);
                sourceList.remove(data);
              });
            },
          );
        },
      ),
    );
  }
}