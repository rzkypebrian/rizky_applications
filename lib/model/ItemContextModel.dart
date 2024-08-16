import 'package:flutter/material.dart';

///
/// Helper class that makes the relationship between
/// an item index and its BuildContext
///
class ItemContextModel {
  final BuildContext context;
  final int id;
  final String name;
  final dynamic data;

  ItemContextModel({
    this.context,
    this.id,
    this.name,
    this.data,
  });
}
