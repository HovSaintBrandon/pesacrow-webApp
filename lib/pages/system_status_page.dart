import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_text.dart';
import '../constants/status_management.dart';

class SystemStatusPage extends StatelessWidget {
  const SystemStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const GradientText('System Status & Incident Management', fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Markdown(
            data: statusManagementMarkdown,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, height: 1.5),
              h2: const TextStyle(color: AppColors.cyan, fontSize: 24, fontWeight: FontWeight.w600, height: 1.4),
              h3: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600, height: 1.3),
              p: const TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.6),
              listBullet: const TextStyle(color: AppColors.cyan, fontSize: 16),
              code: TextStyle(
                color: AppColors.orange,
                backgroundColor: Colors.white.withOpacity(0.05),
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              codeblockDecoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              blockquoteDecoration: BoxDecoration(
                border: Border(left: BorderSide(color: AppColors.cyan, width: 4)),
                color: AppColors.surface.withOpacity(0.5),
              ),
              tableBorder: TableBorder.all(color: Colors.white.withOpacity(0.1), width: 1),
              tableHead: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              tableBody: const TextStyle(color: AppColors.textSecondary),
              horizontalRuleDecoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
