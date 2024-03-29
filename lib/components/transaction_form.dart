import 'package:flutter/material.dart';
import 'adaptative_button_ios.dart';
import 'adaptative_text_field.dart';
import 'adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: <Widget>[
            AdaptativeTextField(
              label: 'Titulo',
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.text,             
            ),
            AdaptativeTextField(
              label: 'Valor (R\$)',
              controller: _valueController,
              keyboardType:  TextInputType.numberWithOptions(decimal: true), 
              onSubmitted: (_) => _submitForm(),             
            ),
           AdaptativeDatePicker(
             selectedDate: _selectedDate,
             onDateChange: (newDate){
               setState(() {
                 _selectedDate = newDate;
               });
             } ,
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AdaptativeButton(
                  label: 'Nova Transação',
                  onPressed: _submitForm,
                ),
               /*  ElevatedButton(
                  child: const Text('Nova transação'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    _submitForm;
                  },
                ), */
              ],
            )
          ]),
        ),
      ),
    );
  }
}
