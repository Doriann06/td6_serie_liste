import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/models/serie.dart';

void main() {
  group('Serie', () {
    // JSON complet tel que retourné par l'API TVMaze
    final jsonComplet = {
      'id': 1,
      'name': 'Breaking Bad',
      'genres': ['Drama', 'Crime'],
      'status': 'Ended',
      'image': {'medium': 'https://example.com/bb.jpg'},
      'summary': '<p>Un professeur de chimie…</p>',
      'rating': {'average': 9.5},
    };

    test('fromJson crée une Serie correctement', () {
      final serie = Serie.fromJson(jsonComplet);

      expect(serie.id, 1);
      expect(serie.nom, 'Breaking Bad');// TODO : vérifier que le nom est correctement extrait du champ "name"
      expect(serie.genre, 'Drama');// TODO : vérifier que le genre est correctement extrait du champ "genres"
      expect(serie.statut, 'Ended');// TODO : vérifier que les champs de la série sont correctement initialisés à partir du JSON
      expect(serie.note, 9.5);// TODO : vérifier que la note est correctement extraite du champ "rating"
      expect(serie.imageUrl, 'https://example.com/bb.jpg');// TODO : vérifier que les champs de la série sont correctement initialisés à partir du JSON
    });

    test('fromJson supprime les balises HTML du synopsis', () {
      final serie = Serie.fromJson(jsonComplet);

      expect(serie.synopsis, 'Un professeur de chimie…');// TODO : vérifier que le synopsis est correctement nettoyé des balises HTML
      expect(serie.synopsis, isNot(contains('<p>')));// TODO : vérifier que le synopsis ne contient pas de balises HTML
      //        (indice : expect(..., isNot(contains(...))))
    });

    test('fromJson gère les champs optionnels absents', () {
      final jsonMinimal = {'id': 2, 'name': 'Test'};
      final serie = Serie.fromJson(jsonMinimal);

      expect(serie.note, isNull);// TODO : vérifier que la note est nulle
      expect(serie.genre, 'Inconnu');// TODO : vérifier que le genre est "Inconnu"
      expect(serie.synopsis, '');// TODO : vérifier que le synopsis est une chaîne vide
    });

    test('toJson / fromJson sont symétriques', () {
      final original = Serie.fromJson(jsonComplet);

      final reconstruite = Serie.fromJson(original.toJson());
      expect(reconstruite.id, original.id);  // TODO : vérifier que la série reconstruite a le même id que original
      expect(reconstruite.nom, original.nom);  // TODO : vérifier que la série reconstruite a le même nom que original
      expect(reconstruite.note, original.note);  // TODO : vérifier que la série reconstruite a la même note que original
    });
  });
}
