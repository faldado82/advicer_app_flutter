import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/advice_models.dart';
import 'exceptions/exceptions.dart';

abstract class AdviceRemoteDataSource {
  /// request a random advice from api
  /// returns [AdviceModel] if successful
  /// throws a server-exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromAPI();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;
  AdviceRemoteDataSourceImpl({required this.client});

  @override
  Future<AdviceModel> getRandomAdviceFromAPI() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJSON(responseBody);
    }
  }
}
