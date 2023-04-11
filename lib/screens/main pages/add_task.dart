import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/task_cubit.dart';
import '../../components/components.dart';
import '../../constant/app_constant.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskCubit>().detaikTask;
    final priority = context.watch<TaskCubit>().developer;
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
              // task developer text field
              AppDropdownInput(
                size: size,
                hintText: "Developer",
                onChanged: (value) {
                  taskCubit.changeTaskDeveloper(dev: value!);
                },
                options: taskCubit.developers,
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
                    text: state is TaskLoadingState
                        ? "Processing..."
                        : task.name != null
                            ? "Update Task"
                            : "Add",
                    bgColor: AppColors.amber,
                    onTap: () {
                      if (taskCubit.nameController.text != "" &&
                          taskCubit.detailController.text != "") {
                        if (task.name != null) {
                          context.read<TaskCubit>().updateTask(task: task);
                        } else {
                          context.read<TaskCubit>().createTask();
                        }
                      }
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
