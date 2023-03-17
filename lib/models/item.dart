import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:uuid/uuid.dart';
import '/models/datahandler.dart';

class Item {
  final String id;
  final String parent;
  String name = "";


  Item({required this.id, required this.parent});
}

class MyItemList {
  List<Item> myItemList = [];
  late Future<String> root;
  Future <DataConnector> dataConnector = DataConnector.create();
  Uuid _uuid = Uuid();
  bool debug = false;

  @override
  String toString() {
    return "not implemented.";
  }

  //Main constructor
  MyItemList({this.debug = false});



  _createNewRoot() {
    Item rootItem = Item(
      id: _uuid.v4(),
      parent:"<root>",
    );
    rootItem.name = "<root>";
    myItemList.add(rootItem);
  }

}
