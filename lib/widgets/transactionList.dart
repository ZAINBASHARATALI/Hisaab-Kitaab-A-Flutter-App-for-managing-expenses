import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function(String) deleteTx;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? Column(
            children: transactions.map((trnxn) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                //padding: const EdgeInsets.all(10),
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    deleteTx(trnxn.id);
                  },
                  child: Card(
                    elevation: 4,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'Rs ${trnxn.amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trnxn.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(trnxn.date),
                              style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        : Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: LottieBuilder.asset('Assets/nohissab.json'),
              ),
              const Text(
                'No Hisaab Exists',
                style: TextStyle(fontSize: 20),
              ),
            ],
          );
  }
}
