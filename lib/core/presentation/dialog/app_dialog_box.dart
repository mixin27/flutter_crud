import 'package:flutter/material.dart';

class AppDialogBox extends StatelessWidget {
  const AppDialogBox({
    super.key,
    this.borderRadius = 14,
    this.header,
    required this.content,
    this.footer,
    this.contentPadding,
    this.showDefaultOkAction = true,
  });

  final double borderRadius;
  final Widget? header;
  final Widget content;
  final Widget? footer;
  final EdgeInsetsGeometry? contentPadding;
  final bool showDefaultOkAction;

  @override
  Widget build(BuildContext context) {
    const defaultPadding = EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    );

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          if (header != null)
            Container(
              padding: contentPadding ?? defaultPadding,
              child: header,
            ),
          if (header != null) const Divider(),

          // Body
          Container(
            padding: contentPadding ?? defaultPadding,
            child: content,
          ),

          if (footer != null || showDefaultOkAction) const Divider(),

          // Footer
          Container(
            padding: contentPadding ?? defaultPadding,
            child: footer ??
                (showDefaultOkAction
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'ok'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                        ],
                      )
                    : null),
          ),
        ],
      ),
    );
  }
}
