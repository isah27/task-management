import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_management/repository/details/task_repo.dart';

import '../../model/app_models.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo taskRepo;
  TaskCubit({required this.taskRepo}) : super(TaskInitial());

  List<TaskModel> tasks = [];
  TaskModel detaikTask = TaskModel();

  String developer = 'select developer';
  List<String> developers = ['select developer'];
  List<TaskDeveloper> dbDeveloper = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> createTask() async {
    emit(TaskLoadingState());
    try {
      var newTask = TaskModel();
      newTask.name = nameController.text;
      newTask.description = detailController.text;
      newTask.developer = developer;

      await taskRepo.createTask(task: newTask);
      // reset the values back to the initial value
      detailController.clear();
      nameController.clear();
      developer = 'select developer';
      developers = ['select developer'];
      emit(TaskLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> getTask() async {
    emit(TaskLoadingState());
    try {
      if (developers.length==1) {
        await getDevelopers();
      }
      tasks = await taskRepo.readTasks();

      emit(TaskLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    emit(TaskInitial());
    try {
      if (detaikTask.name != null) {
        task.developer = developer;
        task.name = nameController.text;
        task.description = detailController.text;
      }
      await taskRepo.updateTask(task: task);
      detailController.clear();
      nameController.clear();
      developer = 'select developer';
      developers = ['select developer'];
      detaikTask = TaskModel();
      emit(TaskLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> deleteTask({required TaskModel task}) async {
    emit(TaskDeletingdState());
    try {
      await taskRepo.deleteTask(id: task.sId!);
      tasks.remove(task);
      emit(TaskDeletedState());
      emit(TaskInitial());
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> detailTask({required TaskModel task}) async {
    emit(TaskLoadingState());
    detaikTask = task;
    nameController.text = detaikTask.name ?? "";
    detailController.text = detaikTask.description ?? "";
    developer = task.developer ?? "";
    emit(TaskDetailState());
  }

  Future<void> changeTaskDeveloper({required String dev}) async {
    emit(TaskLoadingState());
    developer = dev;
    emit(TaskDetailState());
  }

  Future<void> getDevelopers() async {
    emit(TaskLoadingState());
    developer = 'select developer';
    developers = ['select developer'];
    try {
      dbDeveloper = await taskRepo.readDeveloper();
      for (var developer in dbDeveloper) {
        if (developer.name != null) {
          developers.add(developer.name!);
        }
      }
      emit(TaskInitial());
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }
}
