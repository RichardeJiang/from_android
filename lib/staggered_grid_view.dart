import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredView extends StatelessWidget {

  Future<Map> loadJson() async {
    Map imageTexts = await rootBundle
        .loadStructuredData('assets/config/staggered_text.json', (String s) async {
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('testing grid view'),
            ),
            body: StaggeredGridView.count(
              primary: false,
              crossAxisCount: 4,
              staggeredTiles: const <StaggeredTile>[
                StaggeredTile.fit(1),
                StaggeredTile.fit(2),
                StaggeredTile.fit(1),
                StaggeredTile.fit(2),
                StaggeredTile.fit(1),
                StaggeredTile.fit(2),
                StaggeredTile.fit(2),
                StaggeredTile.fit(2),
              ],
              children: <Widget>[
                _Tile(
                  //'https://cdn.pixabay.com/photo/2013/04/07/21/30/croissant-101636_960_720.jpg',
                    snapshot.data!["1"],
                    1),
                _Tile(
                  //'https://cdn.pixabay.com/photo/2016/01/22/16/42/eiffel-tower-1156146_960_720.jpg',
                    'rodion-kutsaev.jpeg',
                    2),
                _Tile(
                  //'https://cdn.pixabay.com/photo/2016/10/22/20/34/two-types-of-wine-1761613_960_720.jpg',
                    'efe-kurnaz.jpg',
                    3),
                _Tile(
                    'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197_960_720.jpg',
                    4),
                _Tile(
                    'https://cdn.pixabay.com/photo/2016/11/16/10/59/mountains-1828596_960_720.jpg',
                    5),
                _Tile(
                    'steve-johnson.jpeg',
                    6),
                _Tile(
                    'https://cdn.pixabay.com/photo/2017/08/24/22/37/gyrfalcon-2678684_960_720.jpg',
                    7),
                _Tile(
                    'https://cdn.pixabay.com/photo/2013/01/17/08/25/sunset-75159_960_720.jpg',
                    8),
              ],
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
  const _Tile(this.source, this.index);

  final String source;
  final int index;

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
          //Image.network(source),
          tileImage,
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                Text(
                  'Image number $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Vincent Van Gogh',
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