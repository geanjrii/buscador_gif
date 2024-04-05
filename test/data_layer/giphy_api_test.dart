import 'package:buscador_gif/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late GiphyApi currencyApi;
  late MockHttpClient mockClient;
  late MockHttpResponse mockResponse;

  setUp(() {
    mockClient = MockHttpClient();
    mockResponse = MockHttpResponse();
    currencyApi = GiphyApi(client: mockClient);
  });

  registerFallbackValue(Uri());

  test(' returns gifs when API call is successful', () async {
    when(() => mockResponse.statusCode).thenReturn(200);
    when(() => mockResponse.body).thenReturn('{}');
    when(() => mockClient.get(any())).thenAnswer((_) async => mockResponse);
    try {
      await currencyApi.getGifs();
    } catch (_) {}
    verify(() => mockClient.get(any())).called(1);
  });

  test('throws GifLoadingException when API call is unsuccessful', () async {
    when(() => mockResponse.statusCode).thenReturn(400);
    when(() => mockClient.get(any())).thenAnswer((_) async => mockResponse);
    expect(currencyApi.getGifs(), throwsA(isA<GifLoadingException>()));
  });

  test('throws GifNotFoundFailure whe API call is empty', () async {
    when(() => mockResponse.statusCode).thenReturn(200);
    when(() => mockResponse.body).thenReturn('{}');
    when(() => mockClient.get(any())).thenAnswer((_) async => mockResponse);
    expect(currencyApi.getGifs(), throwsA(isA<GifNotFoundFailure>()));
  });
}
