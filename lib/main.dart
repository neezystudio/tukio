// Defining routes for navigation
import 'package:flutter/material.dart';
import 'package:tukio/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tukio/widgets/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}
