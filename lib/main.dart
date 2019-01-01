import 'package:flutter/material.dart';
// import 'examples/simplefetch.dart' as SimpleFetch;
import 'excercises//simplefetch.dart' as SimpleFetchEx;

void main() {
  //runApp(MyApp(post: fetchPost()));
  //runApp(SimpleFetch.MyAppFetchExample(post: SimpleFetch.fetchPost()));
  //runApp(SimpleFetchEx.MyAppFetchExercise(mychecklist: SimpleFetchEx.loadCheckList()));
  runApp(SimpleFetchEx.MyAppFetchExercise2(allchecklist: SimpleFetchEx.loadAllCheckList(),));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}


