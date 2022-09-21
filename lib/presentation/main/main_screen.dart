import 'package:flutter/material.dart';
import 'package:gif/presentation/gifs/gifs_list_model.dart';
import 'package:gif/util/design_utils.dart';
import 'package:provider/provider.dart';
import '../gifs/gifs_list.dart';

class MainScreen extends StatelessWidget with DesignUtils {
  final _textController = TextEditingController();


  @override
  Widget build(BuildContext search) {
    String searchParam = 'joke';
    return Provider(
      create: (search) => searchParam,
      child: Scaffold(
        appBar: AppBar(
            title: TextField(
              controller: _textController,
              onChanged: (String) {
                searchParam = _textController.text;
              },
              decoration: InputDecoration(
                hintText: 'search',
                prefixIcon: Icon(Icons.search),
              ),
            )

        ),
        body: const GifsList(),
      ),
    );
  }
}