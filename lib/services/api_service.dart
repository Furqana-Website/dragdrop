import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../model/user_model.dart';

class DataService {
  static Future<List<DataModel>> loadDataFromJson() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonData);
    List<dynamic> dataList = jsonMap['data'];

    List<DataModel> dataModels = dataList.map((item) {
      return DataModel.fromJson(item);
    }).toList();

    return dataModels;
  }
}

class DataServiceClass {
  Future<GameDataModel?> loadDummyData() async {
    final String response =
    await rootBundle.loadString('assets/Data.json');
    return GameDataModel.fromJson(json.decode(response));
  }
}
// class DataServiceClass {
//   static Future<List<GameDataModel>> loadDataFromJson() async {
//     String jsonData = await rootBundle.loadString('assets/Data.json');
//     Map<String, dynamic> jsonMap = jsonDecode(jsonData);
//     List<dynamic> dataList = jsonMap['data'];
//
//     List<GameDataModel> dataModels = dataList.map((item) {
//       return GameDataModel.fromJson(item);
//     }).toList();
//
//     return dataModels;
//   }
// }

