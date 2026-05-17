// lib/widgets/cart_badge_icon.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartBadgeIcon extends StatelessWidget {
  final Color? iconColor;
  final Color? badgeColor;
  final VoidCallback? onTap;

  const CartBadgeIcon({
    super.key,
    this.iconColor,
    this.badgeColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return GestureDetector(
          onTap: onTap ?? () => Navigator.pushNamed(context, '/cart'),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: iconColor ?? const Color(0xFF1A1A1A),
                size: 24,
              ),
              if (cart.totalItems > 0)
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor ?? const Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.totalItems > 99 ? '99+' : '${cart.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
