import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widget/m_button.dart';
import '../../../common/widget/titled_scaffold.dart';
import '../../../generated/l10n.dart';
import '../../../l10n/screen/language_screen.dart';
import '../../../theme/theme.dart';
import '../../equipment/screen/equipment_screen.dart';
import '../../exercise/screen/exercise_selection_screen.dart';
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
                  padding: EdgeInsets.only(left: T.current.padding.page, right: T.current.padding.page, top: T.current.padding.page),
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
                            style: T.current.textStyle.heading2,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Weight Lifiting',
                            style: T.current.textStyle.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: T.current.padding.page, left: T.current.padding.page, bottom: 12, top: 36 ),
                  child: Text(
                    'Basic',
                    style: T.current.textStyle.heading4,
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
                  title: S.current.exercises,
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
                  padding: EdgeInsets.only(right: T.current.padding.page, left: T.current.padding.page, bottom: 12, top: 36 ),
                  child: Text(
                    'Appearance',
                    style: T.current.textStyle.heading4,
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
