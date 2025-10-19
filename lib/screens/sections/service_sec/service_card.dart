import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/service_sec/service_model.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel model;
  const ServiceCard({super.key, required this.model});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovering = false;
  bool get isBestValueCard => widget.model.id == 'best_value';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 320;
        final isCompact = constraints.maxWidth < 400;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            transform: _isHovering
                ? Matrix4.translationValues(0, -8, 0)
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: isBestValueCard ? AppColors.accentRed : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isBestValueCard
                      ? AppColors.accentRed.withOpacity(_isHovering ? 0.6 : 0.4)
                      : Colors.grey.withOpacity(_isHovering ? 0.3 : 0.15),
                  spreadRadius: _isHovering ? 5 : 2,
                  blurRadius: _isHovering ? 20 : 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isBestValueCard) _buildBestValueBanner(),
                if (!isBestValueCard) _buildImageArea(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isCompact ? 12.0 : 20.0,
                        vertical: isBestValueCard ? 10.0 : 16.0),
                    child: _buildCardContent(isNarrow),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent(bool isNarrow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBestValueCard)
          _buildBestValueTitle(isNarrow)
        else ...[
          Text(
            widget.model.title,
            style: TextStyle(
              fontSize: isNarrow ? 18 : 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.model.subtitle,
            style: TextStyle(
              fontSize: isNarrow ? 13 : 15,
              color: AppColors.secondaryText,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
        ],
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.model.data.map((f) => _buildFeatureItem(f)).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        isBestValueCard ? _buildBestValueCta() : _buildPriceAndCta(isNarrow),
      ],
    );
  }

  Widget _buildBestValueBanner() => Container(
        height: 80,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.accentRed,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("OUR BEST VALUE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(widget.model.price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900)),
                const Text(" / month",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      );

  Widget _buildBestValueTitle(bool isNarrow) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.model.title,
                      style: TextStyle(
                        fontSize: isNarrow ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              _buildPopularBadge(),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.model.subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 12),
        ],
      );

  Widget _buildPopularBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'POPULAR',
          style: TextStyle(
            color: AppColors.accentRed,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      );

  Widget _buildBestValueCta() => Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
            child: const Text('Book Now',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          const Text(
            "Billed Annually. Save an Extra 10%",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      );

  Widget _buildImageArea() => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            widget.model.imgPath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.car_repair,
                  size: 50, color: AppColors.secondaryText),
            ),
          ),
        ),
      );

  Widget _buildFeatureItem(String feature) {
    final featureColor = isBestValueCard ? Colors.white : AppColors.textDark;
    final iconColor = isBestValueCard ? Colors.white : AppColors.primaryGreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(feature,
                style: TextStyle(fontSize: 14, color: featureColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndCta(bool isNarrow) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Starting at",
                    style: TextStyle(
                        fontSize: 12, color: AppColors.secondaryText)),
                Text(widget.model.price,
                    style: TextStyle(
                      fontSize: isNarrow ? 18 : 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.accentRed,
                    )),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Book Now',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      );
}
