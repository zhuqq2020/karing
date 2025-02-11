import 'package:flutter/material.dart';
import 'package:karing/i18n/strings.g.dart';
import 'package:karing/screens/dialog_utils.dart';
import 'package:karing/screens/theme_config.dart';
import 'package:karing/screens/theme_define.dart';
import 'package:karing/screens/widgets/framework.dart';

class ListAddScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routSettings(String viewTag) {
    return RouteSettings(name: "ListAddScreen:$viewTag");
  }

  final String title;
  final List<String> data;
  final String dialogTitle;
  final String dialogTextHit;
  const ListAddScreen({
    super.key,
    required this.title,
    required this.data,
    this.dialogTitle = "",
    this.dialogTextHit = "",
  });

  @override
  State<ListAddScreen> createState() =>
      _ServerSelectSearchSettingsScreenState();
}

class _ServerSelectSearchSettingsScreenState
    extends LasyRenderingState<ListAddScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 26,
                        ),
                      ),
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: ThemeConfig.kFontWeightTitle,
                          fontSize: ThemeConfig.kFontSizeTitle),
                    ),
                    InkWell(
                      onTap: () async {
                        onTapAdd();
                      },
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(
                          Icons.add_outlined,
                          size: 26,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _loadListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadListView() {
    Size windowSize = MediaQuery.of(context).size;
    return Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          itemCount: widget.data.length,
          itemExtent: ThemeConfig.kListItemHeight2,
          itemBuilder: (BuildContext context, int index) {
            var current = widget.data[index];
            return createWidget(index, current, windowSize);
          },
        ));
  }

  Widget createWidget(int index, dynamic current, Size windowSize) {
    const double rightWidth = 30.0;
    double centerWidth = windowSize.width - rightWidth - 20;

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        borderRadius: ThemeDefine.kBorderRadius,
        child: InkWell(
          onTap: () {
            Navigator.pop(context, current);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          SizedBox(
                            width: centerWidth,
                            child: Text(
                              current,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ThemeConfig.kFontSizeGroupItem,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: rightWidth,
                              height: ThemeConfig.kListItemHeight2 - 2,
                              child: InkWell(
                                onTap: () async {
                                  onTapDelete(current);
                                },
                                child: const Icon(
                                  Icons.remove_circle_outlined,
                                  size: 26,
                                  color: Colors.red,
                                ),
                              ))
                        ]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapAdd() async {
    final tcontext = Translations.of(context);
    String? text = await DialogUtils.showTextInputDialog(
        context,
        widget.dialogTitle.isNotEmpty ? widget.dialogTitle : tcontext.add,
        "",
        widget.dialogTextHit.isNotEmpty ? widget.dialogTextHit : "",
        null, (text) {
      text = text.trim();
      if (text.isEmpty) {
        return false;
      }

      return true;
    });
    if (text == null) {
      return;
    }
    if (widget.data.contains(text)) {
      return;
    }
    widget.data.add(text);
    setState(() {});
  }

  void onTapDelete(String text) {
    widget.data.remove(text);

    setState(() {});
  }
}
