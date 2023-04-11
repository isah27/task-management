import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/cubit/task_cubit.dart';
import '../../components/components.dart';
import '../../constant/app_constant.dart';
import '../../page route/page_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImgPath.hiking2),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Hello",
                      size: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    AppText(
                      text: "start your beautiful day!",
                      size: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: size.height * 0.42),
            AppButton(
              size: size,
              text: "View Tasks",
              bgColor: AppColors.blue,
              onTap: () {
                Navigator.pushNamed(context, AppRoute.viewTaskPage);
                context.read<TaskCubit>().getTask();
              },
            ),
            SizedBox(height: size.height * 0.02),
            AppButton(
              size: size,
              text: "Add Task",
              bgColor: AppColors.amber,
              onTap: () {
                context.read<TaskCubit>().resetState();
                Navigator.pushNamed(context, AppRoute.addTaskPage);
              },
            ),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
