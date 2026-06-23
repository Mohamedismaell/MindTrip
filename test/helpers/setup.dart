import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HydratedBloc.storage = MemoryStorage();
  });

  setUp(() async {
    await HydratedBloc.storage.clear();
  });
}
