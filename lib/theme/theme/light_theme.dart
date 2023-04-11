import 'dart:ui';

import 'package:Maven/theme/m_theme_scheme.dart';
import 'package:Maven/theme/maven_theme.dart';
import 'package:flutter/material.dart';

import '../widget/active_exercise_set_theme.dart';
import '../widget/m_bottom_navigation_bar_theme.dart';
import '../widget/m_dialog_theme.dart';
import '../widget/m_flat_button_theme.dart';
import '../widget/m_icon_theme.dart';
import '../widget/m_popup_menu_theme.dart';
import '../widget/m_text_field_theme.dart';
import '../widget/template_card_theme.dart';
import '../widget/template_folder_theme.dart';

class LightTheme extends MavenTheme {

  LightTheme() : super(
    id: 'light',
    description: 'A nice thing ',
    options: MavenThemeOptions(
        primary: const Color(0xFF35A6FF),
        background: const Color(0xFFF1F1F1),
        text: const Color(0xFFFFFFFF),
        subtext: const Color(0xFFE9EAEA),
        error: const Color(0xFFE9EAEA),
        neutral: const Color(0xFFE9EAEA),
        success: const Color(0xFFE9EAEA),
        secondary: const Color(0xFFE9EAEA),
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
    ),
  );
}