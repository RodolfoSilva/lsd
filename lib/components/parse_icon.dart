import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

IconData parseIcon(String? icon) {
  switch (icon) {
    case 'home':
      return FeatherIcons.home;

    case 'question_mark':
      return Icons.question_mark;

    case 'bar_chart':
      return FeatherIcons.barChart2;

    case 'add':
      return FeatherIcons.plus;

    case 'calendar':
      return FeatherIcons.calendar;

    case 'shopping_bag':
      return FeatherIcons.shoppingBag;

    case 'people':
      return FeatherIcons.users;

    case 'remove':
      return FeatherIcons.x;

    case 'menu':
      return FeatherIcons.menu;

    case 'more':
      return FeatherIcons.moreHorizontal;

    case 'options':
      return FeatherIcons.moreVertical;

    default:
      return FeatherIcons.alertOctagon;
  }
}
