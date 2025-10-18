import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:s_car/screens/scroll_provider.dart'; // Ensure this path is correct
import '../config/app_colors.dart';

class ResponsiveNavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Map<String, dynamic>> navItems;

  const ResponsiveNavBar({super.key, required this.navItems});

  @override
  Widget build(BuildContext context) {
    final scrollPvd = Provider.of<ScrollProvider>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          minRadius: 16,
          maxRadius: 30,
          backgroundImage: AssetImage("assets/images/car_care.png"),
          backgroundColor: Colors.transparent,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'CARCARE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.textDark),
      // IMPORTANT: AutomaticallyImplyLeading must be false if you use a custom leading widget
      automaticallyImplyLeading: false,

      actions: [
        ResponsiveBuilder(
          builder: (context, sizingInformation) {
            final isMobile = sizingInformation.isMobile;

            if (isMobile) {
              // 1. Mobile: Explicitly add the EndDrawer icon
              return Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textDark),
                  onPressed: () => Scaffold.of(context)
                      .openEndDrawer(), // Open the endDrawer
                ),
              );
            } else {
              // 2. Desktop/Tablet: Show Navigation Links
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: navItems.map((item) {
                  return NavLinkItem(
                    title: item['title'] as String,
                    onTap: () => scrollPvd.scrollTo(item['key']),
                  );
                }).toList(),
              );
            }
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

// NavLinkItem code remains the same...
// ... (Your NavLinkItem code here)
// --- Dedicated Desktop Navigation Link with Hover Effect ---
class NavLinkItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const NavLinkItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<NavLinkItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: InkWell(
          onTap: widget.onTap,
          hoverColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _isHovering
                      ? AppColors.primaryBlue
                      : Colors.transparent, // Highlight on hover
                  width: 3,
                ),
              ),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                color: _isHovering ? AppColors.primaryBlue : AppColors.textDark,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
