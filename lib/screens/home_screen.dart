import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/services/repositories/employee_repository.dart';
import 'package:test_app/utils/routes.dart';
import 'package:test_app/widgets/text_widget.dart';
import 'package:test_app/widgets/textfield_widget.dart';

class HomeScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final rateController = TextEditingController();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes().logscreen);
            },
            icon: const Icon(
              Icons.date_range,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Employees')
                  .snapshots(),
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
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          final employeedata = data.docs[index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return updateEmployeeData(
                                          employeedata['name'],
                                          employeedata['rate'],
                                          context,
                                          employeedata.id);
                                    });
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  EmployeeRepository()
                                      .deleteEmployee(employeedata.id);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                              title: TextWidget(label: employeedata['name']),
                              subtitle: TextWidget(label: employeedata['rate']),
                            ),
                          );
                        }),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const TextWidget(label: 'Add Employee'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextfieldWidget(
                            textfieldController: nameController,
                            icon: Icons.person,
                            label: 'Name'),
                        const SizedBox(
                          height: 20,
                        ),
                        TextfieldWidget(
                            textfieldController: rateController,
                            icon: Icons.person,
                            label: 'Hourly Rate'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          EmployeeRepository().addEmployee(
                              nameController.text, rateController.text);
                          EmployeeRepository()
                              .addLog(nameController.text, rateController.text);
                          nameController.clear();
                          rateController.clear();
                          Navigator.pop(context);
                        },
                        child: const TextWidget(
                          label: 'Add',
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  Widget updateEmployeeData(name, rate, context, id) {
    return AlertDialog(
      title: const TextWidget(
        label: 'Updating Data',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextfieldWidget(
              textfieldController: nameController,
              icon: Icons.person,
              label: name),
          const SizedBox(
            height: 20,
          ),
          TextfieldWidget(
              textfieldController: rateController,
              icon: Icons.person,
              label: rate),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            // Put update function here
            EmployeeRepository().updateEmployeeData(
                id, nameController.text, rateController.text);

            Navigator.pop(context);
          },
          child: const TextWidget(
            label: 'Update',
          ),
        ),
      ],
    );
  }
}
