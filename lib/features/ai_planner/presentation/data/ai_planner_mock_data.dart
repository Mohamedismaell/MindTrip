import 'package:flutter/material.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';

class AiPlannerMockData {
  AiPlannerMockData._();
  static const List<String> destinations = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Aswan',
    'Luxor',
    'Hurghada',
    'Sharm El-Sheikh',
    'Fayoum',
    'Sinai',
    'Matrouh',
  ];
  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static final List<BudgetTierModel> budgetTiers = const [
    BudgetTierModel(title: 'Basic', amount: 300, icon: Icons.savings_outlined),
    BudgetTierModel(
      title: 'Standard',
      amount: 500,
      icon: Icons.sentiment_satisfied_alt_outlined,
    ),
    BudgetTierModel(
      title: 'Comfort',
      amount: 1000,
      icon: Icons.auto_awesome_outlined,
    ),
    BudgetTierModel(
      title: 'Premium',
      amount: 2000,
      icon: Icons.workspace_premium_outlined,
    ),
  ];
}
