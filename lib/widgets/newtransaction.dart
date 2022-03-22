import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {

  const NewTransaction({Key? key, required this.newTx}) : super(key: key);
  final Function(String, double,DateTime) newTx;
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> with WidgetsBindingObserver{
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var _datePicked;

  void submitTx() {
    final String stext = titleController.text;
    final samount = double.parse(amountController.text);
    final datePickd = _datePicked;
    if (stext.isEmpty || samount <=0 || _datePicked==null) {
      return;
    }
    widget.newTx(stext, samount,datePickd);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _datePicked = value;
        });
      }
    });
  }
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifeCycleState(AppLifecycleState state)
  {
    print(state.toString());
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitTx,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) => submitTx,
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _datePicked==null ? 'Date not picked!' : 'Date:  ${DateFormat.yMd().format(_datePicked)}',

                    style: const TextStyle(color: Colors.black,fontSize: 15),
                    
                  ),
                  ElevatedButton(
                      onPressed: _showDatePicker,
                      child: const Text('Pick Date'))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  submitTx();
                },
                child: const Center(
                    child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
