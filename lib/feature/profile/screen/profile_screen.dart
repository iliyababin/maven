import 'package:Maven/feature/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widget/titled_scaffold.dart';
import '../../../theme/m_themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Profile',
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.camera);
              },
              child: CircleAvatar(
                child: Text('A'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              },
              child: Text("settings"),
            ),
          ],
        ),
      ),
    );
  }
}
