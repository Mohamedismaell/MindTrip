import 'package:flutter/material.dart';

//Todo use freezed
class BudgetTierModel {
  const BudgetTierModel({
    required this.title,
    required this.amount,
    required this.icon,
  });

  final String title;
  final int amount;
  final IconData icon;
}
