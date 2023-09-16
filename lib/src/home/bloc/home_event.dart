part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostListEvent extends HomeEvent {
  FetchPostListEvent({ this.postLimit = 20, this.startIndex = 0});

  final int startIndex;
  final int postLimit;


  @override
  List<Object> get props => [];
}
