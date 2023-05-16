import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'core/config/firebase/firebase_options.dart';
import 'data/repositories/interfaces/authentication_repository.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();

  final authenticationRepository = di.sl<AuthenticationRepository>();
  await authenticationRepository.user.first;

  runApp(const AppWidget());
}
