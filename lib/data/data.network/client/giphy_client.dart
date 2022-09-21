import 'dart:convert';
import 'package:gif/data/data.network/client/base_client.dart';
import 'package:logger/logger.dart';
import '../entity/response_entity.dart';

class GiphyClient extends BaseClient {
  late final String baseUrl;
  late final String apiKey;

  GiphyClient({
    required this.baseUrl,
    required this.apiKey,
    required Logger log,
  }) : super(log: log);

  Future<ResponseEntity> getTrending({int? limit, int? offset, String? q}) async {
    final params = {
      'api_key': apiKey,
    };

    if (limit != null) {
      params['limit'] = limit.toString();
    }

    if (offset != null) {
      params['offset'] = offset.toString();
    }

    if (q != null) {
      params['q'] = q.toString();
    }

    final response =
    await get('${baseUrl}v1/gifs/search', queryParameters: params);

    checkKo(response, 'get_trending', body: params.toString());

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return ResponseEntity.fromJson(json);
  }
}