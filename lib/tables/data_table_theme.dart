import 'package:flutter/material.dart';

/// Allows the header of the table to be customized according to your
/// specific requirements.
@immutable
class HeaderThemeData {
  /// Standard constructor.
  const HeaderThemeData({
    this.backgroundColor,
  });

  /// The background color of the header cells.
  final Color? backgroundColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HeaderThemeData &&
              runtimeType == other.runtimeType &&
              backgroundColor == other.backgroundColor;

  @override
  int get hashCode => backgroundColor.hashCode;
}

/// Allows the border of the table to be customized according to your
/// specific requirements.
@immutable
class BorderThemeData {
  /// Standard constructor.
  const BorderThemeData({
    this.width,
    this.color,
    this.radius,
  });

  /// The width of the border.
  final double? width;

  /// The color of the border.
  final Color? color;

  /// Specify the radius to use rounded borders.
  final double? radius;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BorderThemeData &&
              runtimeType == other.runtimeType &&
              width == other.width &&
              color == other.color &&
              radius == other.radius;

  @override
  int get hashCode => width.hashCode ^ color.hashCode ^ radius.hashCode;
}

/// Allows the rows of the table to be customized according to your
/// specific requirements.
@immutable
class RowThemeData {
  /// Standard constructor.
  const RowThemeData({
    required this.rowColor,
    required this.alternateRowColor,
  });

  /// The background color used for all cells in a table row.
  final Color rowColor;

  /// The background color to be used for every other row, to create an
  /// alternating color pattern in the table.
  final Color alternateRowColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RowThemeData &&
              runtimeType == other.runtimeType &&
              rowColor == other.rowColor &&
              alternateRowColor == other.alternateRowColor;

  @override
  int get hashCode => rowColor.hashCode ^ alternateRowColor.hashCode;
}

/// This theme can be used to customize the tables used in an application.
@immutable
class LinceDataTableThemeData {
  /// Standard constructor.
  const LinceDataTableThemeData({
    this.headerTheme = const HeaderThemeData(),
    this.borderTheme = const BorderThemeData(),
    this.rowTheme,
  });

  /// Customize the table header.
  final HeaderThemeData headerTheme;

  /// Customize the table border.
  final BorderThemeData borderTheme;

  /// Customize the table rows.
  final RowThemeData? rowTheme;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LinceDataTableThemeData &&
              runtimeType == other.runtimeType &&
              headerTheme == other.headerTheme &&
              borderTheme == other.borderTheme &&
              rowTheme == other.rowTheme;

  @override
  int get hashCode =>
      headerTheme.hashCode ^ borderTheme.hashCode ^ rowTheme.hashCode;
}

/// The default theme used for the lince data table.
const defaultLinceDataTableTheme = LinceDataTableThemeData(
  borderTheme: BorderThemeData(
    width: 1,
    radius: 12,
    color: Color.fromRGBO(158, 158, 158, 0.6),
  ),
  headerTheme: HeaderThemeData(
    backgroundColor: Color.fromRGBO(219, 221, 229, 1),
  ),
  rowTheme: RowThemeData(
    rowColor: Color.fromRGBO(255, 255, 255, 1),
    alternateRowColor: Color.fromRGBO(245, 244, 244, 1),
  ),
);

/// Injects the lince data table in the context, to simplify creating a standard
/// theme to customize multiple the tables at once.
class LinceDataTableTheme extends InheritedWidget {
  /// Standard constructor.
  const LinceDataTableTheme({
    super.key,
    this.themeData = defaultLinceDataTableTheme,
    required super.child,
  });

  /// Retrieves the theme to be used by [LinceDataTable] widgets, if there is a
  /// theme in the context.
  static LinceDataTableTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LinceDataTableTheme>();
  }

  /// Retrieves a [LinceDataTable] from the context.
  ///
  /// The theme must have been set up beforehand, otherwise use [maybeOf].
  static LinceDataTableTheme of(BuildContext context) {
    final dataTableTheme = maybeOf(context);
    assert(dataTableTheme != null, 'No DataTableTheme found in context');
    return dataTableTheme!;
  }

  /// Contains the actual data for this theme.
  final LinceDataTableThemeData themeData;

  @override
  bool updateShouldNotify(covariant LinceDataTableTheme oldWidget) {
    return oldWidget.themeData != themeData;
  }
}
