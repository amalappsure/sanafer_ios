import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ContextWrapper {
  ContextWrapper({required this.context, required this.number}){
    print('##number: $number');
  }
  final BuildContext context;
  final int number;

}

final homeContextProvider = StateProvider<ContextWrapper?>((ref) => null);
