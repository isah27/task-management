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
  String taskPriority = "Low";
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> createTask({required TaskModel task}) async {
    emit(TaskLoadingState());
    try {
      // task.priority = taskPriority;
      // task.description = detailController.text;
      // task.name = nameController.text;
     await taskRepo.createTask(task: task);
      emit(TaskLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> getTask() async {
    emit(TaskLoadingState());
    try {
      tasks = await taskRepo.readTasks();
      emit(TaskLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: error.toString()));
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    emit(TaskInitial());
    try {
    await taskRepo.updateTask(task: task);
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
    emit(TaskDetailState());
  }

  Future<void> changeTaskPriority({required String priority}) async {
    if (state is TaskDetailState) {
      emit(TaskLoadingState());
      taskPriority = priority;
      emit(TaskDetailState());
    } else {
      emit(TaskInitial());
      taskPriority = priority;
      emit(TaskLoadingState());
    }
  }

  resetState() {
    emit(TaskInitial());
  }
}
