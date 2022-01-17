import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const AddTransaction({Key? key, required this.addNewTransaction})
      : super(key: key);
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? dateSelected;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  void _startShowDateChooser() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) => dateSelected = value);
  }

  void _handleAddNewTransaction() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        double.parse(_amountController.text) < 0 ||
        dateSelected == null) {
      return;
    }
    widget.addNewTransaction(_titleController.text,
        double.parse(_amountController.text), dateSelected);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 0,
            top: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text('Title')),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _handleAddNewTransaction(),
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Amount')),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _handleAddNewTransaction(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: dateSelected != null
                      ? Text(
                          'Date selected: ${DateFormat.yMEd().format(dateSelected as DateTime)}')
                      : Text('No date chooser'),
                ),
                TextButton(
                    onPressed: () => _startShowDateChooser(),
                    child: const Text('Choose date'))
              ],
            ),
            Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _handleAddNewTransaction(),
                  child: const Text('Add'),
                )),
          ],
        ));
  }
}
