import 'package:hive_ce_flutter/adapters.dart';

class AppHive {
  static late Box<bool> onboardingBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    await openBoxes();
  }

  static void registerAdapters() {
    // if (!Hive.isAdapterRegistered(ArticleDtoAdapter().typeId)) {
    //   Hive.registerAdapter(ArticleDtoAdapter());
    // }
  }

  static Future<void> openBoxes() async {
    onboardingBox = await Hive.openBox<bool>('onboardingBox');
  }
}
