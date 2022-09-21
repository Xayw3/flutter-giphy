import 'package:flutter/material.dart';
import 'package:gif/data/data.network/client/giphy_client.dart';
import 'package:gif/data/data.network/network_mapper.dart';
import 'package:gif/data/repository/giphy_repository.dart';
import 'package:gif/keys.dart';
import 'package:gif/presentation/app/app.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final providers = createProviders();

  runApp(App(providers: providers));
}

List<SingleChildWidget> createProviders() {
  final log = Logger(printer: PrettyPrinter());
  final networkMapper = NetworkMapper();
  final giphyRepo = GiphyRepository(client: GiphyClient(
    baseUrl: 'https://api.giphy.com/',
    apiKey: giphyApiKey,
    log: log,
  ), mapper: networkMapper,);

  return [
    Provider<Logger>.value(value: log),
    Provider<GiphyRepository>.value(value: giphyRepo),
  ];
}
