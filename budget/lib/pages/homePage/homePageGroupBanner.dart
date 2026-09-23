// [Nhóm 10 - TV2] Banner chào mừng tiếng Việt trên trang chủ.
// Hiển thị lời chào và một mẹo tiết kiệm thay đổi theo ngày.
// Có thể ẩn bằng nút X, bật lại trong "Chỉnh sửa trang chủ".
import 'package:budget/struct/languageMap.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/navigationFramework.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const int groupBannerTipCount = 5;

class HomePageGroupBanner extends StatelessWidget {
  const HomePageGroupBanner({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    int tipIndex = DateTime.now().day % groupBannerTipCount + 1;
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 13, start: 13, end: 13),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [colorScheme.primary, colorScheme.tertiary],
          ),
        ),
        padding: const EdgeInsetsDirectional.only(
            start: 18, top: 14, bottom: 16, end: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 4, end: 14),
              child: Icon(
                Icons.savings_rounded,
                size: 36,
                color: colorScheme.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFont(
                    text: "group-banner-title"
                        .tr(namedArgs: {"app": globalAppName}),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    textColor: colorScheme.onPrimary,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  TextFont(
                    text: ("group-banner-tip-" + tipIndex.toString()).tr(),
                    fontSize: 14,
                    textColor: colorScheme.onPrimary.withOpacity(0.9),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            Tooltip(
              message: "close".tr(),
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.close_rounded, color: colorScheme.onPrimary),
                onPressed: () {
                  // Ẩn ở cả giao diện điện thoại và màn hình rộng
                  updateSettings("showGroupBanner", false,
                      updateGlobalState: false);
                  updateSettings("showGroupBannerFullScreen", false,
                      updateGlobalState: false);
                  homePageStateKey.currentState?.refreshState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
