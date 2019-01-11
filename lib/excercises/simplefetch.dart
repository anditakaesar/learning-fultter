import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

// a checklist class
class CheckList {
  final bool checked;
  final String id;
  final String description;

  CheckList({this.checked, this.id, this.description});

  factory CheckList.fromJson(Map<String, dynamic> json) {
    return CheckList(
        checked: json['checked'],
        id: json['_id'],
        description: json['description']
    );
  }
}

class OneCheckList {
  final bool success;
  final CheckList checkList;

  OneCheckList({this.success, this.checkList});

  factory OneCheckList.fromJson(Map<String, dynamic> json) {
    return OneCheckList(
      success: json['success'],
      checkList: CheckList.fromJson(json['checklist'])
    );
  }
}

class AllCheckList {
  final bool success;
  List<CheckList> checklists;

  AllCheckList({this.success, this.checklists});

  factory AllCheckList.fromJson(Map<String, dynamic> json) {
    var list = json['checklist'] as List;
    List<CheckList> tempChecklist = list.map((i) => CheckList.fromJson(i)).toList();

    return AllCheckList(
      success: json['success'],
      checklists: tempChecklist
    );
  }

  List<CheckList> getList() {
    return this.checklists;
  }


}

// load multiple
Future<AllCheckList> loadAllCheckList() async {
  final responseRaw =
  await http.get('https://heroku-njs.herokuapp.com/list');
  final jsonResponse = json.decode(responseRaw.body);

  if (responseRaw.statusCode == 200) {
    return AllCheckList.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load checklist data');
  }
}

// load one response
Future<OneCheckList> loadCheckList() async {
  final responseRaw =
      await http.get('https://heroku-njs.herokuapp.com/list/5c265a933a63cc00153acede');
  final jsonResponse = json.decode(responseRaw.body);
  
  if (responseRaw.statusCode == 200) {
    return OneCheckList.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load checklist data'); 
  }
  
}

class MyAppFetchExercise extends StatelessWidget {
  final Future<OneCheckList> mychecklist;

  MyAppFetchExercise({Key key, this.mychecklist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Exercise',
      home: Scaffold(
        appBar: AppBar(title: Text('Fetch Data Excercise'),
        ),
        body: Center(
          child: FutureBuilder<OneCheckList>(
            future: mychecklist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.checkList.description);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              /// default show loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }


}

class MyAppFetchExercise2 extends StatelessWidget {

  final Future<AllCheckList> allchecklist;

  MyAppFetchExercise2({Key key, this.allchecklist}) : super(key: key);

  Widget _buildRow(CheckList aList) {
    return ListTile(
      key: Key(aList.id),
      onTap: () {
        print('clicked with id: ' + aList.id);
      },
      title: Text("${aList.description}"),
      trailing: Icon(
        Icons.star, color: Colors.yellow[500],
      ),
    );
  }

  Widget _buildCheckList(List<CheckList> myList) {
    // myList.add(new CheckList(checked: true, id: 'abcde', description: 'hello list'));

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: myList.length,
      itemBuilder: (context, i) {
        return _buildRow(myList[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Exercise',
      home: Scaffold(
        appBar: AppBar(title: Text('Fetch Data Excercise'),
        ),
        body: Center(
          //child: _buildCheckList(),
          child: FutureBuilder(
            future: allchecklist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildCheckList(snapshot.data.checklists);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              /// default show loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}