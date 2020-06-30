import 'package:cachingapp/local/model/base_model.dart';

class HttpModel extends BaseModel {
  String description;
  String imageUrl;
  int statusCode;

  HttpModel({this.description, this.imageUrl, this.statusCode});

  HttpModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['statusCode'] = this.statusCode;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return HttpModel.fromJson(json);
  }
}
