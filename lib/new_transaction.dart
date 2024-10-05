import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_first_project/database/db_manager.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TransAction extends StatefulWidget {
  const TransAction({super.key});

  @override
  State<TransAction> createState() => _HomePageState();
}

class _HomePageState extends State<TransAction> {
  String type = "Income";
  DateTime selectedDate = DateTime.now();
  int amount = 0;
  String description = "";

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (picked != selectedDate && picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          " ثبت تراکنش جدید",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 10, left: 10, top: 20),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "مبلغ تراکنش",
              icon: Icon(
                Icons.monetization_on_outlined,
                color: Colors.deepPurple,
              ),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              try {
                amount = int.parse(val);
              } catch (e) {}
            },
          ),
          Gap(20),
          TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "شرح تراکنش",
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.deepPurple,
              ),
              border: OutlineInputBorder(),
            ),
            maxLength: 40,
            onChanged: (val) {
              try {
                description = val;
              } catch (e) {
                print("Error opening box: $e");
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoiceChip(
                checkmarkColor: Colors.white,
                label: Text(
                  "هزینه",
                  style: TextStyle(
                      color:
                          type == "Expense" ? Colors.white : Colors.deepPurple),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Colors.red,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
              Gap(15),
              ChoiceChip(
                checkmarkColor: Colors.white,
                label: Text(
                  "درآمد",
                  style: TextStyle(
                      color: type == "Expense" ? Colors.black : Colors.white),
                ),
                selected: type == "Income" ? true : false,
                selectedColor: Colors.green,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              Gap(60),
              TextButton(
                onPressed: () {
                  _selectedDate(context);
                },
                child: Text(
                  " ${months[selectedDate.month - 1]} ${selectedDate.day}",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     Jalali? picked = await showPersianDatePicker(
              //       context: context,
              //       initialDate: Jalali.now(),
              //       firstDate: Jalali(1385),
              //       lastDate: Jalali(1450),
              //     );
              //   },
              //   child: Text(
              //     "تاریخ تراکنش",
              //     style: TextStyle(fontSize: 20),
              //   ),
              // )
            ],
          ),
          Gap(30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                print(description);
                print(amount);
                if (amount != 0 && description!="") {
                  DbManager dbManager = DbManager();
                  dbManager.addData(amount, description, selectedDate, type);
                } else {
                  print("wrong");
                }
              },
              child: Text(
                "افزودن تراکنش",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
