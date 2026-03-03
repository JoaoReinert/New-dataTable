import 'package:flutter/material.dart';

/// Shows a pagination widget, with the buttons used to go forward and backwards
/// in the pages of a data table.
class LinceTablePagination extends StatelessWidget {
  /// Standard constructor
  const LinceTablePagination({
    super.key,
    this.buttonsColor,
    this.onPageChange,
    this.iconForward,
    this.iconBackward,
    this.iconColor,
    this.pageSeparator = '/',
    this.totalItemsLabel = 'rows',
    required this.page,
    required this.totalPages,
    required this.totalCount,
  });

  /// The number of the current selected page.
  ///
  /// This is be the value that is displayed to the user, so the page starts at
  /// 0 (zero) and goes up to [totalPages] (inclusive).
  final int page;

  /// The total number of pages.
  final int totalPages;

  /// The total number of rows in the current page of the data table.
  final int totalCount;

  /// The color of the forward/backward buttons.
  final Color? buttonsColor;

  /// The icon used for the forward button.
  final IconData? iconForward;

  /// The icon used for the backward buttons.
  final IconData? iconBackward;

  /// The color of the forward/backward button icons.
  final Color? iconColor;

  /// Defines the label shown after the number of rows in the current page of
  /// the table, defaults to 'rows'.
  final String pageSeparator;

  /// Defines how the current page number is separated from the total page
  /// number, defaults to '/'.
  final String totalItemsLabel;

  /// This method is called when the used interacts with the forward/backward
  /// buttons, with the desired page to be loaded.
  final void Function(int page)? onPageChange;

  @override
  Widget build(BuildContext context) {
    final disabledColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3) ??
            Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LinceStandardTablePaginationButton.backward(
          color: buttonsColor,
          disabled: page <= 1,
          iconColor: iconColor,
          icon: iconForward,
          onPressed:
          (onPageChange != null) ? () => onPageChange!(page - 1) : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Text(
                  '$page $pageSeparator $totalPages',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color:
                    buttonsColor ?? Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                '$totalCount $totalItemsLabel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
        _LinceStandardTablePaginationButton.forward(
          color: buttonsColor,
          disabled: page >= totalPages,
          iconColor: iconColor,
          icon: iconBackward,
          onPressed:
          (onPageChange != null) ? () => onPageChange!(page + 1) : null,
        ),
      ],
    );
  }
}

class _LinceStandardTablePaginationButton extends StatelessWidget {
  // ignore: unused_element
  const _LinceStandardTablePaginationButton._()
      : _isBackward = false,
        color = Colors.white,
        iconColor = Colors.white,
        onPressed = null,
        disabled = false,
        icon = Icons.question_mark;

  const _LinceStandardTablePaginationButton.forward({
    this.color,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.disabled = false,
  }) : _isBackward = false;

  const _LinceStandardTablePaginationButton.backward({
    this.color,
    this.icon,
    this.iconColor,
    this.onPressed,
    this.disabled = false,
  }) : _isBackward = true;

  final bool _isBackward;
  final bool disabled;
  final Color? color;
  final Color? iconColor;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final defaultIcon = _isBackward ? Icons.chevron_left : Icons.chevron_right;
    return Material(
      borderRadius: BorderRadius.circular(9999),
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: InkWell(
          onTap: disabled ? null : onPressed,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                icon ?? defaultIcon,
                color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
