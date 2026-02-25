import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<HydratedStorage> buildHydratedStorage() async {
  if (kIsWeb) {
    return HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory.web,
    );
  }

  final dir = await getTemporaryDirectory();
  return HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(dir.path),
  );
}
