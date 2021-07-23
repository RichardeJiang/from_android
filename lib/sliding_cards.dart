import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:from_android/staggered_grid_view.dart';

import 'group_chat_view.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: '“顶楼”',
            annotation: '众星云集，无与伦比，数理化，生',
            assetName: 'steve-johnson.jpeg',
            offset: pageOffset,
          ),
          SlidingCard(
            name: '亚健康生活部',
            annotation: '楼长室长大家，还有夜奔',
            assetName: 'rodion-kutsaev.jpeg',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            name: '米娜桑',
            annotation: '2012.06.08 - Present',
            assetName: 'efe-kurnaz.jpg',
            offset: pageOffset - 2,
          ),
          SlidingCard(
            name: '过去现在将来，和墙',
            annotation: '某个不愿意轻易透露姓名的王家庄人',
            assetName: 'steve-johnson.jpeg',
            offset: pageOffset - 3,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String annotation;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key? key,
    required this.name,
    required this.annotation,
    required this.assetName,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.4,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: annotation,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent({
      Key? key,
      required this.name,
      required this.date,
      required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
      primary: Color(0xFF162A49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    );
    final String imageListFileName = this.name.startsWith("S")
        ? "origin.json" : this.name.startsWith("D")
          ? "fly.json" : "life.json";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: ElevatedButton(
                  style: style,
                  child: Transform.translate(
                    offset: Offset(6 * offset, 0),
                    child: (() {
                      if (!this.name.startsWith("过")) {
                        return Text('一个按键');
                      } else {
                        return Text('又一个按键');
                      }
                    }())
                  ),
                  onPressed: () {
                    // Go inside the photos or home letters
                    if (!this.name.startsWith("过")) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StaggeredView(
                                imageListFileName: imageListFileName,
                              )
                          )
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupChat()));
                    }
                  },
                ),
              ),
              Spacer(),
              // Transform.translate(
              //   offset: Offset(16 * offset, 0),
              //   child: Text(
              //     '0.00 \$',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //     ),
              //   ),
              // ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
