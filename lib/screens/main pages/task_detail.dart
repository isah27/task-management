import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/bloc/cubit/task_cubit.dart';
import 'package:task_management/components/components.dart';
import 'package:task_management/constant/app_constant.dart';

import '../../utils/usefull_methods.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final task = context.watch<TaskCubit>().detaikTask;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            image: const DecorationImage(
              image: AssetImage(ImgPath.car4),
              fit: BoxFit.cover,
            )),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  BackNav(size: size),
                ],
              ),
              SizedBox(height: size.height * 0.06),
              Container(
                height: size.height * 0.6,
                width: size.width * 0.92,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03, vertical: size.height * 0.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                ),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01),
                            child: AppText(
                              text: "${task.name}",
                              textColor: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                              size: 25.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.08),
                        Container(
                          height: size.width * 0.08,
                          width: size.width * 0.08,
                          decoration: BoxDecoration(
                            color: UseFullMethods.statusColor(
                                status: task.status!),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                        child: SingleChildScrollView(
                      child: AppText(
                        text: "${task.description}",
                        size: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black,
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text:
                              "Created on:${UseFullMethods.dateFormat(date: task.createdDate!)}",
                          size: 12.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black,
                        ),
                        Visibility(
                          visible: task.status != 'i',
                          child: AppText(
                            text:
                                "Due date:${UseFullMethods.dateFormat(date: task.dueDate!)}",
                            size: 12.sp,
                            fontWeight: FontWeight.w800,
                            textColor: UseFullMethods.statusColor(
                                status: task.status!),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                padding: EdgeInsets.all(size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: AppText(
                  text: "Priority: ${task.priority}",
                  textColor: Colors.black.withOpacity(0.9),
                  fontWeight: FontWeight.w800,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackNav extends StatelessWidget {
  const BackNav({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.only(left: size.width * 0.02),
        alignment: Alignment.center,
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_left,
          size: size.width * 0.1,
          color: Colors.white,
        ),
      ),
    );
  }
}
