import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/widgets/button_widget.dart';
import 'package:test_app/widgets/text_widget.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final scrollController = ScrollController();

  final nameController = TextEditingController();

  final rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextWidget(
            label: 'Log Screen',
            fontsize: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Logs').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return Scrollbar(
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(columns: const [
                      DataColumn(
                        label: TextWidget(label: 'Name'),
                      ),
                      DataColumn(
                        label: TextWidget(label: 'Time in'),
                      ),
                      DataColumn(
                        label: TextWidget(label: 'Time out'),
                      ),
                      DataColumn(
                        label: TextWidget(label: 'Working hours'),
                      ),
                      DataColumn(
                        label: TextWidget(label: ''),
                      ),
                    ], rows: [
                      for (int i = 0; i < data.docs.length; i++)
                        DataRow(cells: [
                          DataCell(TextWidget(label: data.docs[i]['name'])),
                          DataCell(TextWidget(
                              label: data.docs[i]['timein'].toString())),
                          DataCell(TextWidget(
                              label: data.docs[i]['timeout'].toString())),
                          DataCell(Builder(builder: (context) {
                            Timestamp firebaseTimestamp1 =
                                data.docs[i]['timein'];
                            Timestamp firebaseTimestamp2 =
                                data.docs[i]['timeout'];

                            DateTime timein = firebaseTimestamp1.toDate();
                            DateTime timeout = firebaseTimestamp2.toDate();

                            Duration duration = timeout.difference(timein);

                            return TextWidget(label: duration.toString());
                          })),
                          DataCell(MaterialButton(
                              color: Colors.blue,
                              child: const TextWidget(label: 'Add'),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const TextWidget(
                                            label: 'Add Employee'),
                                        content: StatefulBuilder(
                                            builder: (context, setState) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ButtonWidget(
                                                onPressed: () {
                                                  _selectDateTime(context);
                                                },
                                                label: selectedDateTime != ''
                                                    ? selectedDateTime
                                                        .toString()
                                                    : 'Time in',
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ButtonWidget(
                                                onPressed: () {
                                                  _selectDateTimeOut(context);
                                                },
                                                label: selectedDateTimeOut != ''
                                                    ? selectedDateTimeOut
                                                        .toString()
                                                    : 'Time out',
                                              ),
                                            ],
                                          );
                                        }),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('Logs')
                                                  .doc(data.docs[i].id)
                                                  .update({
                                                'timein': selectedDateTime,
                                                'timeout': selectedDateTimeOut
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: const TextWidget(
                                              label: 'Add',
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              })),
                        ])
                    ]),
                  ),
                );
              })
        ],
      ),
    );
  }

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }

    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }

  DateTime selectedDateTimeOut = DateTime.now();

  Future<void> _selectDateTimeOut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }

    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }
}
