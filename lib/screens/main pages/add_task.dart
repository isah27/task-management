import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/model/details/task_model.dart';
import '../../bloc/cubit/task_cubit.dart';
import '../../components/components.dart';
import '../../constant/app_constant.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String initValue = "Low";
  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskCubit>().detaikTask;
    final priority = context.watch<TaskCubit>().taskPriority;
    final taskCubit = context.read<TaskCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ImgContainer(size: size, imgUrl: ImgPath.hiking1),
          Column(
            children: [
              SizedBox(height: size.height * 0.07),
              // task name text field
              AppTextField(
                size: size,
                borderRadius: size.width * 0.06,
                controller: taskCubit.nameController,
              ),
              SizedBox(height: size.height * 0.02),
              // task importance text field
              AppDropdownInput(
                size: size,
                hintText: "Task Priority",
                onChanged: (value) {
                  taskCubit.changeTaskPriority(priority: value!);
                },
                options: const ["Low", "High"],
                value: priority,
              ),
              SizedBox(height: size.height * 0.02),
              // task detail text field
              AppTextField(
                size: size,
                maxLine: 3,
                hintText: "Task Description",
                controller: taskCubit.detailController,
              ),
              SizedBox(height: size.height * 0.02),
              // add button
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return AppButton(
                    size: size,
                    text: "Add",
                    bgColor: AppColors.amber,
                    onTap: () {
                      if (state is TaskDetailState) {
                        task.description = taskCubit.detailController.text;
                        task.name = taskCubit.nameController.text;
                        task.priority = priority;
                        context.read<TaskCubit>().updateTask(task: task);
                        taskCubit.nameController.clear();
                        taskCubit.detailController.clear();
                      } else {
                        var newTask = TaskModel();
                        newTask.name = taskCubit.nameController.text;
                        newTask.description = taskCubit.detailController.text;
                        newTask.priority = priority;
                        context.read<TaskCubit>().createTask(task: newTask);
                        taskCubit.nameController.clear();
                        taskCubit.detailController.clear();
                      }
                      taskCubit.nameController.clear();
                      taskCubit.detailController.clear();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
