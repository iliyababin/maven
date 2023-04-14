import 'dart:ui';

import 'package:Maven/theme/m_theme_scheme.dart';
import 'package:Maven/theme/maven_theme.dart';
import 'package:flutter/material.dart';

import '../widget/active_exercise_set_theme.dart';
import '../widget/m_dialog_theme.dart';
import '../widget/m_flat_button_theme.dart';
import '../widget/m_popup_menu_theme.dart';
import '../widget/m_text_field_theme.dart';
import '../widget/template_card_theme.dart';

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
        handleBarColor: const Color(0xFFE9EAEA)
    ),
  );
}