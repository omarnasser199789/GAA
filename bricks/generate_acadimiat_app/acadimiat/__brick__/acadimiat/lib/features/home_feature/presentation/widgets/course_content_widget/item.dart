import 'package:flutter/material.dart';

class Item {
  Item({required this.header,required this.body,required this.isExpanded});
  Widget header;
  Widget body;
  bool isExpanded;
}