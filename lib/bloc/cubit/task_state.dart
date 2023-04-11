part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}
class TaskDeletedState extends TaskState {}
class TaskDeletingdState extends TaskState {}
class TaskDetailState extends TaskState {}
class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;
  const TaskLoadedState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}



class TaskErrorState extends TaskState {
  const TaskErrorState({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
