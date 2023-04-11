import 'package:flutter/cupertino.dart';
import 'package:task_management/screens/main%20pages/add_task.dart';
import 'package:task_management/screens/main%20pages/home_page.dart';
import 'package:task_management/screens/main%20pages/task_detail.dart';
import 'package:task_management/screens/main%20pages/view_tasks.dart';

import 'custom_page_route.dart';

class AppRoute {
  static const String homePage = '/';
  static const String addTaskPage = '/add task';
  static const String viewTaskPage = '/view task';
  static const String detailTaskPage = '/detail task';
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return CustomPageRoute(child: const HomePage());
      case addTaskPage:
        return CustomPageRoute(
          direction: AxisDirection.left,
          child: const AddTaskPage(),
        );
      case viewTaskPage:
        return CustomPageRoute(
          direction: AxisDirection.left,
          child: const ViewTaskPage(),
        );
      case detailTaskPage:
        return CustomPageRoute(
          direction: AxisDirection.up,
          child: const TaskDetailPage(),
        );
      default:
        return CustomPageRoute(child: const HomePage());
    }
  }
}
