import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sm_product_manager/routes/app_pages.dart';

import 'core/constants/app_colors.dart';
import 'data/data_sources/local/shared_prefs_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'SM Product Manager',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundLightGrey,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            useMaterial3: true,
          ),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
