import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';

abstract class OnboardingLocalDataSource {
  bool getIsFirstTime();
  Future<void> saveIsFirstTime(bool value);
  Future<void> clearOnboardingBox();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box _onboardingBox;
  static const _key1 = 'isfirsttime';

  OnboardingLocalDataSourceImpl() : _onboardingBox = AppHive.onboardingBox;

  @override
  bool getIsFirstTime() {
    return _onboardingBox.get(_key1, defaultValue: true);
  }

  @override
  Future<void> clearOnboardingBox() async {
    await _onboardingBox.clear();
  }

  @override
  Future<void> saveIsFirstTime(bool value) async {
    await _onboardingBox.put(_key1, value);
  }
}
