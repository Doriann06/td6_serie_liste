import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/services/serie_api_service.dart';
import '../../helpers/test_data.dart';
import '../../mocks/mock_http_client.dart';

void main() {
  group('SerieApiService', () {
    test('fetchSeries retourne une liste de Series en cas de succès', () async {
      final service=SerieApiService(client: MockHttpClient(body:mockSeriesJson));
      final series = await service.fetchSeries();
      expect(series.length, 2);// TODO : vérifier que la liste contient 2 séries
      expect(series[0].nom, 'Breaking Bad');
      expect(series[1].nom, 'Stranger Things');
    });
    test('fetchSeries lève une exception si le statut est 500', () async {
      final service=SerieApiService(client: MockHttpClient(statusCode:500,body: ''),);
      expect(() => service.fetchSeries(), throwsException);// TODO : vérifier que fetchSeries lance une exception
    });
    test('fetchSerieById retourne la bonne série', () async {
      final service=SerieApiService(client: MockHttpClient(body:mockSeriesJson[0]),);
      final serie = await service.fetchSerieById(1);
      expect(serie.id, 1);
      expect(serie.nom, 'Breaking Bad');
    });
  test('getMockSeries retourne une liste non vide', () {
      final service=SerieApiService();
      expect(service.getMockSeries(), isNotEmpty);// TODO : vérifier que getMockSeries retourne une liste non vide
    });
  });
}