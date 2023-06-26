import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeRepository {
  Future addEmployee(name, rate) {
    final doc = FirebaseFirestore.instance.collection('Employees').doc();

    final json = {
      'name': name,
      'rate': rate,
    };

    return doc.set(json);
  }

  deleteEmployee(id) async {
    await FirebaseFirestore.instance.collection('Employees').doc(id).delete();
  }

  updateEmployeeData(id, name, rate) async {
    try {
      await FirebaseFirestore.instance
          .collection('Employees')
          .doc(id)
          .update({'name': name, 'rate': rate});
    } catch (e) {
      print(e);
    }
  }

  Future addLog(
    name,
    rate,
  ) {
    final doc = FirebaseFirestore.instance.collection('Logs').doc();

    final json = {
      'name': name,
      'rate': rate,
      'timein': '',
      'timeout': '',
    };

    return doc.set(json);
  }
}
