import 'dart:convert';

import 'package:dragdrop/model/memoryGame.dart';
import 'package:flutter/services.dart';

class DataModel {
  final List<CorrectAnswer> images;
  final int level;
  final List<String> options;

  DataModel({required this.images, required this.level, required this.options});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(

      images: List<CorrectAnswer>.from(json["images"].map((x) => CorrectAnswer.fromJson(x))),
      level: json["level"],
      options: List<String>.from(json["options"].map((x) => x)),

    );
  }


}
class CorrectAnswer
{
  String imagePath;
  bool isCorrect;
  bool isError;

  CorrectAnswer({required this.imagePath,this.isCorrect= false,this.isError=false});
  factory CorrectAnswer.fromJson(Map<String, dynamic> json) {
    return CorrectAnswer(
      imagePath: json['imagePath'],
      isCorrect: json['isCorrect'],
    );
  }

}

Future<memoryGame> readJson() async {
  final jsonString = await rootBundle.loadString('assets/Data.json');
  final jsonData = json.decode(jsonString);
  print(jsonData);
  return memoryGame.fromJson(jsonData);

}



// class GameDataModel {
//   final String CorrectAnswer;
//   final List<Options> options;
//
//   GameDataModel({required this.CorrectAnswer, required this.options});
//
//   factory GameDataModel.fromJson(Map<String, dynamic> json) {
//     return GameDataModel(
//
//       CorrectAnswer: json["CorrectAnswer"],
//       options: List<Options>.from(json['Options']?.map((option) => Options.fromJson(option)) ?? []),
//
//     );
//   }
//
//
// }


class GameDataModel {
  List<memoryGame>? data;

  GameDataModel({this.data});

  GameDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <memoryGame>[];
      json['data'].forEach((v) {
        data!.add(memoryGame.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
