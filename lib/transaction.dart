import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Transaction {

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> itemStrings = prefs.getStringList('transactions') ?? [];

    return itemStrings
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();
  }

  saveData(
    String description,
    String type,
    String amount,
    String date,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> dataList = prefs.getStringList('transactions') ?? [];

    Map<String, String> newData = {
      'description': description,
      'type': type,
      'amount': amount,
      'date': date
    };

    dataList.add(jsonEncode(newData)); 
    prefs.setStringList(
      'transactions',
      dataList,
    ); 
  }
}