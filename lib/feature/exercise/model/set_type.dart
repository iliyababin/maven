import 'package:flutter/material.dart';

class SetType {
  final String name;

  const SetType._(this.name);

  static const regular = SetType._('Regular');
  static const warmup = SetType._('Warmup');
  static const failure = SetType._('Failure');
  static const drop = SetType._('Drop');
  static const cooldown = SetType._('Cool-down');

  String get abbreviated => name.substring(0, 1).toUpperCase();

  Color color(BuildContext context) {
    switch (this) {
      case SetType.regular:
        return mt(context).color.primary;
      case SetType.warmup:
        return mt(context).color.warmup;
      case SetType.failure:
        return mt(context).color.error;
      case SetType.drop:
        return mt(context).color.drop;
      case SetType.cooldown:
        return mt(context).color.cooldown;
    }
    return Colors.transparent;
  }

  static SetType fromName(String setTypeString) {
    switch (setTypeString) {
      case 'Regular':
        return SetType.regular;
      case 'Warmup':
        return SetType.warmup;
      case 'Failure':
        return SetType.failure;
      case 'Drop':
        return SetType.drop;
      case 'Cool-down':
        return SetType.cooldown;
    }
    return SetType.regular;
  }

  static const values = [
    regular,
    warmup,
    failure,
    drop,
    cooldown,
  ];
}