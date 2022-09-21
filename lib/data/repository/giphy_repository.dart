import 'package:gif/data/data.network/client/giphy_client.dart';
import 'package:gif/data/data.network/network_mapper.dart';
import '../../domain/gif.dart';

class GiphyRepository {
  final GiphyClient client;
  final NetworkMapper mapper;

  GiphyRepository({
    required this.client,
    required this.mapper,
  });

  Future<List<Gif>> getTrending({int? limit, int? offset, String? q}) async {
    final response = await client.getTrending(
      limit: limit,
      offset: offset,
      q: q,
    );
    return mapper.toGifs(response.data);
  }
}