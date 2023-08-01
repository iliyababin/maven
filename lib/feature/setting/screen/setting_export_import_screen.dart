import 'package:flutter/material.dart';
import 'package:maven/common/common.dart';

import '../../../theme/theme.dart';

class SettingExportImportScreen extends StatefulWidget {
  const SettingExportImportScreen({Key? key}) : super(key: key);

  @override
  State<SettingExportImportScreen> createState() => _SettingExportImportScreenState();
}

class _SettingExportImportScreenState extends State<SettingExportImportScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage',
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Import',
            ),
            Tab(
              text: 'Export',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: T(context).space.large,
            ),
            child: CustomScrollView(
              slivers: [
                const Heading(
                  title: 'Source',
                  size: HeadingSize.medium,
                ),
                SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: T(context).color.surface,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: (){

                            },
                            leading: const Icon(
                              Icons.description_outlined,
                            ),
                            title: const Text(
                              'Json',
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              // TODO: Import from csv
                              // context.read<SessionBloc>().add(SessionImport(csv: csv));
                            },
                            leading: Image.asset(
                              'assets/images/strong.png',
                              height: 24,
                            ),
                            title: const Text(
                              'Strong',
                            ),
                          ),
                          ListTile(
                            onTap: (){

                            },
                            leading: Image.asset(
                              'assets/images/hevy.png',
                              height: 24,
                            ),
                            title: const Text(
                              'Hevy',
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showBottomSheetDialog(
                                context: context,
                                child: ConfirmationDialog(
                                  title: 'N/A',
                                  subtitle: 'Not available yet',
                                  confirmText: 'Confirm',
                                  onSubmit: () {},
                                ),
                              );
                            },
                            title: const Text(
                              'Other',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Heading(
                  title: 'Previous',
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      decoration: BoxDecoration(
                        color: T(context).color.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(T(context).space.large),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Import data from a file',
                            style: T(context).textStyle.labelSmall.copyWith(
                                  color: T(context).color.onSurfaceVariant,
                                ),
                          ),
                          Text(
                            'Import',
                            style: T(context).textStyle.headingMedium,
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
