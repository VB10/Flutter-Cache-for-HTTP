import 'package:flutter/material.dart';
import './http_status_view_model.dart';

class HttpStatusView extends HttpStatusViewModel {
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getAllHttpStatus();
        },
      ),
      body: isLoading
          ? buildCenterLoading()
          : ListView.builder(
              itemCount: httpModels.length,
              itemBuilder: (context, index) => Text("${httpModels[index].description}"),
            ),
    );
  }

  Widget buildCenterLoading() => Center(child: CircularProgressIndicator());
}
