// lib/config/app_routes.dart

import 'package:flutter/material.dart';
import '/presentation/screens/home_screen.dart';
import '/presentation/screens/store_screen.dart';
import '/presentation/screens/history_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomeScreen(),
  '/store': (context) => StoreScreen(),
  '/history': (context) => HistoryScreen(),
};