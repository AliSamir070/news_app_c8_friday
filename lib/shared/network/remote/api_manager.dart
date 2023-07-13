import 'dart:convert';

import 'package:http/http.dart' as http;


import '../../../models/NewsResponse.dart';
import '../../../models/SourcesResponse.dart';
import '../../components/constants.dart';

class ApiManager {
  static Future<SourcesResponse> getSources(String cat) async {
    Uri URL = Uri.https(
        BASE, "/v2/top-headlines/sources", {"apiKey": APIKEY, "category": cat});
    http.Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);

    SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonResponse);
    return sourcesResponse;
  }

  static Future<NewsResponse> getNewsData({String? sourceId , String? q , int? page}) async {
    late Uri URL;
    if(page != null){
      URL = Uri.https(BASE, "/v2/everything", {"apiKey": APIKEY, "sources": sourceId ,"page":page.toString()});
    }else{
      URL = Uri.https(BASE, "/v2/everything", {"apiKey": APIKEY, "sources": sourceId ,"q":q});
    }
    http.Response response = await http.get(URL);
    print(response.body);
    var json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
