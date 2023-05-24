import 'package:Maven/feature/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widget/m_button.dart';
import '../../../common/widget/titled_scaffold.dart';
import '../../../theme/m_themes.dart';

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
                        child: CircleAvatar(
                          minRadius: 25,
                          child: Text('A'),
                        ),
                      ),
                      SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: mt(context).textStyle.heading2,
                          ),
                          SizedBox(height: 2),
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
                MButton.tiled(onPressed: (){},
                  leading: Icon(
                    Icons.sports_gymnastics,
                  ),
                  title: 'Exercises',
                ),
                MButton.tiled(onPressed: (){},
                  leading: Icon(Icons.home_repair_service_rounded,),
                  title: 'Equipment',
                ),
                MButton.tiled(onPressed: (){},
                  leading: Icon(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  leading: Icon(Icons.palette,),
                  title: 'Theme',
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  leading: Icon(Icons.tag,),
                  title: 'Units',
                ),
                MButton.tiled(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  leading: Icon(Icons.language,),
                  title: 'Language',
                ),
                /*GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                MButton(
                  onPressed: () {},
                  expand: false,
                  borderColor: mt(context).color.secondary,
                  height: 50,
                  leading: const Icon(Icons.sports_gymnastics),
                  child: Text(
                    'Exercises',
                    style: mt(context).textStyle.body1,
                  ),
                ),
                MButton(
                  onPressed: () {},
                  expand: false,
                  borderColor: mt(context).color.secondary,
                  height: 50,
                  leading: const Icon(Icons.straighten),
                  child: Text(
                    'Measure',
                    style: mt(context).textStyle.body1,
                  ),
                ),
                MButton(
                  onPressed: () {},
                  expand: false,
                  borderColor: mt(context).color.secondary,
                  height: 50,
                  leading: const Icon(Icons.settings),
                  child: Text(
                    'Settings',
                    style: mt(context).textStyle.body1,
                  ),
                ),
              ],
            ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
