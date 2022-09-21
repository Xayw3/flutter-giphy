import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gif/data/repository/giphy_repository.dart';
import 'package:gif/domain/gif.dart';
import 'package:gif/presentation/gifs/gifs_list_model.dart';
import 'package:gif/presentation/gifs/preview_gif.dart';
import 'package:gif/util/design_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


class GifsList extends StatefulWidget {
  const GifsList();

  @override
  State<GifsList> createState() => _GifsListState();
}

class _GifsListState extends State<GifsList> with DesignUtils {
  late final GifsListModel _model;

  final PagingController<int, Gif> _pagingController = PagingController(firstPageKey: 0);
  final _gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
  Object? _activeCallbackIdentity;

  @override
  void initState() {
    super.initState();

    _model = GifsListModel(
      Provider.of<Logger>(context, listen: false),
      Provider.of<GiphyRepository>(context, listen: false),
    );

    _pagingController.addPageRequestListener((offset) async {
      final callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;

      Timer.run(() async {
        try {
          final gifs = await _model.fetchGifs(offset);

          if (callbackIdentity == _activeCallbackIdentity) {
            _pagingController.appendPage(gifs, offset + GifsListModel.limit);
          }
        } catch (e) {
          if (callbackIdentity == _activeCallbackIdentity) {
            _pagingController.error = e;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Gif>(
      pagingController: _pagingController,
      gridDelegate: _gridDelegate,
      builderDelegate: PagedChildBuilderDelegate<Gif>(
        itemBuilder: (context, item, index) {
          return PreviewGif(gif: item, isInLeft: index.isEven,);
        }
      ),
    );
  }
}