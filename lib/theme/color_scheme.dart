import 'dart:ui';

import 'package:Maven/theme/widget/active_exercise_set_theme.dart';
import 'package:Maven/theme/widget/m_bottom_navigation_bar_theme.dart';
import 'package:Maven/theme/widget/m_dialog_theme.dart';
import 'package:Maven/theme/widget/m_icon_theme.dart';
import 'package:Maven/theme/widget/m_popup_menu_theme.dart';
import 'package:Maven/theme/widget/m_text_field_theme.dart';
import 'package:Maven/theme/widget/m_text_theme.dart';
import 'package:Maven/theme/widget/workout_card_theme.dart';
import 'package:Maven/theme/widget/workout_folder_theme.dart';
import 'package:theme_provider/theme_provider.dart';

class MColorScheme implements AppThemeOptions{
  /*final Color backgroundColor;
  final Color backgroundDarkColor;
  final Color primaryColor;
  final Color primaryTextColor;
  final Color accentTextColor;
  final Color textFieldBackgroundColor;
  final Color textFieldHintColor;
  final Color completeColor;
  final Color checkColor;
  final Color errorColor;
  final Color unselectedItemColor;
  final Color dragBarColor;
  final Color slidingPanelShadowColor;
  final Color whiteColor;
  final Color transparentColor = const Color(0x00000000);
  final Color popupMenuBackgroundColor;
  final Color finishColor;*/

  final Color accentColor;
  final Color borderColor;
  final Color backgroundColor;

  final MTextTheme text;
  final MBottomNavigationBarTheme bottomNavigationBar;
  final MIconTheme icon;
  final MDialogTheme dialog;
  final MPopupMenuTheme popupMenu;
  final MTextFieldTheme textField;

  final WorkoutFolderTheme workoutFolder;
  final WorkoutCardTheme workoutCard;
  final ActiveExerciseSetTheme activeExerciseSet;

  final Color sliverNavigationBarBackgroundColor;


  MColorScheme({
    required this.accentColor,
    required this.borderColor,
    required this.backgroundColor,

    required this.text,
    required this.bottomNavigationBar,
    required this.icon,
    required this.popupMenu,
    required this.dialog,
    required this.textField,

    required this.workoutFolder,
    required this.workoutCard,
    required this.activeExerciseSet,

    required this.sliverNavigationBarBackgroundColor,

  });
}
