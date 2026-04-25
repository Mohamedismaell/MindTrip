import 'package:hive_ce_flutter/adapters.dart';

abstract class OnboardingLocalDataSource {
  bool getIsFirstTime();
  Future<void> saveIsFirstTime(bool value);
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box box;
  static const _key1 = 'isfirsttime';

  OnboardingLocalDataSourceImpl({required this.box});

  @override
  bool getIsFirstTime() {
    return box.get(_key1, defaultValue: true);
  }

  @override
  Future<void> saveIsFirstTime(bool value) async {
    await box.put(_key1, value);
  }
}
