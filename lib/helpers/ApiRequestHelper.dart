import 'dart:_http';
import 'dart:async';
import 'dart:convert';

import 'package:formula1_statistics_flutter/model/RequestParameters.dart';
import 'package:formula1_statistics_flutter/model/ResponseModel.dart';

class ApiRequestHelper {
  final retryCount = 3;

  Future<ResponseModel> performApiRequest(RequestParameters parameters) async {
    if (parameters == null) return null;

    var httpClient = new HttpClient();

    try {
      for (var i = 0; i < retryCount; i++) {
        switch(parameters.requestType)
        {
          case RequestTypeEnum.Get:
          var request = await httpClient.getUrl(Uri.parse(parameters.url));
          var response = await request.close();

          if (response.statusCode == HttpStatus.ok) {
            var jsonResponse = await response.transform(utf8.decoder).join();
            var data = jsonDecode(jsonResponse);
            return new ResponseModel(true, data);
          } else {
            return new ResponseModel(false, null);
          }
          break;
          case RequestTypeEnum.Delete: //todo
          case RequestTypeEnum.Post: //todo
          case RequestTypeEnum.Put: //todo
          break;
        }
      }
    } catch (exception) {
      return null;
    }

    return null;
  }
}
