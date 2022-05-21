// library reactive_dropdown_search;
//
// // Use of this source code is governed by the MIT license that can be
// // found in the LICENSE file.
//
// import 'package:flutter/material.dart';
// import 'package:p_design/p_design.dart';
// import 'package:reactive_forms/reactive_forms.dart';
//
// class ReactiveChipSelect<T, V> extends ReactiveFormField<T, V> {
//   ReactiveChipSelect({
//     Key? key,
//     String? formControlName,
//     FormControl<T>? formControl,
//     ValidationMessagesFunction? validationMessages,
//     ControlValueAccessor<T, V>? valueAccessor,
//     ShowErrorsFunction? showErrors,
//
//     ///////////////////////////////////////////////////////////////////////////
//     required String Function(V item) itemAsString,
//     String? label,
//     String? hint,
//     bool isFilteredOnline = false,
//     Widget? popupTitle,
//     List<V> items = const [],
//     Color? popupBackgroundColor,
//     double? maxHeight,
//     bool showSelectedItems = false,
//     InputDecoration? decoration,
//     bool showAsSuffixIcons = false,
//     double? dialogMaxWidth,
//     Widget? clearButton,
//     Widget? dropDownButton,
//     Color? popupBarrierColor,
//     Duration? searchDelay,
//     bool showFavoriteItems = false,
//     MainAxisAlignment? favoriteItemsAlignment,
//     double? clearButtonSplashRadius,
//     double? dropdownButtonSplashRadius,
//     TextStyle? dropdownSearchBaseStyle,
//     TextAlign? dropdownSearchTextAlign,
//     TextAlignVertical? dropdownSearchTextAlignVertical,
//     double popupElevation = 8,
//     FocusNode? focusNode,
//   }) : super(
//           key: key,
//           formControl: formControl,
//           formControlName: formControlName,
//           valueAccessor: valueAccessor,
//           validationMessages: validationMessages,
//           showErrors: showErrors,
//           builder: (field) {
//             final InputDecoration effectiveDecoration = (decoration ??
//                     const InputDecoration())
//                 .applyDefaults(Theme.of(field.context).inputDecorationTheme);
//
//             final state = field as _ReactiveDropdownSearchState<T, V>;
//
//             state._setFocusNode(focusNode);
//
//             return CustomChipSelect(
//               onChanged: field.didChange,
//               itemAsString: itemAsString,
//               items: items,
//             );
//
//             return DropdownSearch<V>(
//               onChanged: field.didChange,
//               mode: mode,
//               // ignore: deprecated_member_use
//               label: label,
//               // ignore: deprecated_member_use
//               hint: hint,
//               isFilteredOnline: isFilteredOnline,
//               popupTitle: popupTitle,
//               items: items,
//               selectedItem: field.value,
//               onFind: onFind,
//               dropdownBuilder: dropdownBuilder,
//               popupItemBuilder: popupItemBuilder,
//               showSearchBox: showSearchBox,
//               showClearButton: showClearButton,
//               popupBackgroundColor: popupBackgroundColor,
//               enabled: field.control.enabled,
//               maxHeight: maxHeight,
//               filterFn: filterFn,
//               itemAsString: itemAsString,
//               showSelectedItems: showSelectedItems,
//               compareFn: compareFn,
//               dropdownSearchDecoration:
//                   effectiveDecoration.copyWith(errorText: field.errorText),
//               emptyBuilder: emptyBuilder,
//               loadingBuilder: loadingBuilder,
//               errorBuilder: errorBuilder,
//               dialogMaxWidth: dialogMaxWidth,
//               clearButton: clearButton,
//               clearButtonBuilder: clearButtonBuilder,
//               clearButtonSplashRadius: clearButtonSplashRadius,
//               dropDownButton: dropDownButton,
//               dropdownButtonBuilder: dropdownButtonBuilder,
//               dropdownButtonSplashRadius: dropdownButtonSplashRadius,
//               dropdownBuilderSupportsNullItem: dropdownBuilderSupportsNullItem,
//               popupShape: popupShape,
//               showAsSuffixIcons: showAsSuffixIcons,
//               popupItemDisabled: popupItemDisabled,
//               popupBarrierColor: popupBarrierColor,
//               onPopupDismissed: () {
//                 field.control.markAsTouched();
//                 onPopupDismissed?.call();
//               },
//               searchDelay: searchDelay,
//               onBeforeChange: onBeforeChange,
//               showFavoriteItems: showFavoriteItems,
//               favoriteItemBuilder: favoriteItemBuilder,
//               favoriteItems: favoriteItems,
//               favoriteItemsAlignment: favoriteItemsAlignment,
//               popupSafeArea: popupSafeArea,
//               searchFieldProps: searchFieldProps,
//               scrollbarProps: scrollbarProps,
//               popupBarrierDismissible: popupBarrierDismissible,
//               dropdownSearchBaseStyle: dropdownSearchBaseStyle,
//               dropdownSearchTextAlign: dropdownSearchTextAlign,
//               dropdownSearchTextAlignVertical: dropdownSearchTextAlignVertical,
//               popupElevation: popupElevation,
//               selectionListViewProps: selectionListViewProps,
//               focusNode: state.focusNode,
//               positionCallback: positionCallback,
//             );
//           },
//         );
//
//   @override
//   ReactiveFormFieldState<T, V> createState() =>
//       _ReactiveDropdownSearchState<T, V>();
// }
//
// class _ReactiveDropdownSearchState<T, V> extends ReactiveFormFieldState<T, V> {
//   FocusNode? _focusNode;
//   late FocusController _focusController;
//
//   FocusNode get focusNode => _focusNode ?? _focusController.focusNode;
//
//   @override
//   void subscribeControl() {
//     _registerFocusController(FocusController());
//     super.subscribeControl();
//   }
//
//   @override
//   void unsubscribeControl() {
//     _unregisterFocusController();
//     super.unsubscribeControl();
//   }
//
//   void _registerFocusController(FocusController focusController) {
//     _focusController = focusController;
//     control.registerFocusController(focusController);
//   }
//
//   void _unregisterFocusController() {
//     control.unregisterFocusController(_focusController);
//     _focusController.dispose();
//   }
//
//   void _setFocusNode(FocusNode? focusNode) {
//     if (_focusNode != focusNode) {
//       _focusNode = focusNode;
//       _unregisterFocusController();
//       _registerFocusController(FocusController(focusNode: _focusNode));
//     }
//   }
// }
