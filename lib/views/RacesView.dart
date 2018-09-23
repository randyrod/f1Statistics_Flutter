import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formula1_statistics_flutter/helpers/ApiRequestHelper.dart';
import 'package:formula1_statistics_flutter/model/RequestParameters.dart';

class RacesView extends StatefulWidget {

  @override
  RacesViewState createState() => RacesViewState();
}

class RacesViewState extends State<RacesView> {

  final racesRequestUrl = "http://ergast.com/api/f1/current.json";

  bool loading = true;

  String pageContent = "";

  @override
  void initState() {
    super.initState();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Races")
      ),
      body: !loading
        ? RefreshIndicator(
          onRefresh: () async {
            pageContent = "";
            await getData();
            setState(() {});
          },
          child: new Text(pageContent),
        )
        : Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)
            )
          )
    );
  }

  Future<String> getData() async {

    var requestHelper = new ApiRequestHelper();

    var parameters = new RequestParameters(RequestTypeEnum.Get, racesRequestUrl);

    var response = await requestHelper.performApiRequest(parameters);

    if(response == null || !response.isSuccess)
    {
      pageContent = "Not loaded";
      return null;
    }

    pageContent = response.result.toString();

    return response.result.toString();
  }

}

