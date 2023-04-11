import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/app_models.dart';

class TaskRepo {
  final taskTable = "tasks";
  FirebaseFirestore storage = FirebaseFirestore.instance;
  // add task to database
  Future<void> createTask({required TaskModel task}) async {
    task.createdDate = DateTime.now().toString();
    task.dueDate = DateTime.now().toString();
    task.status = 'i';
    await storage.collection(taskTable).add(task.toJson()).then((savedTask) {
      task.sId = savedTask.id;
      return storage.collection(taskTable).doc(task.sId).update(task.toJson());
    });
  }

  // get all task from database
  Future<List<TaskModel>> readTasks() async {
    return await storage
        .collection(taskTable)
        .orderBy("createdDate", descending: true)
        .get()
        .then((tasks) =>
            tasks.docs.map((task) => TaskModel.fromJson(task.data())).toList());
  }
    // get all task developer from database
  Future<List<TaskDeveloper>> readDeveloper() async {
    return await storage
        .collection("developers").orderBy('name', descending: true)
        .get()
        .then((tasks) =>
            tasks.docs.map((task) => TaskDeveloper.fromJson(task.data())).toList());
  }

  // update task by sId
  Future<void> updateTask({required TaskModel task}) async {
    await storage.collection(taskTable).doc(task.sId).update(task.toJson());
  }

  // delete task from databses by sId
  Future<void> deleteTask({required String id}) async {
    await storage.collection(taskTable).doc(id).delete();
  }
}
