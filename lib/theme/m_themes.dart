import 'package:Maven/theme/widget/active_exercise_set_theme.dart';
import 'package:Maven/theme/widget/m_bottom_navigation_bar_theme.dart';
import 'package:Maven/theme/widget/m_dialog_theme.dart';
import 'package:Maven/theme/widget/m_flat_button_theme.dart';
import 'package:Maven/theme/widget/m_icon_theme.dart';
import 'package:Maven/theme/widget/m_popup_menu_theme.dart';
import 'package:Maven/theme/widget/m_text_field_theme.dart';
import 'package:Maven/theme/widget/m_text_theme.dart';
import 'package:Maven/theme/widget/template_card_theme.dart';
import 'package:Maven/theme/widget/template_folder_theme.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'color_scheme.dart';

List<AppTheme> getThemes(BuildContext context){
  return [
    AppTheme(
      id: "light_theme",
      description: "Light",
      data: ThemeData(

      ),
      options: MThemeScheme(
        sidePadding: 20,
        accentColor: const Color(0xFF35A6FF),
        borderColor: const Color(0xFFF1F1F1),
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFFE9EAEA),
        text: MTextTheme(
          primaryColor: const Color(0xFF000000),
          secondaryColor: const Color(0xFF797979),
          accentColor: const Color(0xFF35A6FF),
          whiteColor: const Color(0xFFFFFFFF),
          errorColor: const Color(0xFFDD614A),
        ),
        bottomNavigationBar: MBottomNavigationBarTheme(
          backgroundColor: const Color(0xFFFFFFFF),
          selectedItemColor: const Color(0xFF35A6FF),
          unselectedItemColor: const Color(0xFF383838),
          shadowColor: const Color(0xFFE0E0E0),
        ),
        icon: MIconTheme(
          primaryColor: const Color(0xFF000000),
          secondaryColor: const Color(0xFF888888),
          tertiaryColor: const Color(0xFFD3D3D3),
          accentColor: const Color(0xFF35A6FF),
          errorColor: const Color(0xFFDD614A),
          completeColor: const Color(0xFF0BDA51),
        ),
        templateFolder: TemplateFolderTheme(
          borderColor: const Color(0xFFF1F1F1),
          dragShadowColor: const Color(0xFF838383),
          backgroundColor: const Color(0xFFFFFFFF)
        ),
        popupMenu: MPopupMenuTheme(
          backgroundColor: const Color(0xFFFFFFFF)
        ),
        dialog: MDialogTheme(
          backgroundColor: const Color(0xFFFFFFFF)
        ),
        textField: MTextFieldTheme(
          borderColor: const Color(0xFFF1F1F1),
          errorOutlineColor: const Color(0xFFDD614A),
          hintColor: const Color(0xFFC8C8C8),
          primaryOutlineColor: const Color(0xFFF1F1F1),
          backgroundColor: const Color(0xFFE9EAEA),
        ),
        templateCard:TemplateCardTheme(
          backgroundColor: const Color(0xFFFFFFFF),
          borderColor: const Color(0xFFF1F1F1),
        ),
        flatButton: MFlatButtonTheme(
          completeColor: const Color(0xFF2DCD70),
          errorColor: const Color(0xFFFFEEEF)
        ),
        activeExerciseSet: ActiveExerciseSetTheme(
          completeColor: const Color(0xffd9ffe7),
        ),
        sliverNavigationBarBackgroundColor: const Color(0xFFFDFDFD),
        handleBarColor: const Color(0xFFE9EAEA)
      )
    ),
    AppTheme(
        id: "dark_theme",
        description: "Dark",
        data: ThemeData(

        ),
        options: MThemeScheme(
          sidePadding: 20,
          accentColor: const Color(0xFF2196F3),
          borderColor: const Color(0xFF333333),
          backgroundColor: const Color(0xff121212),
          foregroundColor: const Color(0xFF000000),
          text: MTextTheme(
            primaryColor: const Color(0xFFFFFFFF),
            secondaryColor: const Color(0xFF646464),
            accentColor: const Color(0xFF2196F3),
            whiteColor: const Color(0xFFFFFFFF),
            errorColor: const Color(0xFFDD614A),
          ),
          bottomNavigationBar: MBottomNavigationBarTheme(
            backgroundColor: const Color(0xFF121212),
            selectedItemColor: const Color(0xFF2196F3),
            unselectedItemColor: const Color(0xFF676767),
            shadowColor: const Color(0xFF0C0C0C),
          ),
          icon: MIconTheme(
            primaryColor: const Color(0xFFFFFFFF),
            secondaryColor: const Color(0xFFB6B6B6),
            tertiaryColor: const Color(0xFF797979),
            accentColor: const Color(0xFF2196F3),
            errorColor: const Color(0xFFDD614A),
            completeColor: const Color(0xFF0BDA51),
          ),
          templateFolder: TemplateFolderTheme(
            borderColor: const Color(0xFF333333),
            dragShadowColor: const Color(0xFF838383),
            backgroundColor: const Color(0xFF121212)
          ),
          popupMenu: MPopupMenuTheme(
            backgroundColor: const Color(0xFF000000)
          ),
          dialog: MDialogTheme(
            backgroundColor: const Color(0xFF000000)
          ),
          textField: MTextFieldTheme(
            borderColor: const Color(0xFF333333),
            errorOutlineColor: const Color(0xFFDD614A),
            hintColor: const Color(0xff434343),
            primaryOutlineColor: const Color(0xFF333333),
            backgroundColor: const Color(0xFF2E2E2E),
          ),
          templateCard: TemplateCardTheme(
            backgroundColor: const Color(0xFF121212),
            borderColor: const Color(0xFF333333),
          ),
          flatButton: MFlatButtonTheme(
            completeColor: const Color(0xFF2DCD70),
            errorColor: const Color(0xFFFEABB2)
          ),
          activeExerciseSet: ActiveExerciseSetTheme(
            completeColor: const Color(0xFF003000),
          ),
          sliverNavigationBarBackgroundColor: const Color(0xFF121212),
            handleBarColor: const Color(0xFF505050)

        ),
    ),
  ];
}

MThemeScheme mt(BuildContext context){
  return ThemeProvider.optionsOf<MThemeScheme>(context);
}

