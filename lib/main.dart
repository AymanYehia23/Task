import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/core/constants.dart';
import 'package:task/data/models/task.dart';
import '../../data/data_providers/add_task_remote.dart';
import '../../data/data_providers/delete_task_remote.dart';
import '../../data/data_providers/get_tasks_remote.dart';
import '../../data/data_providers/update_task_remote.dart';
import '../../logic/cubit/create_task/create_task_cubit.dart';
import '../../logic/cubit/delete_task/delete_task_cubit.dart';
import '../../logic/cubit/get_tasks/get_tasks_cubit.dart';
import '../../logic/cubit/internet/internet_cubit.dart';
import '../../logic/cubit/update_task/update_task_cubit.dart';
import 'firebase_options.dart';

import 'logic/debug/app_bloc_observer.dart';
import 'presentation/screens/desktop/desktop_home_screen.dart';
import 'presentation/screens/mobile/mobile_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>(Strings.taskBox);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          Platform.isWindows ? Sizes.desktopDesignSize : Sizes.mobileDesignSize,
      minTextAdapt: true,
      child: MaterialApp(
        title: Strings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: AppTheme.themePrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (ctx) => GetTasksCubit(
                GetTasksRemote(),
                AddTaskRemote(),
                DeleteTaskRemote(),
                UpdateTaskRemote(),
              ),
            ),
            BlocProvider(
              create: (ctx) => CreateTaskCubit(
                AddTaskRemote(),
              ),
            ),
            BlocProvider(
              create: (ctx) => UpdateTaskCubit(
                UpdateTaskRemote(),
              ),
            ),
            BlocProvider(
              create: (ctx) => DeleteTaskCubit(
                DeleteTaskRemote(),
              ),
            ),
            BlocProvider(
              create: (ctx) => InternetCubit()..checkConnection(),
            ),
          ],
          child: Platform.isWindows
              ? const DesktopHomeScreen()
              : const MobileHomeScreen(),
        ),
      ),
    );
  }
}
