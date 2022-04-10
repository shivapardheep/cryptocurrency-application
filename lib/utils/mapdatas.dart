import 'package:flutter/material.dart';
import 'dart:convert';

class MapDatas {
  final String name;
  final String age;

  MapDatas({required this.name, required this.age});

  factory MapDatas.fromJson(Map<String, dynamic> _json) {
    return new MapDatas(
      name: _json['name'],
      age: _json['age'],
    );
  }
}
