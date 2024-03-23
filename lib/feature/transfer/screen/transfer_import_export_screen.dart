import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maven/feature/transfer/screen/transfer_detail_screen.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../../session/session.dart';
import '../transfer.dart';

class TransferImportExportScreen extends StatefulWidget {
  const TransferImportExportScreen({Key? key}) : super(key: key);

  @override
  State<TransferImportExportScreen> createState() =>
      _TransferImportExportScreenState();
}

class _TransferImportExportScreenState extends State<TransferImportExportScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  Future<String?> getDataFromFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Import Data',
    );

    if (result != null) {
      return await File(result.files.single.path!).readAsString();
    } else {
      return null;
    }
  }

  Future<void> importCustom(TransferSource source, String? data) async {
    if (data != null) {
      context.read<TransferBloc>().add(TransferImport(
        source: source,
        data: data,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Import'),
            Tab(text: 'Export'),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              TransferSource.json.imagePath,
                              height: 24,
                            ),
                            title: const Text('Json'),
                          ),
                          ListTile(
                            onTap: () async {
                              importCustom(TransferSource.strong, await getDataFromFile());
                            },
                            leading: Image.asset(
                              TransferSource.strong.imagePath,
                              height: 24,
                            ),
                            title: const Text('Strong'),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Image.asset(
                              TransferSource.hevy.imagePath,
                              height: 24,
                            ),
                            title: const Text('Hevy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Heading(title: 'History'),
                BlocBuilder<TransferBloc, TransferState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const SliverBoxWidget(
                        type: SliverBoxType.loading,
                      );
                    } else {
                      if (state.imports.isEmpty) {
                        return const SliverBoxWidget(
                          type: SliverBoxType.empty,
                        );
                      }

                      return SliverList(
                        delegate: SliverChildListDelegate([
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Material(
                              color: T(context).color.surface,
                              child: ListView.builder(
                                itemCount: state.imports.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Import import = state.imports[index];
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransferDetailScreen(
                                            import: import,
                                          ),
                                        ),
                                      );
                                    },
                                    leading: Image.asset(
                                      import.source.imagePath,
                                      height: 24,
                                    ),
                                    title: Text(
                                      DateFormat('yMd')
                                          .add_jm()
                                          .format(import.timestamp),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ]),
                      );
                    }
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: T(context).space.large,
            ),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Export',
                )),
          ),
        ],
      ),
    );
  }
}
