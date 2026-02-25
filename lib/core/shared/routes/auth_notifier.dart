// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthNotifier extends ChangeNotifier {
//   bool isRecoveringPassword = false;
//   final SupabaseClient _supabaseClient;
//   late final StreamSubscription<AuthState> _subscription;

//   AuthNotifier(this._supabaseClient) {
//     _subscription = _supabaseClient.auth.onAuthStateChange.listen((event) {
//       debugPrint("***Event  ${event.event.name}***");
//       if (event.event == AuthChangeEvent.passwordRecovery) {
//         isRecoveringPassword = true;
//       }

//       if (event.event == AuthChangeEvent.signedOut) {
//         isRecoveringPassword = false;
//       }
//       notifyListeners();
//     });
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }
