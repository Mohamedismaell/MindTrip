import 'package:hive_ce_flutter/adapters.dart';

import 'onboarding_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box box;
  static const _key = 'isfirsttime';

  OnboardingLocalDataSourceImpl({required this.box});

  @override
  bool getIsFirstTime() {
    return box.get(_key, defaultValue: true);
  }

  @override
  Future<void> saveIsFirstTime(bool value) async {
    await box.put(_key, value);
  }
}
