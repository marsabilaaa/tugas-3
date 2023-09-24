import 'package:flutter/material.dart';
import 'package:tugas3/main.dart';
import 'package:tugas3/transaction.dart';
import 'package:intl/intl.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController description = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Transaction transaction = Transaction();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          selectedTime = pickedTime;
          date.text = DateFormat('dd-MM-yyyy HH:mm')
              .format(selectedDate); 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter the description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                items: ['In', 'Out'].map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    type.text = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Type',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amount,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter the amount';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date and Time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: date,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter the date and time';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    transaction.saveData(
                      description.text,
                      type.text,
                      amount.text,
                      date.text,
                    );

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(), 
                      ),
                      (Route<dynamic> route) =>
                          false,
                    );
                  }
                },
                child: Text('Submit Button'),
              )
            ],
          ),
        ),
      ),
    );
  }
}