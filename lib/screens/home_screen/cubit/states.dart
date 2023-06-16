abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeGetSourcesSuccessState extends HomeStates {}

class HomeGetNewsSuccessState extends HomeStates {}

class HomeGetSourcesErrorState extends HomeStates {
  String error;

  HomeGetSourcesErrorState(this.error);
}

class HomeGetNewsErrorState extends HomeStates {
  String error;

  HomeGetNewsErrorState(this.error);
}


class ChangeSourceState extends HomeStates{}
