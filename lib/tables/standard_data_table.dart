import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data_table_theme.dart';

/// Contains the data used to define a column.
class LinceDataTableColumn {
  // this constructor is private to avoid calling without specifying at
  // ignore: unused_element
  const LinceDataTableColumn._({
    required this.alignment,
    required this.tooltip,
    required this.sortable,
    required this.flex,
    required this.sortKey,
    required this.width,
    required this.header,
  });

  /// Creates a column that expand proportionally to the total flex of all
  /// columns.
  const LinceDataTableColumn.flex(
    this.flex, {
    this.tooltip,
    this.sortable = false,
    this.alignment = ColumnAlignment.left,
    required this.sortKey,
    required this.header,
  }) : assert(flex != null),
       width = null;

  /// Creates a column with a fixed size that does not change.
  const LinceDataTableColumn.width(
    this.width, {
    this.tooltip,
    this.sortable = false,
    this.alignment = ColumnAlignment.left,
    required this.sortKey,
    required this.header,
  }) : assert(width != null),
       flex = null;

  /// When [width] is null, the column will be expanded according to [flex], if
  /// [flex] is null, defaults to 1.
  final int? flex;

  /// Setting the width will force this column to use a fixed width.
  final double? width;

  /// The widget to render at the head of a column.
  final Widget header;

  /// Customize a tooltip for this column header.
  final String? tooltip;

  /// Can be used to identify this column for sorting purposes.
  final String sortKey;

  /// Whether this column can be used for sorting the data table.
  final bool sortable;

  /// Defines how to align this column header and cells.
  final ColumnAlignment alignment;
}

/// Defines the supported table column horizontal alignments.
enum ColumnAlignment {
  /// Align the column header and rows to the left.
  left,

  /// Align the column header and rows to the right.
  right,

  /// Align the column header and rows to the center.
  center,
}

/// Defines the supported sorting directions for a sortable column.
enum SortingOrder {
  /// Not sorted
  unsorted,

  /// Sort by the column in ascending order.
  ascending,

  /// Sort by the column in descending order.
  descending,
}

/// Widget used to render a customizable data table.
class LinceDataTable extends StatefulWidget {
  /// Standard constructor
  const LinceDataTable({
    super.key,
    this.title,
    this.thumbVisibility,
    this.sortColumnIndex,
    this.placeholder,
    this.padding = const EdgeInsets.all(0),
    this.itemPadding = const EdgeInsets.all(8),
    this.maxWidth,
    this.minWidth,
    this.onSort,
    this.dataRowHeight,
    required this.itemCount,
    required this.headingRowHeight,
    required this.columns,
    this.fixedColumns,
    required this.rowBuilder,
    this.fixedRowBuilder,
  });

  /// The padding to apply around the table component.
  final EdgeInsets padding;

  /// The padding applied to the items of this table, both the title and cells.
  final EdgeInsets itemPadding;

  /// The number of items in this data table.
  final int itemCount;

  /// String for table title text.
  final String? title;

  /// The maximum width allowed for this data table
  final double? maxWidth;

  /// The smallest width allowed for this data table
  final double? minWidth;

  /// The height of the rows in this table.
  final double? dataRowHeight;

  /// The height of the heading of this widget.
  final double headingRowHeight;

  /// The index of the column used to sort this table.
  final int? sortColumnIndex;

  /// The widget to be displayed when the table has no data to display.
  final Widget? placeholder;

  /// Whether the scrollbar thumb tracker should be visible.
  /// When null, defaults to false.
  final bool? thumbVisibility;

  /// The list of columns in this table.
  final List<LinceDataTableColumn> columns;

  final List<LinceDataTableColumn>? fixedColumns;

  /// This method is called when interacting with a column header.
  final Function(int index, String columnKey, SortingOrder order)? onSort;

  /// Called to build each row of the table.
  ///
  /// The size of the returned list of widgets must match the number of columns
  /// defined for this table.
  final List<Widget> Function(BuildContext context, int index) rowBuilder;

  final List<Widget> Function(BuildContext context, int index)? fixedRowBuilder;

  @override
  State<StatefulWidget> createState() => _LinceDataTableState();
}

class _LinceDataTableState extends State<LinceDataTable> {
  int? _sortIndex;
  var _sortingOrder = SortingOrder.unsorted;
  final _horizontalController = ScrollController();
  final _verticalController = ScrollController();
  final _fixedVerticalController = ScrollController();

  void _handleSortChange(int index) {
    if (index == _sortIndex) {
      final nextIndex = _sortingOrder.index < SortingOrder.values.length - 1
          ? _sortingOrder.index + 1
          : 0;
      setState(() {
        _sortingOrder = SortingOrder.values[nextIndex];
      });
    } else {
      setState(() {
        _sortIndex = index;
        _sortingOrder = SortingOrder.ascending;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData =
        LinceDataTableTheme.maybeOf(context)?.themeData ??
        defaultLinceDataTableTheme;

    final isEmpty = widget.itemCount == 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final upperWidth = constraints.maxWidth;

        var useWidth = upperWidth;

        if (widget.minWidth != null &&
            widget.minWidth! > 0 &&
            widget.minWidth! > upperWidth) {
          useWidth = widget.minWidth!;
        } else if (widget.maxWidth != null &&
            widget.maxWidth! > 0 &&
            widget.maxWidth! < upperWidth) {
          useWidth = widget.maxWidth!;
        } else {
          useWidth = upperWidth;
        }

        useWidth -= widget.padding.horizontal;

        var useFixedWidth = 0.0;
        for (final item in widget.fixedColumns ?? []) {
          useFixedWidth += item.width ?? 0;
        }

        final side = BorderSide(
          width: themeData.borderTheme.width ?? 0,
          color: themeData.borderTheme.color ?? Colors.transparent,
          style: BorderStyle.solid,
        );

        return Padding(
          padding: widget.padding,
          child: Row(
            children: [
              if (widget.fixedColumns != null && widget.fixedRowBuilder != null)
                SizedBox(
                  width: useFixedWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        themeData.borderTheme.radius ?? 0,
                      ),
                      border: Border.all(
                        width: themeData.borderTheme.width ?? 0,
                        color:
                            themeData.borderTheme.color ?? Colors.transparent,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(themeData.borderTheme.width ?? 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          themeData.borderTheme.radius ?? 0,
                        ),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            _verticalController.jumpTo(
                              _fixedVerticalController.offset,
                            );
                            return true;
                          },
                          child: CustomScrollView(
                            controller: _fixedVerticalController,
                            slivers: [
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: _LinceDataTableHeader(
                                  themeData: themeData,
                                  height: widget.headingRowHeight,
                                  content: Expanded(
                                    child: Row(
                                      children: widget.fixedColumns!.indexed
                                          .map((column) {
                                            final handleSort =
                                                column.$2.sortable
                                                ? widget.onSort
                                                : null;

                                            final isSorted =
                                                _sortIndex == column.$1;

                                            Widget child = Row(
                                              children: [
                                                Expanded(
                                                  child: column.$2.header,
                                                ),
                                                if (isSorted)
                                                  switch (_sortingOrder) {
                                                    SortingOrder.ascending =>
                                                      const Icon(
                                                        Icons.arrow_drop_up,
                                                      ),
                                                    SortingOrder.descending =>
                                                      const Icon(
                                                        Icons.arrow_drop_down,
                                                      ),
                                                    _ => const SizedBox(),
                                                  },
                                              ],
                                            );

                                            child = Container(
                                              width: column.$2.width,
                                              padding: widget.itemPadding,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right:
                                                      column.$1 <
                                                          widget
                                                                  .columns
                                                                  .length -
                                                              1
                                                      ? side
                                                      : BorderSide.none,
                                                ),
                                              ),
                                              child: child,
                                            );

                                            if (column.$2.tooltip != null) {
                                              child = Tooltip(
                                                message: column.$2.tooltip,
                                                child: child,
                                              );
                                            }

                                            child = InkWell(
                                              onTap: handleSort == null
                                                  ? null
                                                  : () {
                                                      _handleSortChange(
                                                        column.$1,
                                                      );
                                                      handleSort(
                                                        column.$1,
                                                        column.$2.sortKey,
                                                        _sortingOrder,
                                                      );
                                                    },
                                              child: child,
                                            );

                                            if (column.$2.width == null) {
                                              child = Expanded(
                                                flex: column.$2.flex ?? 1,
                                                child: child,
                                              );
                                            }

                                            return child;
                                          })
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              if (isEmpty)
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Center(
                                    child:
                                        widget.placeholder ??
                                        const SizedBox(),
                                  ),
                                )
                              else
                                SliverList.builder(
                                  itemCount: widget.itemCount,
                                  itemBuilder: (context, index) {
                                    return _LinceDataTableWidthItem(
                                      themeData: themeData,
                                      index: index,
                                      itemCount: widget.itemCount,
                                      columns: widget.fixedColumns!,
                                      constraints:
                                          widget.dataRowHeight != null
                                          ? BoxConstraints(
                                              minWidth: useFixedWidth,
                                              maxWidth: useFixedWidth,
                                              minHeight:
                                                  widget.dataRowHeight!,
                                              maxHeight:
                                                  widget.dataRowHeight!,
                                            )
                                          : null,
                                      padding: widget.itemPadding,
                                      builder: widget.fixedRowBuilder!,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              Expanded(
                child: Scrollbar(
                  controller: _horizontalController,
                  trackVisibility: true,
                  thumbVisibility: widget.thumbVisibility,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: useWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            themeData.borderTheme.radius ?? 0,
                          ),
                          border: Border.all(
                            width: themeData.borderTheme.width ?? 0,
                            color:
                                themeData.borderTheme.color ??
                                Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            themeData.borderTheme.width ?? 0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              themeData.borderTheme.radius ?? 0,
                            ),
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                _fixedVerticalController.jumpTo(
                                  _verticalController.offset,
                                );
                                return true;
                              },
                              child: Scrollbar(
                                controller: _verticalController,
                                trackVisibility: true,
                                thumbVisibility: widget.thumbVisibility,
                                child: CustomScrollView(
                                  controller: _verticalController,
                                  slivers: [
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _LinceDataTableHeader(
                                        themeData: themeData,
                                        height: widget.headingRowHeight,
                                        content: Expanded(
                                          child: Row(
                                            children: widget.columns.indexed.map((
                                              column,
                                            ) {
                                              final handleSort =
                                                  column.$2.sortable
                                                  ? widget.onSort
                                                  : null;

                                              final isSorted =
                                                  _sortIndex == column.$1;

                                              Widget child = Row(
                                                children: [
                                                  Expanded(
                                                    child: column.$2.header,
                                                  ),
                                                  if (isSorted)
                                                    switch (_sortingOrder) {
                                                      SortingOrder.ascending =>
                                                        const Icon(
                                                          Icons.arrow_drop_up,
                                                        ),
                                                      SortingOrder.descending =>
                                                        const Icon(
                                                          Icons.arrow_drop_down,
                                                        ),
                                                      _ => const SizedBox(),
                                                    },
                                                ],
                                              );

                                              child = Container(
                                                width: column.$2.width,
                                                padding: widget.itemPadding,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right:
                                                        column.$1 <
                                                            widget
                                                                    .columns
                                                                    .length -
                                                                1
                                                        ? side
                                                        : BorderSide.none,
                                                  ),
                                                ),
                                                child: child,
                                              );

                                              if (column.$2.tooltip != null) {
                                                child = Tooltip(
                                                  message: column.$2.tooltip,
                                                  child: child,
                                                );
                                              }

                                              child = InkWell(
                                                onTap: handleSort == null
                                                    ? null
                                                    : () {
                                                        _handleSortChange(
                                                          column.$1,
                                                        );
                                                        handleSort(
                                                          column.$1,
                                                          column.$2.sortKey,
                                                          _sortingOrder,
                                                        );
                                                      },
                                                child: child,
                                              );

                                              if (column.$2.width == null) {
                                                child = Expanded(
                                                  flex: column.$2.flex ?? 1,
                                                  child: child,
                                                );
                                              }

                                              return child;
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (isEmpty)
                                      SliverFillRemaining(
                                        hasScrollBody: false,
                                        child: Center(
                                          child:
                                              widget.placeholder ??
                                              const SizedBox(),
                                        ),
                                      )
                                    else
                                      SliverList.builder(
                                        itemCount: widget.itemCount,
                                        itemBuilder: (context, index) {
                                          return _LinceDataTableWidthItem(
                                            themeData: themeData,
                                            index: index,
                                            itemCount: widget.itemCount,
                                            columns: widget.columns,
                                            constraints:
                                                widget.dataRowHeight != null
                                                ? BoxConstraints(
                                                    minWidth: useWidth,
                                                    maxWidth: useWidth,
                                                    minHeight:
                                                        widget.dataRowHeight!,
                                                    maxHeight:
                                                        widget.dataRowHeight!,
                                                  )
                                                : null,
                                            padding: widget.itemPadding,
                                            builder: widget.rowBuilder,
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();

    super.dispose();
  }
}

class _LinceDataTableHeader extends SliverPersistentHeaderDelegate {
  const _LinceDataTableHeader({
    required this.themeData,
    required this.content,
    required this.height,
  });

  final double height;
  final Widget content;
  final LinceDataTableThemeData themeData;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color:
            themeData.headerTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            width: themeData.borderTheme.width ?? 0,
            color: themeData.borderTheme.color ?? Colors.transparent,
            style: BorderStyle.solid,
          ),
        ),
      ),
      height: height,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleSmall!,
        child: SizedBox(child: content),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _LinceDataTableWidthItem extends StatelessWidget {
  const _LinceDataTableWidthItem({
    required this.themeData,
    required this.index,
    required this.itemCount,
    required this.padding,
    required this.constraints,
    required this.columns,
    required this.builder,
  });

  final int index;
  final int itemCount;
  final EdgeInsets padding;
  final BoxConstraints? constraints;
  final List<LinceDataTableColumn> columns;
  final List<Widget> Function(BuildContext context, int index) builder;
  final LinceDataTableThemeData themeData;

  @override
  Widget build(BuildContext context) {
    final side = BorderSide(
      width: themeData.borderTheme.width ?? 0,
      color: themeData.borderTheme.color ?? Colors.transparent,
      style: BorderStyle.solid,
    );

    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: builder(context, index).indexed.map((pair) {
        final column = columns[pair.$1];
        if (column.width != null) {
          return SizedBox(
            width: column.width,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                border: Border(
                  right: pair.$1 < columns.length - 1 ? side : BorderSide.none,
                ),
              ),
              child: Row(
                children: [Expanded(child: ClipRect(child: pair.$2))],
              ),
            ),
          );
        }

        return Expanded(
          flex: column.flex ?? 1,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: Border(
                right: pair.$1 < columns.length - 1 ? side : BorderSide.none,
              ),
            ),
            child: Row(
              children: [Expanded(child: ClipRect(child: pair.$2))],
            ),
          ),
        );
      }).toList(),
    );

    if (constraints != null) {
      child = ConstrainedBox(constraints: constraints!, child: child);
    } else {
      child = IntrinsicHeight(child: child);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven
            ? themeData.rowTheme?.rowColor
            : themeData.rowTheme?.alternateRowColor,
        border: Border(bottom: side),
      ),
      child: child,
    );
  }
}
