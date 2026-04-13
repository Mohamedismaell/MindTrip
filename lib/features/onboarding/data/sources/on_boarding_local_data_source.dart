import 'package:hive_ce_flutter/adapters.dart';

import 'onboarding_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box box;
  static const _key1 = 'isfirsttime';
  static const _key2 = 'selectedcategories';

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
