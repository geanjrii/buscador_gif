import 'package:buscador_gif/data_layer/data_layer.dart';
import 'package:buscador_gif/domain_layer/domain_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGiphyApi extends Mock implements GiphyApi {}

void main() {
  late MockGiphyApi mockApi;
  late GiphyRepository giphyRepository;

  setUp(() {
    mockApi = MockGiphyApi();
    giphyRepository = GiphyRepository(api: mockApi);
  });

  test('getGifs should call api.getGifs', () async {
    final mockGifs = [
      const GiphyModel(imgUrl: '1', title: '1'),
      const GiphyModel(imgUrl: '2', title: '2'),
    ];
    when(() => mockApi.getGifs()).thenAnswer((_) async => mockGifs);
    final gifs = await giphyRepository.getGifs();
    expect(gifs, equals(mockGifs));
    verify(() => mockApi.getGifs()).called(1);
  });

  test('loadMoreGifs should call api.loadMoreGifs', () {
    giphyRepository.loadMoreGifs();
    verify(() => mockApi.loadMoreGifs()).called(1);
  });

  test('search should call api.search', () {
    const mockSearch = 'mock';
    giphyRepository.search(mockSearch);
    verify(() => mockApi.search(mockSearch)).called(1);
  });
}
