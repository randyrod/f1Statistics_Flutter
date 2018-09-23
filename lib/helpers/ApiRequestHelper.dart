import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formula1_statistics_flutter/model/RequestParameters.dart';
import 'package:formula1_statistics_flutter/model/ResponseModel.dart';

class ApiRequestHelper {
  final retryCount = 3;

  Future<ResponseModel> performApiRequest(RequestParameters parameters) async {
    if (parameters == null) return null;

    var httpClient = new http.Client();
    
    try {
      for (var i = 0; i < retryCount; i++) {
        switch(parameters.requestType)
        {
          case RequestTypeEnum.Get:
          var response = await httpClient.get(Uri.parse(parameters.url));

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
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
