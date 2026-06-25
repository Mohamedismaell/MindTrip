int parseInt(dynamic value) {
  if (value == null) return 0;

  if (value is int) return value;

  if (value is num) return value.toInt();

  return int.tryParse(value.toString()) ?? 0;
}

double parseDouble(dynamic value) {
  if (value == null) return 0.0;

  if (value is double) return value;

  if (value is num) return value.toDouble();

  return double.tryParse(value.toString()) ?? 0.0;
}

bool parseBool(dynamic value) {
  if (value is bool) return value;

  if (value is String) {
    return value.toLowerCase() == 'true';
  }

  if (value is num) {
    return value == 1;
  }

  return false;
}

int parseDay(dynamic value) {
  return parseInt(value);
}

List<String> parseStringList(dynamic value) {
  if (value is! List) return [];

  return value.whereType<String>().toList();
}
