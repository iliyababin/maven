import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../database/database.dart';
import '../../theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required this.themeDao,
    required this.themeColorDao,
    required this.settingDao,
  }) : super(const ThemeState()) {
    on<ThemeInitialize>(_initialize);
    on<ThemeAdd>(_add);
    on<ThemeChange>(_change);
    on<ThemeUpdate>(_update);
    on<ThemeDelete>(_delete);
  }

  final AppThemeDao themeDao;
  final AppThemeColorDao themeColorDao;
  final SettingsDao settingDao;

  Future<void> _initialize(ThemeInitialize event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(
      status: ThemeStatus.loading,
    ));

    AppTheme? theme =
        await themeDao.get(await settingDao.get().then((value) => value?.themeId ?? 1));
    AppThemeColor? color = await themeColorDao.get(theme!.id!);
    theme = theme.copyWith(
      option: AppThemeOption(
        color: color!,
      ),
    );
    List<AppTheme> themes = [];
    for(AppTheme theme in await themeDao.getAll()) {
      AppThemeColor? color = await themeColorDao.get(theme.id!);
      themes.add(theme.copyWith(
        option: AppThemeOption(
          color: color!,
        ),
      ));
    }

    emit(state.copyWith(
      status: ThemeStatus.loaded,
      theme: theme,
      themes: await _fetchThemes(),
    ));
  }

  Future<void> _add(ThemeAdd event, Emitter<ThemeState> emit) async {
    int themeId = await themeDao.add(event.theme);
    themeColorDao.add(event.theme.option.color.copyWith(
      appThemeId: themeId,
    ));

    emit(state.copyWith(
      status: ThemeStatus.loaded,
      themes: await _fetchThemes(),
    ));
  }

  Future<void> _change(ThemeChange event, Emitter<ThemeState> emit) async {
    await settingDao.modify(await settingDao.get().then((value) => value!.copyWith(
      themeId: event.theme.id,
    )));
    emit(state.copyWith(
      theme: state.themes.where((element) => element.id == event.theme.id).first,
    ));
  }

  Future<void> _update(ThemeUpdate event, Emitter<ThemeState> emit) async {
    await themeDao.modify(event.theme);
    print('Trying to update with this color: ${event.theme.option.color.primary}');
    print('Colors: ${event.theme.option.color}');

    int status = await themeColorDao.modify(event.theme.option.color);
    print('Status: $status');

    AppThemeColor? color = await themeColorDao.get(event.theme.id!);
    print('Updated color: ${color!.primary}');
    print('Colors New: $color');


    emit(state.copyWith(
      themes: await _fetchThemes(),
    ));
  }

  Future<void> _delete(ThemeDelete event, Emitter<ThemeState> emit) async {
    await themeDao.remove(event.theme);
    emit(state.copyWith(
      themes: await _fetchThemes(),
    ));
  }

  Future<List<AppTheme>> _fetchThemes() async {
    List<AppTheme> themes = [];
    print('getting Themes');

    for(AppTheme theme in await themeDao.getAll()) {
      AppThemeColor? color = await themeColorDao.get(theme.id!);
      themes.add(theme.copyWith(
        option: AppThemeOption(
          color: color!,
        ),
      ));
    }
    return themes;
  }
}
