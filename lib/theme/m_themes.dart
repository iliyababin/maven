import 'package:Maven/feature/setting/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_options.dart';

ThemeOptions mt(BuildContext context){
  return context.read<SettingBloc>().state.theme.options;
}