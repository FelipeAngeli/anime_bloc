import 'dart:convert';

import 'package:anime_bloc/app/services/http_client_interface.dart';
import 'package:anime_bloc/app/services/json_placeholder_service.dart';
import 'package:dio/native_imp.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements DioForNative {}

class IhttpClientMock extends Mock implements IhttpClient {}

void main() {
  test('deve retornar Id, Date, Title', () async {
    final client = IhttpClientMock();
    when(() => client.get(url))
        .thenAnswer((_) async => jsonDecode(jsonResponse));

    final service = JsonPlaceholderService(client);
    final todos = await service.getTodos();
    expect(todos[0].id, 96926);
  });
}

const jsonResponse =
    r'''[
    {
      "id": 96926,
      "date": "2022-01-31T21:31:11",
      "title": {
        "rendered": "Arifureta – Autor anuncia que a novel acaba no próximo volume"}
    },
    {
      "id": 96931,
      "date": "2022-01-31T21:30:48",
      "title": {
        "rendered": "KonoSuba tem anuncio de nova light novel, mas com autor diferente"}
    }
  ]''';
