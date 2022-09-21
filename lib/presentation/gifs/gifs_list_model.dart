import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gif/data/repository/giphy_repository.dart';
import 'package:gif/domain/gif.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class GifsListModel {

  @override
  Widget build(BuildContext search) {
    return Text(
      q = Provider.of<String>(search)
    );
  }
  static const limit = 20;
  var q = '';

  final Logger log;
  final GiphyRepository giphyRepo;

  GifsListModel(this.log, this.giphyRepo);

  Future<List<Gif>> fetchGifs(int offset) async {
    try {
      return await giphyRepo.getTrending(
        offset: offset,
        limit: limit,
        q: q.toString(),
      );
    } catch (e) {
      log.e('Error while testing trending: $e');
      rethrow;
    }
  }
}