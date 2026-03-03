// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:horizontal_scroll_data_table/tables/data_table_theme.dart';
import 'package:horizontal_scroll_data_table/tables/standard_data_table.dart';
import 'package:horizontal_scroll_data_table/tables/table_pagination.dart';

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
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
    ('Guilherme F. Santos', 0, 'Lince Tech'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinceTablePagination(
                    page: _page + 1,
                    totalPages: _totalPages,
                    totalCount: data.length,
                    pageSeparator: 'de',
                    totalItemsLabel: 'itens',
                    iconColor: Colors.red,
                    buttonsColor: Colors.orange,
                    onPageChange: (page) {
                      setState(() {
                        _page = page - 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  // width: 1000,
                  height: 500,
                  child: LinceDataTable(
                    placeholder: const Text('Nothing to see here'),
                    itemCount: _showEmpty ? 0 : data.length,
                    headingRowHeight: 40,
                    padding: const EdgeInsets.all(8),
                    onSort: (index, sortKey, order) {
                      // todo: here we apply the desired sorting method
                      print('index -> $index [$sortKey] = $order');
                    },
                    // setting the minWidth is important to avoid overflowing
                    // flex columns when the windows gets resized
                    minWidth: 1190,
                    maxWidth: 10000,
                    fixedColumns: [
                      LinceDataTableColumn.width(
                        75,
                        sortKey: 'id',
                        sortable: true,
                        header: Text('ID'),
                      ),
                    ],
                    columns: const [
                      LinceDataTableColumn.width(
                        75,
                        sortKey: 'id',
                        sortable: true,
                        header: Text('ID'),
                      ),
                      LinceDataTableColumn.width(
                        75,
                        sortKey: 'id',
                        sortable: true,
                        header: Text('ID'),
                      ),
                      LinceDataTableColumn.width(
                        300,
                        sortKey: 'nome',
                        sortable: true,
                        header: Text('Nome'),
                        tooltip: 'Nome do funcionario',
                      ),
                      LinceDataTableColumn.width(
                        175,
                        sortKey: 'idade',
                        header: Text('Idade'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        100,
                        sortKey: 'empresa',
                        header: Text('Empresa'),
                      ),
                      LinceDataTableColumn.width(
                        90,
                        sortKey: 'acao',
                        header: Text('Ação'),
                      ),
                    ],
                    fixedRowBuilder: (context, index) {
                      return [const Text('0')];
                    },
                    rowBuilder: (context, index) {
                      final (nome, idade, empresa) = data[index];
                      return [
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                nome,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text('$idade'),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Text(empresa),
                        Row(
                          children: [
                            IconButton(
                              iconSize: 18,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                print('Call delete on index $index');
                              },
                            ),
                            IconButton(
                              iconSize: 18,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                print('Call edit on index $index');
                              },
                            ),
                          ],
                        ),
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
