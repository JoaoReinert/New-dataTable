// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:horizontal_scroll_data_table/tables/data_table_theme.dart';
import 'package:horizontal_scroll_data_table/tables/standard_data_table.dart';
import 'package:horizontal_scroll_data_table/tables/table_pagination.dart';
import 'package:intl/intl.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  final List<(String, int, String)> data = [
    ('Guilherme A. F. Brisida', 27, 'Lince Tech'),
    ('Guilherme Bailer', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
    ('João Reinert', 0, 'Lince Tech'),
  ];

  final List<(String, int, String)> data0 = [
    ('Guilherme A. F. Brisida', 27, 'Lince Tech'),
  ];

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
        body: Column(
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
                    totalCount: data.length,
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
                    itemCount: _showEmpty ? 0 : data.length,
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
                      final date = DateTime(now.year, now.month, index + 1);

                      final formattedDate = DateFormat(
                        'dd/MM/yyyy',
                      ).format(date);

                      return [Text(formattedDate)];
                    },
                    rowBuilder: (context, index) {
                      return [
                        Text('08:00'),
                        Text('12:00'),
                        Text('13:00'),
                        Text('17:00'),
                        Text('00:00'),
                        Text('00:00'),
                        Text('00:00'),
                        Text('00:00'),
                      ];
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
