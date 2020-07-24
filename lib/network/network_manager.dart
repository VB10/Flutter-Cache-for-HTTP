import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../local/IFileManager.dart';
import '../local/local_file.dart';
import '../local/model/base_model.dart';

class NetworkManager {
  IFileManager fileManager;

  static NetworkManager _instance;
  static NetworkManager get instance {
    if (_instance == null) {
      _instance = NetworkManager._init();
    }
    return _instance;
  }

  NetworkManager._init() {
    fileManager = LocalFile();
  }

  Future<dynamic> get<T extends BaseModel>({@required String url, @required T model, bool isCaching = false}) async {
    final localData = await getLocalData(url);
    if (localData != null && localData.isNotEmpty) {
      return jsonParse(localData, model);
    }
    final result = await http.get(url);
    final responseModel = responseParser<T>(result, model, isCache: isCaching);
    if (isCaching) fileManager.writeUserRequestDataWithTime("veli-$url-get", result.body, Duration(hours: 1));
    return responseModel;
  }

  dynamic responseParser<T extends BaseModel>(Response response, BaseModel model, {bool isCache}) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return jsonParse<T>(response.body, model);
        break;
      default:
        return response.statusCode;
    }
  }

  jsonParse<T extends BaseModel>(String body, T model) {
    final jsonModel = jsonDecode(body);
    if (jsonModel is List) {
      return jsonModel.map((e) => model.fromJson(e)).cast<T>().toList();
    } else if (jsonModel is Map) {
      return model.fromJson(jsonModel);
    } else {
      return jsonModel;
    }
  }

  Future<String> getLocalData(String url) async {
    final data = await fileManager.getUserRequestDataOnString(url);
    return data;
  }

  void _x(args) {}
}
