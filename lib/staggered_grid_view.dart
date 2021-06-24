import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredView extends StatelessWidget {
  final String imageListFileName;

  StaggeredView({Key? key, required this.imageListFileName}) : super(key: key);

  Future<Map> loadJson() async {
    Map imageTexts = await rootBundle
        .loadStructuredData('assets/config/$imageListFileName', (String s) async {
      return json.decode(s);
    });

    return Future.value(imageTexts);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJson(),
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          final int numOfEntries = snapshot.data!.length;
          return Scaffold(
            appBar: AppBar(
              title: const Text('testing grid view'),
            ),
            body: StaggeredGridView.count(
              primary: false,
              crossAxisCount: 4,
              staggeredTiles: <StaggeredTile>[
                for (int i = 1; i <= numOfEntries; i++)
                  StaggeredTile.fit(snapshot.data![i.toString()]["width"])
              ],
              children: <Widget>[
                for (int i = 1; i <= numOfEntries; i++)
                  _Tile(
                      snapshot.data![i.toString()]["source"],
                      i,
                      snapshot.data![i.toString()]["annotation"])
              ],
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.source, this.index, this.annotation);

  final String source;
  final int index;
  final String annotation;

  @override
  Widget build(BuildContext context) {
    final Image tileImage;
    if (source.startsWith('http')) {
      tileImage = Image.network(source);
    } else {
      tileImage = Image.asset('assets/$source');
    }
    return Card(
      child: Column(
        children: <Widget>[
          tileImage,
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  this.annotation,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}