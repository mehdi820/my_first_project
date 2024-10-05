import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_project/database/db_manager.dart';
import 'package:my_first_project/new_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

transaction(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TransAction(),
    ),
  );
}

class _HomePageState extends State<HomePage> {
  DbManager dbManager = DbManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          " مدیریت مالی حساب ها",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          transaction(context);
        },
      ),
      body: FutureBuilder<Box<dynamic>>(
        future: Hive.openBox('box'),
        builder: (BuildContext context, AsyncSnapshot<Box<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Has Erorr"),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("no data"),
              );
            }else{}
            return Center(
              child: Text("correct"),
            );
          } else {
            return Center(
              child: Text("UnexErorr"),
            );
          }
        },
      ),
    );
  }
}
