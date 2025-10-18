import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../config/app_colors.dart';
import 'package:provider/provider.dart';
import '../screens/scroll_provider.dart';

class ResponsiveNavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Map<String, dynamic>> navItems;

  const ResponsiveNavBar({super.key, required this.navItems});

  @override
  Widget build(BuildContext context) {
    final scrollPvd = Provider.of<ScrollProvider>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.95),
      title: const Text(
        'Speedy Clean',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
      ),
      elevation: 4,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.textDark),
      actions: [
        ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isDesktop || sizingInformation.isTablet) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: navItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () => scrollPvd.scrollTo(item['key']),
                      child: Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
