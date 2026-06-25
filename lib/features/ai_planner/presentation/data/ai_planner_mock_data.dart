import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';

class AiPlannerMockData {
  AiPlannerMockData._();
  static const List<String> destinations = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Ismailia',
    'Port Said',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Fayoum',
    'Sharm El Sheikh',
    'Marsa Matrouh',
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
    BudgetTierModel(title: '🙂 Basic', amount: 300),
    BudgetTierModel(title: '💸 Standard', amount: 500),
    BudgetTierModel(title: '✨ Comfort', amount: 1000),
    BudgetTierModel(title: '👑 Premium', amount: 2000),
  ];
}
