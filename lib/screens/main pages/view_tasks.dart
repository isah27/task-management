import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/model/app_models.dart';
import 'package:task_management/page%20route/detail/route.dart';
import '../../bloc/cubit/task_cubit.dart';
import '../../components/components.dart';
import '../../constant/app_constant.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  String status = "i";
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<TaskModel> tasks = context.watch<TaskCubit>().tasks;
    final taskCubit = context.read<TaskCubit>();
    return Scaffold(
      body: Column(
        children: [
          ImgContainer(size: size, imgUrl: ImgPath.car3),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: ButtonAndTaskCounter(size: size, numOfTask: tasks.length),
          ),
          // list of tasks
          Expanded(
              // width: size.width,
              // height: size.height * 0.6,
              child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is TaskErrorState) {
                return Center(
                  child: AppText(
                    text: state.error,
                    size: 25.sp,
                    textColor: Colors.red.shade900,
                    fontWeight: FontWeight.w800,
                  ),
                );
              }

              return ListView.separated(
                itemCount: state is TaskDeletingdState ? 1 : tasks.length,
                itemBuilder: (context, index) {
                  return state is TaskDeletingdState
                      ? const CircularProgressIndicator.adaptive()
                      : TasksWidget(
                          index: index,
                          size: size,
                          status: "${tasks[index].status}",
                          task: tasks[index],
                          onTextTaps: () {
                            if (tasks[index].status == "i") {
                              showCustomDatePicker(
                                  context: context,
                                  size: size,
                                  task: tasks[index]);
                            } else if (tasks[index].status == "s") {
                              tasks[index].status = "d";
                              taskCubit.updateTask(task: tasks[index]);
                            }
                          },
                          onTap: () {
                            taskCubit.detailTask(task: tasks[index]);
                            Navigator.pushNamed(
                                context, AppRoute.detailTaskPage);
                          },
                        );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.height * 0.01);
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
