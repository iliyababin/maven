import 'package:Maven/common/dialog/show_text_input_dialog.dart';
import 'package:Maven/common/model/template.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/feature/template/bloc/template/template_bloc.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/m_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/template_folder_widget.dart';
import 'create_template_screen.dart';
import 'reorder_template_screen.dart';


class TemplateScreen extends StatefulWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: mt(context).backgroundColor,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Template',
                style: TextStyle(
                  color: mt(context).text.primaryColor,
                ),
              ),
              backgroundColor: mt(context).sliverNavigationBarBackgroundColor,
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              quickStart(),
              templates(),
              BlocBuilder<TemplateBloc, TemplateState>(
                builder: (context, state) {
                  if (state.status == TemplateStatus.loading) {
                    return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator())
                    );
                  } else if (state.status == TemplateStatus.success || state.status == TemplateStatus.reordering) {
                    List<TemplateFolder> templateFolders = state.templateFolders;
                    List<Template> templates = state.templates;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ReorderableListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        proxyDecorator: proxyDecorator,
                        children: templateFolders.map((templateFolder) {
                          return Padding(
                            key: UniqueKey(),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: TemplateFolderWidget(
                              templateFolder: templateFolder,
                              templates: templates.where((template) =>
                              template.templateFolderId == templateFolder.templateFolderId
                              ).toList()
                            ),
                          );
                        }).toList(),
                        onReorder: (int oldIndex, int newIndex) => _reorder(oldIndex, newIndex, templateFolders),
                      ),
                    );
                  } else {
                    return const Text('There was an error');
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  ///
  /// Functions
  ///

  void _createTemplate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateTemplateScreen()
      )
    );
  }

  void _reorderTemplates(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReorderTemplateScreen()
      )
    );
  }

  void _reorder(int oldIndex, int newIndex, List<TemplateFolder> templateFolders) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final TemplateFolder item = templateFolders.elementAt(oldIndex);
      templateFolders.removeAt(oldIndex);
      templateFolders.insert(newIndex, item);

      context.read<TemplateBloc>().add(ReorderTemplateFolders(
        templateFolders: templateFolders
      ));
    });
  }

  Future<void> _createTemplateFolder(BuildContext context) async {
    String? result = await showDialogWithTextField(
        context: context,
        title: 'Create New Folder',
        hintText: "Folder Name"
    );
    if (result != null) {
      final templateFolder = TemplateFolder(name: result, expanded: 1);
      context.read<TemplateBloc>().add(AddTemplateFolder(
          templateFolder: templateFolder
      ));
    }
  }

  ///
  /// Widgets
  ///
  /// Creates a shadow underneath item when reordering.
  /// Accounts for padding.
  ///
  /// [Source](https://github.com/flutter/flutter/issues/76706#issuecomment-986181379)
  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 8,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 5,
                  shadowColor: mt(context).templateFolder.dragShadowColor,
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: child,
    );
  }

  Padding quickStart() =>
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Start',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: mt(context).text.primaryColor
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              MFlatButton(
                text: Text(
                  'Start an Empty Workout',
                  style: TextStyle(
                    color: mt(context).text.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
                backgroundColor: mt(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              MFlatButton(
                text: Text(
                  'Create Template',
                  style: TextStyle(
                    color: mt(context).text.accentColor,
                    fontSize: 15,
                  ),
                ),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  Icons.post_add,
                  size: 20,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _createTemplate(context),
              ),
              const SizedBox(width: 16),
              MFlatButton(
                text: Text(
                  'Template Builder',
                  style: TextStyle(
                    color: mt(context).text.accentColor,
                    fontSize: 15,
                  ),
                ),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  Icons.polyline,
                  size: 18,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
  );

  Padding templates() =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Templates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: mt(context).text.primaryColor),
          ),
          Row(
            children: [
              MFlatButton(
                width: 35,
                height: 35,
                expand: false,
                padding: const EdgeInsets.all(5),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  size: 20,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _reorderTemplates(context),
              ),
              const SizedBox(
                width: 8,
              ),
              MFlatButton(
                width: 35,
                height: 35,
                expand: false,
                padding: const EdgeInsets.all(5),
                borderColor: mt(context).borderColor,
                icon: Icon(
                  Icons.create_new_folder_rounded,
                  size: 22,
                  color: mt(context).icon.accentColor,
                ),
                onPressed: () => _createTemplateFolder(context),
              ),
            ],
          )
        ],
      ),
    );
}

/*

  @override
  Widget build(BuildContext context) {


    return CustomScaffold.build(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => _navigateToCreateTemplateScreen(context),
            child: const Text("Create Template"),
          ),
          const Text("Paused templates:"),
          Flexible(
            fit: FlexFit.tight,
            child: Consumer<ActiveTemplateProvider>(
              builder: (context, activeTemplateProvider, child) {
                if(activeTemplateProvider.pausedActiveTemplates.length == 0 ){
                  print("emptyu");
                  return Container();
                }
                return ListView(
                  children: activeTemplateProvider.pausedActiveTemplates.map((
                      activeTemplate) {
                    return ListTile(
                      onTap: () {
                        unpauseTemplate(
                            context, activeTemplate.activeTemplateId!);
                      },
                      title: Text(activeTemplate.name),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Text("Template templates:"),
          BlocBuilder<TemplateBloc, TemplateState>(
            builder: (context, state) {
              if (state.status == TemplateStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == TemplateStatus.success) {

                final templates = state.templates;
                return Expanded(
                  child: ListView.builder(
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      final template = templates[index];

                      return ListTile(
                        title: Text(template.name),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewTemplateScreen(
                                          templateId: template.templateId!
                                      )
                              )
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Text("lol");
              }
            },
          )
        ],
      ),
      context: context,
    );
  }
*/
/*templateProvider.templates.map((template) {
return Dismissible(
key: UniqueKey(),
onDismissed: (direction) {
Provider.of<TemplateProvider>(context, listen: false)
    .deleteTemplate(template.templateId!);
},
child: ListTile(
onTap: () async {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => ViewTemplateScreen(
templateId: template.templateId!
)
)
);
},
title: Text(template.name),
subtitle: Text(template.templateId.toString()),
),
);
}).toList()*/
