import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

/// A Maven Style Button.
///
/// Creates a clickable widget that displays text and icons gracefully.
/// Is more customizable then a [TextButton] and has redundant options scrapped.
///
/// Example:
/// ```dart
/// MFlatButton(
///   onPressed: () {},
///   child: Text(
///     'Start',
///     style: TextStyle(
///       fontSize: 16,
///       fontWeight: FontWeight.w700,
///     ),
///   ),
///   backgroundColor: Colors.blue,
/// ),
/// ```
///
/// The [tiled] option changes the button to resemble a [ListTile].
/// To be used in a [showBottomSheetDialog].
///
/// Example:
/// ```dart
/// MFlatButton.tiled(
///   onPressed: (){},
///   leading: Icon(
///     Icons.edit_rounded
///   ),
///   child: Text(
///     'Rename Folder',
///     style: TextStyle(
///       fontSize: 17,
///     ),
///   ),
/// ),
/// ```
class MButton extends StatelessWidget {
  /// Creates a Maven styled button.
  ///
  /// **Note:** Has a default [width] of [double.infinity] and [expand] of [true].
  const MButton({super.key,
    required this.onPressed,
    this.leading,
    this.child,
    this.height = 42,
    this.width = double.infinity,
    this.borderRadius = 8,
    this.backgroundColor,
    this.borderColor,
    this.splashColor,
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.expand = true,
  }) :  leadingPadding = const EdgeInsets.only(),
        trailingPadding = const EdgeInsets.only(),
        trailing = null,
        title = null;

  /// Creates a button similar to [ListTile].
  /// 
  /// To be used with [showBottomSheetDialog].
  const MButton.tiled({super.key,
    required this.onPressed,
    required this.leading,
    required this.title,
    this.trailing,
    this.height = 62,
    this.width = double.infinity,
    this.borderRadius = 0,
    this.backgroundColor,
    this.borderColor,
    this.splashColor,
    this.leadingPadding = const EdgeInsets.only(left: 30, right: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 0),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.expand = false,
  }) :  trailingPadding = const EdgeInsets.only(right: 30),
        child = null;

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// A widget to display before the [child].
  final Widget? leading;

  /// The primary content.
  ///
  /// Typically a [Text] widget.
  final Widget? child;

  /// A widget to display after the [child].
  final Widget? trailing;

  /// The height of the button.
  final double height;

  /// The width of the button.
  final double width;

  /// The corners of this box are rounded by this [double].
  final double borderRadius;

  /// The [Color] painted behind the [leading] and [child] widget.
  final Color? backgroundColor;

  /// The [Color] painted on the sides of the button.
  final Color? borderColor;

  /// The [Color] of the ripple when user presses the button.
  final Color? splashColor;

  /// The [padding] inside of the button.
  final EdgeInsets padding;

  final EdgeInsets leadingPadding;

  final EdgeInsets trailingPadding;

  /// Where all the widgets should be aligned in the row
  final MainAxisAlignment mainAxisAlignment;

  /// Whether to use the expanded widget or not
  final bool expand;

  final String? title;

  @override
  Widget build(BuildContext context) {
    if(width != double.infinity) {
      return widgetBuildButton(context);
    } else if(expand) {
      return Expanded(
          child: widgetBuildButton(context)
      );
    } else {
      return widgetBuildButton(context);
    }
  }

  Widget widgetBuildButton(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? backgroundColor ?? mt(context).backgroundColor
        ),
        color: borderColor
      ),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? mt(context).backgroundColor,
        child: InkWell(
          onTap: onPressed,
          splashFactory: InkRipple.splashFactory,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,

              children: [
                if(leading != null) Padding(
                  padding: leadingPadding,
                  child: leading!
                ),
                if(leading != null && child != null) const SizedBox(width: 2,),
                title != null ? Text(title!, style: TextStyle(fontSize: 18, color: mt(context).text.primaryColor),) : child!,
                trailing != null ? Expanded(
                  child: Container(
                    padding: trailingPadding,
                    alignment: Alignment.centerRight,
                    child: trailing,
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
