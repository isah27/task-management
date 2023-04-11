import 'package:dio/dio.dart';

import '../../model/app_models.dart';

class TaskRepo {
  final dio = Dio();
  final baseUrl = "http://localhost:5000/api/tasks";

  // add task to database
  Future<TaskModel?> createTask({required TaskModel task}) async {
    final data = {
      "name": task.name,
      "description": task.description,
      "priority": task.priority
    };
    final response = await dio.post("$baseUrl/", data: data);
    if (response.statusCode == 201) {
      return TaskModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  // get all task from database
  Future<List<TaskModel>> readTasks() async {
    List<TaskModel> tasks = [];
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      for (var task in response.data) {
        tasks.add(TaskModel.fromJson(task));
      }
      return tasks;
    }
    return tasks;
  }

  // update task by sId
  Future<TaskModel?> updateTask({required TaskModel task}) async {
    final response = await dio.put("$baseUrl/${task.sId}", data: task.toJson());
    if (response.statusCode == 200) {
      return TaskModel.fromJson(response.data["Updated task"]);
    } else {
      return null;
    }
  }

  // delete task from databses by sId
  Future<String> deleteTask({required String id}) async {
    final response = await dio.delete("$baseUrl/$id");
    if (response.statusCode == 200) {
      return "deleted";
    } else {
      return "task not found";
    }
  }
}
