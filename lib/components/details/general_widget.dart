import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/bloc/cubit/task_cubit.dart';
import 'package:task_management/model/app_models.dart';

import '../../constant/app_constant.dart';
import '../../page route/page_route.dart';
import '../../utils/usefull_methods.dart';
import '../components.dart';

class GoBack extends StatelessWidget {
  const GoBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 30.sp,
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.size,
    this.hintText = "Task Name",
    this.maxLine = 1,
    this.borderRadius = 0,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final int maxLine;
  final double borderRadius;
  final TextEditingController controller;
  late final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(
        borderRadius == 0 ? size.width * 0.02 : borderRadius,
      ));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.9,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp),
        maxLines: maxLine,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
    );
  }
}

class ImgContainer extends StatelessWidget {
  const ImgContainer({
    super.key,
    required this.size,
    required this.imgUrl,
  });

  final Size size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        left: size.width * 0.03,
        top: size.height * 0.07,
      ),
      width: double.maxFinite,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: const GoBack(),
    );
  }
}

class ButtonAndTaskCounter extends StatelessWidget {
  const ButtonAndTaskCounter({
    super.key,
    required this.size,
    required this.numOfTask,
  });

  final Size size;
  final int numOfTask;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homePage, (route) => false),
          child: Icon(Icons.home, color: AppColors.blue),
        ),
        SizedBox(width: size.width * 0.015),
        InkWell(
          onTap: () {
            context.read<TaskCubit>().resetState();
            Navigator.pushNamed(context, AppRoute.addTaskPage);
          },
          child: Container(
            padding: EdgeInsets.all(size.width * 0.01),
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 10.sp,
            ),
          ),
        ),
        Expanded(child: Container()),
        Icon(Icons.task, size: 20.sp, color: AppColors.blue),
        SizedBox(width: size.width * 0.015),
        AppText(
          text: "$numOfTask",
          size: 20.sp,
          textColor: Colors.black54,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    super.key,
    required this.size,
    required this.task,
    required this.onTap,
    required this.index,
    required this.status,
    required this.onTextTaps,
  });

  final Size size;
  final TaskModel task;
  final Function() onTap;
  final Function() onTextTaps;
  final int index;
  final String status;
  @override
  Widget build(BuildContext context) {
    final deleteWidget = Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 20.sp,
        color: Colors.white,
      ),
    );
    final editWidget = Container(
      color: Colors.blue,
      alignment: Alignment.centerLeft,
      child: Icon(
        Icons.edit,
        size: 20.sp,
        color: Colors.white,
      ),
    );
    return InkWell(
      onTap: () => onTap(),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Dismissible(
            background: editWidget,
            secondaryBackground: deleteWidget,
            key: ObjectKey(index),
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                context.read<TaskCubit>().detailTask(task: task);
                Navigator.pushNamed(context, AppRoute.addTaskPage);
                return false;
              } else {
                await context.read<TaskCubit>().deleteTask(task: task);
                return state is TaskDeletedState;
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.06,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: AppText(
                        text: "${task.name}",
                        textColor: Colors.grey.shade800,
                        size: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        TaskIcon(status: status, size: size),
                        SizedBox(width: size.width * 0.02),
                        TaskText(
                          status: status,
                          size: size,
                          onTextTap: () => onTextTaps(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TaskIcon extends StatelessWidget {
  const TaskIcon({
    super.key,
    required this.size,
    required this.status,
  });

  final Size size;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status != "i",
      child: Container(
        padding: EdgeInsets.all(size.width * 0.01),
        decoration: BoxDecoration(
          color: UseFullMethods.statusColor(status: status),
          shape: BoxShape.circle,
        ),
        child: Icon(
          status == "s" ? Icons.play_arrow : Icons.done,
          color: Colors.white,
          size: size.width * 0.04,
        ),
      ),
    );
  }
}

class TaskText extends StatelessWidget {
  const TaskText({
    super.key,
    required this.size,
    required this.status,
    required this.onTextTap,
  });

  final Size size;
  final String status;
  final Function() onTextTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status != "d",
      child: InkWell(
        onTap: () => onTextTap(),
        child: Container(
          padding: EdgeInsets.all(size.height * 0.004),
          decoration: BoxDecoration(
            color: Colors.amber.shade900,
            borderRadius: BorderRadius.circular(size.width * 0.02),
          ),
          child: AppText(
            text: status == "i" ? "Start" : "Done",
            fontWeight: FontWeight.bold,
            size: 12.sp,
          ),
        ),
      ),
    );
  }
}
