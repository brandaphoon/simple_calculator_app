import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_application/providers.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riverpod Simplified")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
                return watch(userProvider).when(data: (String value) {
                  //"When" includes the whole object accounting for error, "maybeWhen" is only orElse and "map" is just the data itself
                  return Text(value);
                }, error: (Object error, StackTrace stackTrace) {
                  return Text("Error");
                }, loading: () {
                  return CircularProgressIndicator();
                });
              },
            ),
            SizedBox(
              height: 100,
            ),
            Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
                return Text("Basic: " + watch(counterController).toString());
              },
            ),
            SizedBox(
              height: 100,
            ),
            Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
                return watch(counterAsyncController).when(
                  data: (int value) {
                    return Text("AsyncValue: " + value.toString());
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return Text("error");
                  },
                  loading: () {
                    return CircularProgressIndicator();
                  },
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                context.read(counterController.notifier).add();
                context.read(counterAsyncController.notifier).add();
              },
            ),
            ElevatedButton(
              child: Text("Subtract"),
              onPressed: () {
                context.read(counterController.notifier).subtract();
                context.read(counterAsyncController.notifier).subtract();
              },
            )
          ],
        ),
      ),
    );
  }
}
