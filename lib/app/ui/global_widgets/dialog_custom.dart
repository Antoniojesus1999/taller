import 'package:flutter/material.dart';


enum DialogType { success, error, warning, info, question }

class DialogCustom extends StatelessWidget {
  final String title;
  final String? description;
  final DialogType type;
  final String okText;
  final String? cancelText;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;
  final bool barrierDismissible;
  final double borderRadius;

  const DialogCustom({
    super.key,
    required this.title,
    this.description,
    this.type = DialogType.info,
    this.okText = 'OK',
    this.cancelText,
    this.onOk,
    this.onCancel,
    this.barrierDismissible = true,
    this.borderRadius = 16.0,
  });

  Color _colorForType() {
    switch (type) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return Colors.red;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.question:
        return Colors.blue;
      case DialogType.info:
      default:
        return Colors.indigo;
    }
  }

  IconData _iconForType() {
    switch (type) {
      case DialogType.success:
        return Icons.check_circle;
      case DialogType.error:
        return Icons.error;
      case DialogType.warning:
        return Icons.warning_amber_rounded;
      case DialogType.question:
        return Icons.help;
      case DialogType.info:
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForType();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 12,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 280, maxWidth: 360),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color,
                      child: Icon(_iconForType(), color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(
                    description!,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cancelText != null)
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCancel?.call();
                        },
                        child: Text(cancelText!),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onOk?.call();
                      },
                      child: Text(okText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  String? description,
  DialogType type = DialogType.info,
  String okText = 'OK',
  String? cancelText,
  VoidCallback? onOk,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  double borderRadius = 16,
  Duration transitionDuration = const Duration(milliseconds: 350),
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'CustomDialog',
    barrierColor: Colors.black54,
    transitionDuration: transitionDuration,
    pageBuilder: (ctx, anim1, anim2) {
      return Center(
        child: DialogCustom(
          title: title,
          description: description,
          type: type,
          okText: okText,
          cancelText: cancelText,
          onOk: onOk,
          onCancel: onCancel,
          barrierDismissible: barrierDismissible,
          borderRadius: borderRadius,
        ),
      );
    },
    transitionBuilder: (ctx, anim, secondaryAnim, child) {
      final curved = Curves.easeOut.transform(anim.value);
      return Opacity(
        opacity: anim.value,
        child: Transform.scale(
          scale: 0.9 + 0.1 * curved,
          child: child,
        ),
      );
    },
  );
}
