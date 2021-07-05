import 'package:calculator_application/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './database.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:math_expressions/math_expressions.dart';

//user state for the app

final userProvider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(databaseProvider).getUserData();
});

// total state notifier for the app
final totalController =
    StateNotifierProvider<TotalNotifier, String>((ref) => TotalNotifier());

class TotalNotifier extends StateNotifier<String> {
  TotalNotifier() : super("");

  void evaluate(String input) {
    String finaluserinput = input.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    state = eval.toString();
  }

  void clear() {
    state = "";
  }
}

final userInputController = StateNotifierProvider.autoDispose<UserInputNotifier, String>(
    (ref) => UserInputNotifier());

class UserInputNotifier extends StateNotifier<String> {
  UserInputNotifier() : super("");

   String get() {
    return state;
  }

  void add(String value) {
    state = state + value;
  }

  void del() {
    state = state.substring(0, state.length - 1);
  }

  void clear() {
    state = "";
  }
}

// async state notifier provider for state that doesn't change in real time
/*final counterAsyncController =
    StateNotifierProvider<CounterAsyncNotifier, AsyncValue<int>>(
        (ref) => CounterAsyncNotifier(ref.read));

class CounterAsyncNotifier extends StateNotifier<AsyncValue<int>> {
  CounterAsyncNotifier(this.read) : super(AsyncLoading()) {
    //When it is being created it calls init to get the data first
    _init();
  }

  final Reader read;

  void _init() async {
    await read(databaseProvider).initDatabase();
    state = AsyncData(0);
  }

  void add() async {
    state = AsyncLoading();
    int count = await read(databaseProvider).increment();
    state = AsyncData(count);
  }

  void subtract() async {
    state = AsyncLoading();
    int count = await read(databaseProvider).decrement();
    state = AsyncData(count);
  }
}*/
