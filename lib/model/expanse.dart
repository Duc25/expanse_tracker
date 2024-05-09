import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

final uuid = Uuid().v4();

enum Category { food, leisure, work, travel }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_land,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

class Expanse {
  Expanse({
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
  }) : id = uuid;
  final String title;
  final DateTime date;
  final double amount;
  final String id;
  final Category category;

  get formatDate {
    return formatter.format(date);
  }
}

class ExpanseBucket {
  const ExpanseBucket({
    required this.category,
    required this.expanses,
  });

  ExpanseBucket.forCategory(List<Expanse> allExpanses, this.category)
      : expanses = allExpanses
            .where((expanse) => expanse.category == category)
            .toList();

  final Category category;
  final List<Expanse> expanses;

  double get totalExpanses {
    double sum = 0;
    for (var expanse in expanses) {
      sum += expanse.amount;
    }
    return sum;
  }
}
