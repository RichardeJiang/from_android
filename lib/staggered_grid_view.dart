import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:from_android/appbar_view.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'backend.dart';

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
      //future: loadJson(),
      future: Backend.getGalleryList("life"),
      builder: (context, AsyncSnapshot<List<ParseObject>> snapshot) {
        if (snapshot.hasData) {
          final int numOfEntries = snapshot.data!.length;
          return Scaffold(
            appBar: CustomizedAppBar(),
            body: StaggeredGridView.count(
              primary: false,
              crossAxisCount: 4,
              staggeredTiles: <StaggeredTile>[
                for (int i = 0; i < numOfEntries; i++)
                  StaggeredTile.fit(snapshot.data![i].get<int>('width')!)
              ],
              children: <Widget>[
                for (int i = 0; i < numOfEntries; i++)
                  _Tile(
                      snapshot.data![i].get<ParseFileBase>("source")!.url!,
                      i,
                      snapshot.data![i].get<String>("annotation")!)
              ],
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
            ),
          );
        } else {
          return Scaffold(
            appBar: CustomizedAppBar(),
            body: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Color(0xFF162A49)
                  )
            ))
          );
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