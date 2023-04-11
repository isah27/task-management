import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/bloc/cubit/date_picker_cubit.dart';
import 'package:task_management/bloc/cubit/task_cubit.dart';
import 'package:task_management/model/app_models.dart';

import '../../constant/app_constant.dart';
import '../components.dart';

showCustomDatePicker(
    {required BuildContext context,
    required Size size,
    required TaskModel task}) {
  final readTaskCubit = context.read<DatePickerCubit>();
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      useSafeArea: false,
      builder: (context) {
        return Container(
          height: size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * 0.03),
              topRight: Radius.circular(size.width * 0.03),
            ),
          ),
          child: BlocBuilder<DatePickerCubit, DatePickerState>(
            builder: (context, state) {
              if (state is DateChangedState) {
                var textStyle = TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                );
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.01),
                    AppText(
                      text: "Pick Task Due Date",
                      size: 18.sp,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.amber.shade900,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.02,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: DateFormat.yMd().format(state.date),
                              textColor: AppColors.blue,
                              size: 20.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          AppButton(
                            size: size * 0.2,
                            text: "start",
                            bgColor: Colors.blue.shade900,
                            onTap: () {
                              task.status = "s";
                              task.dueDate = DateTime.now().toString();
                              context.read<TaskCubit>().updateTask(task: task);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScrollDatePicker(
                        selectedDate: state.date,
                        locale: const Locale('en'),
                        options: const DatePickerOptions(
                          backgroundColor: Colors.amber,
                        ),
                        scrollViewOptions: DatePickerScrollViewOptions.all(
                          ScrollViewDetailOptions(
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                              ),
                              selectedTextStyle: textStyle,
                              textStyle: textStyle.copyWith(
                                fontSize: 12.sp,
                              )),
                        ),
                        maximumDate: DateTime.utc(DateTime.now().year + 10),
                        onDateTimeChanged: (date) {
                          readTaskCubit.changeDate(date);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        );
      });
}
