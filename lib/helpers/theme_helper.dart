import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';

class ThemeHelper {
  static final textTheme = Theme.of(Get.context!).textTheme;

  //main Theme Setting
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: false,
  ).copyWith(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextThemes.textTheme(color: AppColors.black),
    // primarySwatch: AppColors.palette1,
    // useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: GoogleFonts.dmSerifDisplay(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      centerTitle: true,
      elevation: 3,
      shadowColor: AppColors.black12,
    ),
    tabBarTheme: const TabBarTheme(
        labelColor: AppColors.black, indicatorColor: AppColors.black),
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
    //useMaterial3: false,
    //primarySwatch: ThemeHelper.platte1,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextThemes.textTheme(color: AppColors.white),
    // fontFamily: 'Poppins',
    dividerColor: AppColors.white,
    //textTheme: TextThemes.textTheme(color: white),
    iconTheme: IconThemeData(color: AppColors.white.withOpacity(0.4)),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      prefixIconColor: AppColors.white,
      fillColor: AppColors.white.withOpacity(0.1),
      hintStyle:
          TextThemes.textTheme(color: AppColors.white).bodyMedium!.copyWith(
                color: AppColors.white.withOpacity(0.4),
              ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.white),
      titleTextStyle: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primary),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
    ),
    tabBarTheme: const TabBarTheme(
        labelColor: AppColors.white, indicatorColor: AppColors.white38),
    // textButtonTheme: const TextButtonThemeData(
    // style: ButtonStyle(
    //   backgroundColor: platte1
    // )
    // )
  );
}

class TextThemes {
  //static bool isDark = Get.isDarkMode  ? true: false;

  static TextTheme textTheme({required Color color}) => TextTheme(
        headlineLarge: TextStyle(
          color: color,
          //color: appTheme.gray90001,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 30,
          //fontFamily: 'DM Serif Display',
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: color,
          //color: appTheme.gray90001,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 26,
          //fontFamily: 'DM Serif Display',
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: color,
          //color: primary,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 24,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: color,
          //color: appTheme.blueGray90001,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 22,
          //fontFamily: 'DM Serif Text',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: color,
          fontSize: 20,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: color,
          //color: appTheme.gray90001,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 18,
          // fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
            color: color,
          
          fontSize: 16,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: color,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 14,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: color,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 12,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),

        labelLarge: TextStyle(
          color: color,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 15,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: color,
          //color: isDark ? Colors.black : Colors.white,
          fontSize: 13,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          color: color,
          //color: isDark ? Colors.black : Colors.white,
          fontSize:11,
          //fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ).apply(
        fontFamily: GoogleFonts.inter().fontFamily,
      );
}
