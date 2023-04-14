import 'dart:ui';

import 'package:Maven/theme/m_theme_scheme.dart';
import 'package:Maven/theme/maven_theme.dart';

import '../widget/active_exercise_set_theme.dart';
import '../widget/m_dialog_theme.dart';
import '../widget/m_flat_button_theme.dart';
import '../widget/m_popup_menu_theme.dart';
import '../widget/m_text_field_theme.dart';
import '../widget/template_card_theme.dart';

class DarkTheme extends MavenTheme {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF333333);
  static const Color background = Color(0xff121212);
  static const Color text = Color(0xffffffff);
  static const Color subtext = Color(0xFF808080);
  static const Color neutral = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF2DCD70);
  static const Color error = Color(0xFFDD614A);

  DarkTheme() : super(
    id: 'dark',
    description: 'A nice thing ',
    options: MavenThemeOptions(
      primary: primary,
      secondary: secondary,
      background: background,
      text: text,
      subtext: subtext,
      neutral: neutral,
      success: success,
      error: error,
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
      handleBarColor: const Color(0xFF505050),
    ),
  );
}