part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int page;

  const HomeState({this.page = 0});

  HomeState copyWith({int? page}) {
    return HomeState(page: page ?? this.page);
  }

  @override
  List<Object> get props => [page];
}
