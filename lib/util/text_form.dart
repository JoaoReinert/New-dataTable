import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';

/// Function of builder auto suggestion box
typedef AutoSuggestBoxItemBuilder<T> =
    Widget Function(BuildContext context, AutoSuggestBoxItemDefault2<T> item);

class AutoSuggestBoxItemDefault2<T> {
  /// The value attached to this item
  final T? value;

  /// The label that identifies this item
  ///
  /// The data is filtered based on this label
  final String label;

  /// The widget to be shown.
  ///
  /// If null, [label] is displayed
  ///
  /// Usually a [Text]
  final Widget? child;

  /// Called when this item's focus is changed.
  final ValueChanged<bool>? onFocusChange;

  /// Called when this item is selected
  final VoidCallback? onSelected;

  /// {@macro fluent_ui.controls.inputs.HoverButton.semanticLabel}
  ///
  /// If not provided, [label] is used
  final String? semanticLabel;

  bool selected = false;

  /// Creates an auto suggest box item
  AutoSuggestBoxItemDefault2({
    this.child,
    this.onSelected,
    this.semanticLabel,
    this.onFocusChange,
    required this.label,
    required this.value,
  });

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoSuggestBoxItemDefault2 && other.value == value;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return value.hashCode;
  }
}

/// Sorter AutoSuggestBoxSorter
typedef AutoSuggestBoxSorter<T> =
    List<AutoSuggestBoxItemDefault2<T>> Function(
      String text,
      List<AutoSuggestBoxItemDefault2<T>> items,
    );

class OverlayTextForm<T> extends StatefulWidget {
  /// Creates a fluent-styled auto suggest box.
  const OverlayTextForm({
    super.key,
    this.style,
    this.sorter,
    this.focusNode,
    this.focusObserver,
    this.controller,
    this.showCursor,
    this.decoration,
    this.onKey,
    this.onFocusChange,
    this.itemBuilder,
    this.placeholder,
    this.cursorColor,
    this.trailingIcon,
    this.cursorHeight,
    this.unfocusedColor,
    this.enabled = true,
    this.highlightColor,
    this.inputFormatters,
    this.textInputAction,
    this.placeholderStyle,
    this.cursorWidth = 1.5,
    this.autofocus = false,
    this.keyboardAppearance,
    this.foregroundDecoration,
    this.noResultsFoundBuilder,
    this.clearButtonEnabled = true,
    this.changeController,
    this.enableKeyboardControls = true,
    this.cursorRadius = const Radius.circular(2.0),
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.maxPopupHeight = 380.0,
    this.onClearField,
    this.suffix,
    this.text,
    this.onCancel,
    this.onConfirm,
    this.onTap,
    this.onTapOutSide,
    this.styleHeader,
    this.stylePlaceholder,
    this.header,
    this.initialValue,
    this.prefix,
    this.padding,
    this.paddingText,
    this.info,
    this.maxLength,
    this.onTapOutside,
    this.readOnly,
    this.showCount = false,
    this.isRequired = false,
    this.obscureText,
    this.boxDecoration,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.textAlign,
    this.textDirection,
    this.paddingHorizontal = 4,
    this.paddingVertical = 8,
    this.autofillHints,
    this.onFieldSubmitted,
    this.validator,
    this.actions,
    this.widthAction = 60,
    this.overlay = true,
    this.showActions = true,
  }) : autovalidateMode = AutovalidateMode.disabled;

  /// The controller used to have control over what to show on the [TextBox].
  final TextEditingController? controller;

  /// Text for sum in button
  final Text? text;

  /// Called when the text is updated
  final Function()? onCancel;

  /// Called when the user selected a value.
  final Function()? onConfirm;

  /// Called when the user selected a value.
  final Function()? onTap;

  /// Called when the user selected a value.
  final Function()? onTapOutSide;

  /// A callback function that builds the items in the overlay.
  ///
  /// Use [noResultsFoundBuilder] to build the overlay when no item is provided
  final AutoSuggestBoxItemBuilder? itemBuilder;

  /// Validate if can change controller when click
  final bool? changeController;

  /// Function of clear
  final Function()? onClearField;

  /// Widget to be displayed when none of the items fit the [sorter]
  final WidgetBuilder? noResultsFoundBuilder;

  /// Sort the [_items] based on the current query text
  ///
  /// See also:
  ///
  ///  * [OverlayTextForm.defaultItemSorter], the default item sorter
  final AutoSuggestBoxSorter<T>? sorter;

  /// A widget displayed at the start of the text box
  ///

  /// A widget displayed at the end of the text box
  ///
  /// Usually an [IconButton] or [Icon]
  final Widget? trailingIcon;

  /// Usually an [IconButton] or [Icon]
  final Widget? suffix;

  /// Whether the close button is enabled
  ///
  /// Defaults to true
  final bool clearButtonEnabled;

  /// [overlay]
  final bool overlay;

  /// The text shown when the text box is empty
  ///
  /// See also:
  ///
  ///  * [TextBox.placeholder]
  final String? placeholder;

  /// The style of [placeholder]
  ///
  /// See also:
  ///
  ///  * [TextBox.placeholderStyle]
  final TextStyle? placeholderStyle;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// Controls the [BoxDecoration] of the box behind the text input.
  final BoxDecoration? decoration;

  /// Controls the [BoxDecoration] of the box in front of the text input.
  ///
  /// If [highlightColor] is provided, this must not be provided
  final BoxDecoration? foregroundDecoration;

  /// The highlight color of the text box.
  ///
  /// If [foregroundDecoration] is provided, this must not be provided.
  ///
  /// See also:
  ///  * [unfocusedColor], displayed when the field is not focused
  final Color? highlightColor;

  /// The unfocused color of the highlight border.
  ///
  /// See also:
  ///   * [highlightColor], displayed when the field is focused
  final Color? unfocusedColor;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// The color of the cursor.
  ///
  /// The cursor indicates the current location of text insertion point in
  /// the field.
  final Color? cursorColor;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [FluentThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<String>? validator;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  final AutovalidateMode autovalidateMode;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// An object that can be used by a stateful widget to obtain the keyboard
  /// focus
  /// and to handle keyboard events.
  final FocusNode? focusNode;
  final FocusNode? focusObserver;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Whether the items can be selected using the keyboard
  ///
  /// Arrow Up - focus the item above
  /// Arrow Down - focus the item below
  /// Enter - select the current focused item
  /// Escape - close the suggestions overlay
  ///
  /// Defaults to `true`
  final bool enableKeyboardControls;

  /// Whether the text box is enabled
  ///
  /// See also:
  ///  * [TextBox.enabled]
  final bool enabled;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// List of actions in overlay method
  final List<Widget>? actions;

  /// The max height the popup can assume.
  ///
  /// The suggestion popup can assume the space available below the text box
  /// but,
  /// by default, it's limited to a 380px height. If the value provided
  /// is greater
  /// than the available space, the box is limited to the available space.s
  final double maxPopupHeight;

  /// Method for change auto focus per event [LogicalKeyboardKey.tab]
  final KeyEventResult Function(FocusNode, KeyEvent)? onKey;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// FluentTheme.of(context) .typography.body?.copyWith(
  /// fontWeight: FontWeight.bold,
  /// )
  final TextStyle? styleHeader;

  /// text style placeholder
  final TextStyle? stylePlaceholder;

  /// Header for text form box
  final String? header;

  /// Initial value
  final String? initialValue;

  /// Prefix widget for text form box
  final Widget? prefix;

  /// Padding of text form =  [PanelPadding.textForm]
  final EdgeInsetsGeometry? padding;

  /// Padding of text form =  [EdgeInsets.all(7.0)]
  final EdgeInsetsGeometry? paddingText;

  /// Info widget for text form box
  final Widget? info;

  /// Max length for text form box
  final int? maxLength;

  /// Method for on tap onTapOutside of text form box
  final Function(PointerDownEvent)? onTapOutside;

  /// Boolean interact for text form box and not write in field
  final bool? readOnly;

  /// If show count text form
  final bool showCount;

  /// Boolean for required camp for text form box
  final bool isRequired;

  /// Obscure text of text form
  final bool? obscureText;

  /// boxDecoration of text form
  final BoxDecoration? boxDecoration;

  /// Function on changed for text form box
  final void Function(String?)? onChanged;

  /// Max lines for text form box default 1
  final int? maxLines;

  /// Min lines for text form box default 1
  final int? minLines;

  /// TextInputType of type form
  final TextInputType? keyboardType;

  /// TextAlign of type form
  final TextAlign? textAlign;

  /// TextDirection of type form
  final TextDirection? textDirection;

  /// Padding  of text form Vertical
  final double paddingVertical;

  /// Padding  of text form Horizontal
  final double paddingHorizontal;

  /// Width action overlay widget
  final double widthAction;

  /// Hints to fill a text form
  final List<String>? autofillHints;

  /// Function on finish for text form box
  final Function(String?)? onFieldSubmitted;

  /// if show action confirm and cancel
  final bool? showActions;

  @override
  State<OverlayTextForm<T>> createState() => _OverlayTextFormState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'clearButtonEnabled',
        value: clearButtonEnabled,
        defaultValue: true,
        ifFalse: 'clear button disabled',
      ),
    );
  }

  /// defaultItemSorter
  List<AutoSuggestBoxItemDefault2<T>> defaultItemSorter(
    String text,
    List<AutoSuggestBoxItemDefault2<T>> items,
  ) {
    text = text.trim();
    if (text.isEmpty) return items;

    return items.where((element) {
      return element.label.toLowerCase().contains(text.toLowerCase());
    }).toList();
  }
}

class _OverlayTextFormState<T> extends State<OverlayTextForm<T>> {
  late FocusNode focusNode = widget.focusNode ?? FocusNode();
  late FocusNode focusObserver = widget.focusObserver ?? FocusNode();
  OverlayEntry? _entry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textBoxKey = GlobalKey(
    debugLabel: "AutoSuggestBox's TextBox Key",
  );

  late TextEditingController controller;
  final FocusScopeNode overlayNode = FocusScopeNode();

  AutoSuggestBoxSorter<T> get sorter =>
      widget.sorter ?? widget.defaultItemSorter;

  Size _boxSize = Size.zero;

  void updateLocalItems() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();

    controller.addListener(_handleTextChanged);
    focusNode.addListener(_handleFocusChanged);
    focusObserver.addListener(_handleFocusChanged);

    // Update the overlay when the text box size has changed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final box = _textBoxKey.currentContext!.findRenderObject() as RenderBox;
      if (_boxSize != box.size) {
        _dismissOverlay();
        _boxSize = box.size;
      }
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChanged);
    controller.removeListener(_handleTextChanged);

    {
      // If the TextEditingController and FocusNode objects are created locally,
      // we must dispose them.
      if (widget.controller == null) controller.dispose();
      if (widget.focusNode == null) focusNode.dispose();
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OverlayTextForm<T> oldWidget) {
    {
      // if the focusNode or controller objects were changed,
      // we must reflect the
      // changes here. This is mostly used for a good dev-experience with hot
      // reload, but can also be used to create fancy focus effects
      if (widget.focusNode != oldWidget.focusNode) {
        if (oldWidget.focusNode == null) focusNode.dispose();
        focusNode = widget.focusNode ?? FocusNode();
      }

      if (widget.controller != oldWidget.controller) {
        if (oldWidget.controller == null) controller.dispose();
        controller = widget.controller ?? TextEditingController();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  void _handleFocusChanged() {
    if (!widget.overlay) {
      return;
    }

    final hasFocus = focusNode.hasFocus || focusObserver.hasFocus;

    if (!hasFocus) {
      _dismissOverlay();
    } else {
      _showOverlay();
    }
    setState(() {});
  }

  void _handleTextChanged() {
    if (!mounted) return;
    if (controller.text.length < 2) setState(() {});

    updateLocalItems();

    // Update the overlay when the text box size has changed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      updateLocalItems();
      setState(() {});
    });
  }

  void _insertOverlay() {
    final overlayState = Overlay.of(
      context,
      rootOverlay: true,
      debugRequiredFor: widget,
    );

    _entry = OverlayEntry(
      builder: (context) {
        assert(debugCheckHasMediaQuery(context));

        final boxContext = _textBoxKey.currentContext;
        if (boxContext == null) return const SizedBox.shrink();
        final box = boxContext.findRenderObject() as RenderBox;

        // ancestor is not necessary here because we are not dealing with routes,
        // but overlays
        final globalOffset = box.localToGlobal(
          Offset.zero,
          ancestor: overlayState.context.findRenderObject(),
        );

        final mediaQuery = MediaQuery.of(context);
        final screenHeight =
            mediaQuery.size.height - mediaQuery.viewPadding.bottom;
        final overlayY = globalOffset.dy + box.size.height;
        final maxHeight = (screenHeight - overlayY).clamp(
          0.0,
          widget.maxPopupHeight,
        );

        Widget child = PositionedDirectional(
          width: 300,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, box.size.height + 0.8),
            child: SizedBox(
              width: box.size.width,
              child: FluentTheme(
                data: FluentTheme.of(context),
                child: _AutoSuggestBoxOverlay<T>(
                  text: widget.text,
                  widthAction: widget.widthAction,
                  node: overlayNode,
                  maxHeight: maxHeight,
                  controller: controller,
                  actions: widget.actions,
                  showActions: widget.showActions,
                  noResultsFoundBuilder: widget.noResultsFoundBuilder,
                  onConfirm: () {
                    if (widget.onConfirm != null) {
                      widget.onConfirm!.call();
                    }

                    setState(() {});

                    // After selected, the overlay is dismissed and the
                    // text box is
                    // unfocused
                    _dismissOverlay();
                  },
                  onCancel: () {
                    if (widget.onCancel != null) {
                      widget.onCancel!.call();
                    }

                    setState(() {});

                    // After selected, the overlay is dismissed and the
                    // text box is
                    // unfocused
                    _dismissOverlay();
                    focusNode.unfocus(
                      disposition: UnfocusDisposition.previouslyFocusedChild,
                    );
                  },
                ),
              ),
            ),
          ),
        );

        if (DisableAcrylic.of(context) != null) {
          child = DisableAcrylic(child: child);
        }

        return child;
      },
    );

    if (_textBoxKey.currentContext != null) {
      overlayState.insert(_entry!);
      if (mounted) setState(() {});
    }
  }

  void _dismissOverlay() {
    _entry?.remove();
    _entry = null;
  }

  void _showOverlay() {
    if (_entry == null && !(_entry?.mounted ?? false)) {
      _insertOverlay();
    }
  }

  /// Whether a [TextFormBox] is used instead of a [TextBox]
  bool get useForm => widget.validator != null;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));
    final style = TextStyle();

    final suffix =
        widget.suffix ??
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.clearButtonEnabled && widget.onClearField != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 2.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    icon: const Icon(FluentIcons.chrome_close, size: 9.0),
                    onPressed: () {
                      widget.onClearField!();
                    },
                  ),
                ),
              ),
            if (widget.trailingIcon != null) widget.trailingIcon!,
          ],
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        onKeyEvent: widget.onKey,
        focusNode: FocusNode(),
        onFocusChange: (value) {
          widget.onFocusChange?.call(value);
        },
        child: TextFormBox(
          onTapOutside: (_) {
            if (focusNode.hasFocus) {
              widget.onTapOutSide?.call();

              setState(() {});

              _dismissOverlay();
              focusNode.unfocus(
                disposition: UnfocusDisposition.previouslyFocusedChild,
              );
            }
          },
          onFieldSubmitted: (text) {
            _dismissOverlay();
            widget.onConfirm?.call();
            widget.onFieldSubmitted?.call(text);
          },
          decoration: WidgetStateProperty.resolveWith(
            (states) => BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          ),
          placeholder: widget.placeholder,
          controller: widget.controller,
          focusNode: focusNode,
          // Use the state's focusNode
          style: style!,
          highlightColor: Colors.blue,
          suffix: suffix,
          key: _textBoxKey,
          padding: widget.padding ?? const EdgeInsets.only(left: 4),
          enabled: widget.enabled,
          prefix: widget.prefix,
          validator: widget.validator,
          autofocus: widget.autofocus,
          inputFormatters: widget.inputFormatters,
          textDirection: widget.textDirection ?? TextDirection.ltr,
          textAlign: widget.textAlign ?? TextAlign.start,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          readOnly: widget.readOnly ?? false,
        ),
      ),
    );
  }
}

class _AutoSuggestBoxOverlay<T> extends StatefulWidget {
  const _AutoSuggestBoxOverlay({
    super.key,
    required this.node,
    required this.maxHeight,
    required this.widthAction,
    required this.onConfirm,
    required this.onCancel,
    required this.controller,
    required this.text,
    required this.noResultsFoundBuilder,
    required this.actions,
    this.showActions = true,
  });

  final double maxHeight;
  final double widthAction;
  final FocusScopeNode node;
  final Text? text;
  final TextEditingController controller;
  final WidgetBuilder? noResultsFoundBuilder;
  final Function() onConfirm;
  final Function() onCancel;
  final List<Widget>? actions;
  final bool? showActions;

  @override
  State<_AutoSuggestBoxOverlay<T>> createState() =>
      _AutoSuggestBoxOverlayState<T>();
}

class _AutoSuggestBoxOverlayState<T> extends State<_AutoSuggestBoxOverlay<T>> {
  /// Tile height + padding

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));

    final isEmpty = (widget.actions ?? []).isEmpty;
    return TextFieldTapRegion(
      child: Container(
        margin: const EdgeInsets.only(right: 0, left: 0),
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.controller,
          builder: (context, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.text != null)
                  Card(
                    borderRadius: BorderRadius.circular(4),
                    borderColor: Colors.orange,
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(4),
                    child: DefaultTextStyle.merge(
                      child: widget.text!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                SizedBox(
                  width: isEmpty ? 60 : widget.widthAction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.showActions ?? true) ...[
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                widget.onCancel();
                              },
                              child: material.Tooltip(
                                waitDuration: const Duration(milliseconds: 300),
                                message: 'Cancelar',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.red),
                                    color: Colors.red,
                                  ),
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    material.Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                        ),
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                widget.onConfirm();
                              },
                              child: material.Tooltip(
                                waitDuration: const Duration(milliseconds: 300),
                                message: 'Confirmar',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.green),
                                    color: Colors.green,
                                  ),
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    material.Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (widget.actions != null)
                        for (final item in widget.actions!) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                          ),
                          item,
                        ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
