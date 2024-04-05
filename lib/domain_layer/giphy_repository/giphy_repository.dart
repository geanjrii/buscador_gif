import 'package:buscador_gif/data_layer/data_layer.dart';

class GiphyRepository {
  final GiphyApi _api;

  GiphyRepository({required GiphyApi api}) : _api = api;

  void search(String? text) {
    _api.search(text);
  }

  Future<List<GiphyModel>> getGifs() async {
    return await _api.getGifs();
  }

  void loadMoreGifs() {
    _api.loadMoreGifs();
  }
}
