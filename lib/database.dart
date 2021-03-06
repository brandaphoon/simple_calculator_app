import 'package:flutter_riverpod/flutter_riverpod.dart';

//Used for other files to read and use database functions
final databaseProvider = Provider<Database>((ref) => Database());

class Database {
  Future<String> getUserData() {
    return Future.delayed(Duration(seconds: 3), () {
      return "Branda";
    });
  }

  /*int fakeDatabase;

  Future<void> initDatabase() async {
    fakeDatabase = 0;
  }

  Future<int> increment() async {
    return Future.delayed(Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase + 1;
    });
  }

  Future<int> decrement() async {
    return Future.delayed(Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase - 1;
    });
  }*/
}
