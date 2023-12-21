import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'actions/todoAction.dart';
import 'views/home.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String message) {
  final snackBar = SnackBar(content: Text(message));
  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoModel(),
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    ),
  );
}
