import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    if (title.isEmpty || amount < 0 || selectedDate == null) {
      return;
    }

    widget.addTransaction(title, amount, selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Text(selectedDate == null
                          ? 'No date choosen!'
                          : DateFormat.yMd().format(selectedDate)),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: presentDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(color: Colors.amber[900]),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    'Add transaction',
                    // style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[500])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
