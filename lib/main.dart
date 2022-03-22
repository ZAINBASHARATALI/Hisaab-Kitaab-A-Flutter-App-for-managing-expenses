import 'package:flutter/material.dart';
import '../widgets/chart.dart';
import '../widgets/newtransaction.dart';
import 'models/transactions.dart';
import 'widgets/transactionList.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        textTheme: const TextTheme(caption: TextStyle(color: Colors.red)),
        primaryColor: Colors.redAccent,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.redAccent,
          primarySwatch: Colors.red,
        )),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(newTx: _addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transactions> _transactions = [
    //Transactions(id: 'id', title: 'ok', amount: 9.9, date: DateTime.now())
  ];

  List<Transactions> get _recentTransactions {
    return _transactions.where(
      (element){
        return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
      }).toList();
  }

  void _addTransaction(String txtitle, double txamount,DateTime datePick) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: datePick,
    );
    setState(() {
      _transactions.add(newTx);
    });
  }
  void _deleteTransaction(String tId)
  {
    setState(() {
      _transactions.removeWhere((element) => element.id==tId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        title: const Text('Hisaab Kitaab'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(
                Icons.add,
                size: 25,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             Chart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions,deleteTx:_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
