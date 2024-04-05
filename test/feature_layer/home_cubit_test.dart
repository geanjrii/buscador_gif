import 'package:bloc_test/bloc_test.dart';
import 'package:buscador_gif/data_layer/data_layer.dart';
import 'package:buscador_gif/domain_layer/domain_layer.dart';
import 'package:buscador_gif/feature_layer/giphy/cubit/home_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGiphyRepository extends Mock implements GiphyRepository {}

void main() {
  const mockList = [
    GiphyModel(imgUrl: '1', title: '1'),
    GiphyModel(imgUrl: '2', title: '2'),
  ];
  late GiphyCubit giphyCubit;
  late MockGiphyRepository mockRepository;

  setUp(() {
    mockRepository = MockGiphyRepository();
    giphyCubit = GiphyCubit(repository: mockRepository);
  });

  tearDown(() => giphyCubit.close());

  group('GiphyCubit', () {
    blocTest<GiphyCubit, GiphyState>(
      'onSearchSubmitted should call search method and onDataLoaded',
      setUp: () {
        when(() => mockRepository.search('example')).thenAnswer((_) async {});
        when(() => mockRepository.getGifs()).thenAnswer((_) async => mockList);
      },
      build: () => giphyCubit,
      act: (cubit) => cubit.onSearchSubmitted('example'),
      expect: () => [
        const GiphyState.loading(),
        const GiphyState.success(list: mockList),
      ],
      verify: (_) {
        verify(() => mockRepository.search('example')).called(1);
        verify(() => mockRepository.getGifs()).called(1);
      },
    );

    blocTest<GiphyCubit, GiphyState>(
      'onMoreDataLoaded should call loadMoreGifs method and onDataLoaded',
      setUp: () {
        when(() => mockRepository.loadMoreGifs()).thenAnswer((_) async {});
        when(() => mockRepository.getGifs()).thenAnswer((_) async => mockList);
      },
      build: () => giphyCubit,
      act: (cubit) => cubit.onMoreDataLoaded(),
      expect: () => [
        const GiphyState.loading(),
        const GiphyState.success(list: mockList),
      ],
      verify: (_) {
        verify(() => mockRepository.loadMoreGifs()).called(1);
        verify(() => mockRepository.getGifs()).called(1);
      },
    );

    blocTest<GiphyCubit, GiphyState>(
      'onDataLoaded should emit loading state, call getGifs method, and emit success state',
      setUp: () {
        when(() => mockRepository.getGifs()).thenAnswer((_) async => mockList);
      },
      build: () => giphyCubit,
      act: (cubit) => cubit.onDataLoaded(),
      expect: () => [
        const GiphyState.loading(),
        const GiphyState.success(list: mockList),
      ],
      verify: (_) {
        verify(() => mockRepository.getGifs()).called(1);
      },
    );

    blocTest<GiphyCubit, GiphyState>(
      'onDataLoaded should emit loading state, call getGifs method, and emit failure state when an exception occurs',
      setUp: () {
        when(() => mockRepository.getGifs()).thenThrow(Exception());
      },
      build: () => giphyCubit,
      act: (cubit) {
        cubit.onDataLoaded();
      },
      expect: () => [
        const GiphyState.loading(),
        const GiphyState.failure(),
      ],
      verify: (_) {
        verify(() => mockRepository.getGifs()).called(1);
      },
    );
  });
}
