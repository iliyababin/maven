import 'package:Maven/feature/equipment/screen/equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widget/m_button.dart';
import '../../../common/widget/titled_scaffold.dart';
import '../../../l10n/screen/language_screen.dart';
import '../../../theme/m_themes.dart';
import '../../exercise/screen/exercise_selection_screen.dart';
import '../../setting/screen/settings_screen.dart';
import '../../setting/screen/theme_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Profile',
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: mt(context).padding.page, right: mt(context).padding.page, top: mt(context).padding.page),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(source: ImageSource.camera);
                        },
                        child: const CircleAvatar(
                          minRadius: 25,
                          child: Text('A'),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: mt(context).textStyle.heading2,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Weight Lifiting',
                            style: mt(context).textStyle.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: mt(context).padding.page, left: mt(context).padding.page, bottom: 12, top: 36 ),
                  child: Text(
                    'Basic',
                    style: mt(context).textStyle.heading4,
                  ),
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen(
                      selection: false,
                    )));
                  },
                  leading: const Icon(
                    Icons.sports_gymnastics,
                  ),
                  title: 'Exercises',
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EquipmentScreen()));
                  },
                  leading: const Icon(Icons.home_repair_service_rounded,),
                  title: 'Equipment',
                ),
                MButton.tiled(
                  onPressed: (){
                    // TODO: Add measureing feature
                  },
                  leading: const Icon(
                    Icons.straighten,
                  ),
                  title: 'Measure',
                ),
                Padding(
                  padding: EdgeInsets.only(right: mt(context).padding.page, left: mt(context).padding.page, bottom: 12, top: 36 ),
                  child: Text(
                    'Appearance',
                    style: mt(context).textStyle.heading4,
                  ),
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeScreen()));
                  },
                  leading: const Icon(Icons.palette,),
                  title: 'Theme',
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  leading: const Icon(Icons.tag,),
                  title: 'Units',
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen()));
                  },
                  leading: const Icon(Icons.language,),
                  title: 'Language',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
