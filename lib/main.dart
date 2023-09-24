import 'package:flutter/material.dart';
import 'package:tugas_3/transaction.dart';
import 'package:intl/intl.dart';
import 'add_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Transaction transaction = Transaction(); 
  List data = []; 
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    List getData = await transaction.getData();
    setState(() {
      data = getData.reversed
          .toList(); 
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Apps'),
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), 
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, item) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: data[item]['type'] == 'In'
                          ? Column(
                              children: [
                                Icon(Icons.arrow_downward),
                                Text('In')
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(Icons.arrow_upward),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Out')
                              ],
                            ),
                      title: Text(
                        '${data[item]['description']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Date: ${data[item]['date']} \n'
                        'Amount: Rp. ${NumberFormat('###,###').format(int.parse(data[item]['amount']))}',
                      ),
                    ),
                  ], 
                ); 
              },
            ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddForm(),
            ),
          );
        },
        child: Icon(Icons.add), 
        backgroundColor: Colors.blue, 
      ),
    );
  }
}
