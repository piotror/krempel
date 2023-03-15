import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class Item
{
  final String id;
  String name = "";

  Item({required this.id});
}

class MyItemList
{
  List <Item> myItemList=[];
  Uuid _uuid = Uuid();
  bool debug = false;

  @override
  String toString()
  {
    return "not implemented.";
  }

  //Main constructor
  MyItemList({this.debug=false})
  {
    //Load list from db or create a new one
    _loadList() ? (){if (debug) {
      print("No database to load, creating new environment");
    }}:_createNewRoot();
  }



//### Private functions
  bool _loadList() {
    return false;
  }

  _createNewRoot()
  {
    Item rootItem = Item(id: _uuid.v4(),);
    rootItem.name = "<root>";
    myItemList.add(rootItem);
    saveList();
  }

//### Public functions
  saveList()
  {
  }

}

