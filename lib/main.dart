// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:horizontal_scroll_data_table/table_state.dart';
import 'package:horizontal_scroll_data_table/tables/data_table_theme.dart';
import 'package:horizontal_scroll_data_table/tables/standard_data_table.dart';
import 'package:horizontal_scroll_data_table/tables/table_pagination.dart';
import 'package:horizontal_scroll_data_table/util/text_form.dart';
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

/// Entrypoint of the testing application.
class MyApp extends StatelessWidget {
  /// Standard constructor
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return fluent.FluentApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: const _MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({required this.title});

  final String title;

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  bool _showEmpty = false;
  var _page = 0;
  final _totalPages = 10;

  @override
  Widget build(BuildContext context) {
    return LinceDataTableTheme(
      themeData: LinceDataTableThemeData(
        borderTheme: BorderThemeData(
          width: 1,
          radius: 12,
          color: Colors.grey.withOpacity(0.6),
        ),
        headerTheme: const HeaderThemeData(
          backgroundColor: Color.fromRGBO(219, 221, 229, 1),
        ),
        rowTheme: const RowThemeData(
          rowColor: Colors.white,
          alternateRowColor: Color.fromRGBO(245, 244, 244, 1),
        ),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: _showEmpty
              ? const Icon(Icons.refresh)
              : const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _showEmpty = !_showEmpty;
            });
          },
        ),
        body: ChangeNotifierProvider<TableState>(
          create: (context) => TableState([
            '08:00',
            '12:00',
            '13:00',
            '17:00',
            '00:00',
            '00:00',
            '00:00',
            '00:00',
          ]),
          child: Builder(
            builder: (context1) {
              final state = Provider.of<TableState>(context1, listen: false);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LinceTablePagination(
                          page: _page + 1,
                          totalPages: _totalPages,
                          totalCount: 5,
                          pageSeparator: 'de',
                          totalItemsLabel: 'itens',
                          iconColor: Colors.white,
                          buttonsColor: Colors.blueAccent,
                          onPageChange: (page) {
                            setState(() {
                              _page = page - 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        child: LinceDataTable(
                          placeholder: const Text('Nothing to see here'),
                          itemCount: _showEmpty ? 0 : 90,
                          headingRowHeight: 40,
                          dataRowHeight: 40,
                          padding: const EdgeInsets.all(8),
                          onSort: (index, sortKey, order) {
                            print('index -> $index [$sortKey] = $order');
                          },
                          minWidth: 1190,
                          maxWidth: 10000,
                          fixedColumns: [
                            LinceDataTableColumn.width(
                              alignment: ColumnAlignment.center,
                              300,
                              sortKey: 'Data',
                              sortable: true,
                              header: Text('Data'),
                            ),
                          ],
                          columns: const [
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '1 entrada',
                              sortable: true,
                              header: Text('1 entrada'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '1 saida',
                              sortable: true,
                              header: Text('1 saida'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '2 entrada',
                              sortable: true,
                              header: Text('2 entrada'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '2 saida',
                              header: Text('2 saida'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '3 entrada',
                              header: Text('3 saida'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '3 saida',
                              header: Text('3 saida'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '4 entrada',
                              header: Text('4 entrada'),
                            ),
                            LinceDataTableColumn.width(
                              80,
                              sortKey: '4 saida',
                              header: Text('4 saida'),
                            ),
                          ],
                          fixedRowBuilder: (context, index) {
                            final now = DateTime.now();
                            final date = DateTime(
                              now.year,
                              now.month,
                              index + 1,
                            );

                            final formattedDate = DateFormat(
                              'dd/MM/yyyy',
                            ).format(date);

                            return [Text(formattedDate)];
                          },
                          rowBuilder: (context, index) {
                            print('build row $index');

                            return [
                              for (final (i, item) in state.list.indexed)
                                _TextFormItem(
                                  text: item,
                                  index: index,
                                  position: i,
                                ),
                            ];
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TextFormItem extends StatelessWidget {
  const _TextFormItem({
    required this.text,
    required this.index,
    required this.position,
  });

  final String text;
  final int index;
  final int position;

  @override
  Widget build(BuildContext context) {
    final clicked = context.select<TableState, bool>(
      (state) => state.mapIndex["$position,$index"] ?? false,
    );

    if (clicked) {
      final (controller, focusNode) = context
          .select<TableState, (TextEditingController, FocusNode)>(
            (state) => (state.controller, state.focusNode),
          );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.text = text;
        focusNode.requestFocus();
      });
      return SizedBox(
        width: 45,
        height: 20,
        child: OverlayTextForm(
          text: Text('Batida de ponto original: $text'),
          controller: controller,
          focusNode: focusNode,
          highlightColor: Colors.blue,
          style: TextStyle(color: Colors.grey.withValues(alpha: 0.4)),
          showActions: false,
          inputFormatters: [
            MaskTextInputFormatter(mask: '##:##', initialText: controller.text),
          ],
        ),
      );
    }

    return SizedBox(
      width: 45,
      height: 20,
      child: InkWell(
        onTap: () {
          context.read<TableState>().setClicked(position, index);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(193, 193, 209, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
