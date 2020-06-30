import 'package:cachingapp/network/network_manager.dart';
import 'package:cachingapp/view/http_status/model/http_model.dart';
import 'package:flutter/material.dart';
import './http_status.dart';

abstract class HttpStatusViewModel extends State<HttpStatus> {
  final String baseUrl = "https://hwasampleapi.firebaseio.com";
  final String httpChild = "http.json";

  bool isLoading = false;

  List<HttpModel> httpModels = [];
  // Add your state and logic here
  NetworkManager manager = NetworkManager.instance;

  Future<void> getAllHttpStatus() async {
    setState(() {
      isLoading = true;
    });
    final response = await manager.get<HttpModel>(url: "$baseUrl/$httpChild", model: HttpModel(), isCaching: true);
    if (response is List) {
      httpModels = response;
    }

    setState(() {
      isLoading = false;
    });
  }
}
