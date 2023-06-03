import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app_c8_friday/models/SourceResponse.dart';
import 'package:news_app_c8_friday/shared/constants.dart';

class ApiManager{

  static Future<SourceResponse?> getSources()async{
    Uri url = Uri.https(baseUrl , "/v2/top-headlines/sources",{
      "apiKey":apiKey
    });
    Response response = await http.get(url);
    try{
      var body = jsonDecode(response.body);
      SourceResponse sourceResponse = SourceResponse.fromJson(body);
      return sourceResponse;
    }catch(e){
      print("error${e.toString()}");
      print("erro");
    }

  }
}