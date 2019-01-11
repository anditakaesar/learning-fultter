import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MyAppLayoutUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'St. Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
          ParentUI(),
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      )
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
          '''
      Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
            children: <Widget>[
              Image.asset('images/lake.jpg', height: 240.0, fit: BoxFit.cover,),
              titleSection,
              buttonSection,
              textSection,
            ]
        ),
      ),
    );
  }
}

// parent manage state
class ParentUI extends StatefulWidget {
  @override
  _ParentUIState createState() => _ParentUIState();
}

class _ParentUIState extends State<ParentUI> {
  bool _active = false;
  int _favCount = 60;

  void _handleTapChanged(bool newValue) {
    setState(() {
      _active = newValue;
      _favCount = (_active) ? (this._favCount += 1) : (this._favCount -= 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FavWidget(isFavorited: _active,
        favoriteCount: _favCount,
        onChanged: _handleTapChanged);
  }

}

class FavWidget extends StatelessWidget {
  FavWidget({Key key, this.isFavorited: false, @required this.favoriteCount, @required this.onChanged}
      ) : super(key: key);

  final bool isFavorited;
  final ValueChanged<bool> onChanged;
  final int favoriteCount;

  void _handleTap() {
    onChanged(!isFavorited);
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
              icon: ((isFavorited) ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_border)),
              color: Colors.red[500],
              onPressed: _handleTap),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            child: Text('$favoriteCount'),
          ),
        )
      ],
    );
  }
}
// parent manage state

// child manage it's own state
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
              icon: ((_isFavorited) ? Icon(Icons.star) : Icon(
                  Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}
// child manage it's own state