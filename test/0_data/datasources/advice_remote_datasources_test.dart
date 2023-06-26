//gracias al paquete test en dev_dependencies podemos hacer el test
import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/datasources/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_models.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_remote_datasources_test.mocks.dart';
//import 'package:http/testing.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    "AdviceRemoteDatasource",
    () {
      group('should return AdviceModel', () {
        test('when Client response was 200 and has valid data', () async {
          // Ahora, dentro del test, van los Mocks, por eso esta el paquete Mockito en dev_dependencies, para facilitar la implementacion y el uso de los Mocks.
          final mockClient = MockClient();
          // debemos generar el mock
          final adviceRemoteDatasourceUnderTest =
              AdviceRemoteDataSourceImpl(client: mockClient);
          const responseBody = '{"advice": "test advice", "advice_id": 1}';

          when(mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          )).thenAnswer(
              (realInvocation) => Future.value(Response(responseBody, 200)));

          final result =
              await adviceRemoteDatasourceUnderTest.getRandomAdviceFromAPI();

          expect(result, AdviceModel(advice: 'test advice', id: 1));
        });
      });
    },
  );

  group('should throw', () {
    test('a ServerException when Client respoonse was not 200', () {
      final mockClient = MockClient();
      final adviceRemoteDatasourceUnderTest =
          AdviceRemoteDataSourceImpl(client: mockClient);

      when(mockClient.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {'content-type': 'application/json'},
      )).thenAnswer((realInvocation) => Future.value(Response('', 201)));

      expect(() => adviceRemoteDatasourceUnderTest.getRandomAdviceFromAPI(),
          throwsA(isA<ServerException>));
    });

    test('a Type Error when Client response was 200 and has not valid data',
        () {
      final mockClient = MockClient();
      final adviceRemoteDatasourceUnderTest =
          AdviceRemoteDataSourceImpl(client: mockClient);
      const responseBody = '{"advice": "test advice"}';

      when(mockClient.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {'content-type': 'application/json'},
      )).thenAnswer((realInvocation) => Future.value(Response(responseBody, 200)));

      expect(() => adviceRemoteDatasourceUnderTest.getRandomAdviceFromAPI(),
          throwsA(isA<TypeError>));
    });
  });
}

/*
! QUE SON LOS MOCKS ??

En Flutter, los mocks (simulacros o burlas en español) son objetos simulados que se utilizan en pruebas unitarias para reemplazar componentes o dependencias reales de una manera controlada. Los mocks se crean con el propósito de simular el comportamiento de un objeto real y permiten probar el código de forma aislada sin depender de componentes externos o servicios.

Los mocks son especialmente útiles cuando se prueban widgets, clases o métodos que dependen de otros objetos o servicios, como por ejemplo llamadas a API, bases de datos, sensores u otros módulos del sistema. Al utilizar mocks, puedes simular el comportamiento de estas dependencias para que la prueba se enfoque únicamente en el código que estás probando, sin afectar el entorno externo.

Algunas bibliotecas populares en Flutter, como Mockito, proporcionan herramientas y utilidades para crear y utilizar mocks de manera fácil y eficiente en las pruebas unitarias. Estas bibliotecas permiten definir el comportamiento esperado de los mocks y verificar que las interacciones con ellos ocurran según lo previsto.

Resumiendo, los mocks en Flutter son objetos simulados que se utilizan en pruebas unitarias para reemplazar dependencias reales y simular su comportamiento. Esto ayuda a aislar el código que se está probando y facilita la creación de pruebas más controladas y confiables.
*/