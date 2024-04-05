import 'package:bloc/bloc.dart';
import 'package:buscador_gif/data_layer/giphy_api/giphy_model.dart';
import 'package:buscador_gif/domain_layer/domain_layer.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class GiphyCubit extends Cubit<GiphyState> {
  GiphyCubit({required GiphyRepository repository})
      : _repository = repository,
        super(const GiphyState.loading());

  final GiphyRepository _repository;

  void onSearchSubmitted(String? text) {
    _repository.search(text);
    onDataLoaded();
  }

  void onMoreDataLoaded() {
    _repository.loadMoreGifs();
    onDataLoaded();
  }

  void onDataLoaded() async {
    try {
      emit(const GiphyState.loading());
      final gifList = await _repository.getGifs();
      emit(GiphyState.success(list: gifList));
    } catch (_) {
      emit(const GiphyState.failure());
    }
  }
}
