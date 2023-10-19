import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/search_tvshow.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvShow searchTvShow;
  SearchTvBloc({required this.searchTvShow}) : super(SearchTvInitial()) {
    on<FetchSearchTv>((event, emit) async {
      emit(SearchTvLoading());
      final query = event.query;

      final result = await searchTvShow.execute(query);

      result.fold((failure) => emit(SearchTvFailed(failure.message)),
          (searchData) {
        if (searchData.isEmpty) {
          emit(SearchTvInitial());
        } else {
          emit(SearchTvSuccess(searchData));
        }
      });
    });
  }
}
