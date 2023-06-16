import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app_c8_friday/screens/home_screen/cubit/states.dart';

import '../../../models/NewsModel.dart';
import '../../../models/SourceResponse.dart';
import '../../../models/Sources.dart';
import '../../../shared/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Sources> sources = [];
  List<Articles> news = [];
  int selectedIndex = 0;

  Future<void> getSources(String catID) async {
    emit(HomeLoadingState());
    Uri url = Uri.https(baseUrl, "/v2/top-headlines/sources",
        {"apiKey": apiKey, "category": catID});
    http.get(url).then((value) {
      var body = jsonDecode(value.body);
      SourceResponse sourceResponse = SourceResponse.fromJson(body);
      sources = sourceResponse.sources ?? [];
      emit(HomeGetSourcesSuccessState());
    }).catchError((e) {
      emit(HomeGetSourcesErrorState(e.toString()));
    });
  }

  void changeSource(int index) {
    selectedIndex = index;
    emit(ChangeSourceState());
  }

  Future<void> getNewsData() async {
    emit(HomeLoadingState());
    Uri URL = Uri.https(baseUrl, "/v2/everything",
        {"apiKey": apiKey, "sources": sources[selectedIndex].id});
    http.get(URL).then((value) {
      var json = jsonDecode(value.body);
      NewsModel newsModel = NewsModel.fromJson(json);
      news = newsModel.articles ?? [];
      emit((HomeGetNewsSuccessState()));
    }).catchError((e) {
      emit(HomeGetNewsErrorState(e.toString()));
    });
  }
}
