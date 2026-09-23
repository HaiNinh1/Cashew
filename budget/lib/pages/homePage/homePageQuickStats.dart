// [Nhóm 10 - TV4] Widget thống kê nhanh trên trang chủ:
// tổng chi tiêu hôm nay và tổng chi tiêu tháng này (tất cả tài khoản).
// Bấm vào ô để xem danh sách giao dịch tương ứng.
import 'package:budget/colors.dart';
import 'package:budget/database/tables.dart';
import 'package:budget/pages/transactionFilters.dart';
import 'package:budget/pages/transactionsSearchPage.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:budget/widgets/transactionsAmountBox.dart';
import 'package:budget/widgets/util/keepAliveClientMixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageQuickStats extends StatelessWidget {
  const HomePageQuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTimeRange todayRange = DateTimeRange(start: today, end: today);
    DateTimeRange thisMonthRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0),
    );
    return KeepAliveClientMixin(
      child: Padding(
        padding:
            const EdgeInsetsDirectional.only(bottom: 13, start: 13, end: 13),
        child: Row(
          children: [
            Expanded(
              child: _ExpenseInRangeBox(
                label: "spent-today".tr(),
                dateTimeRange: todayRange,
              ),
            ),
            SizedBox(width: 13),
            Expanded(
              child: _ExpenseInRangeBox(
                label: "spent-this-month".tr(),
                dateTimeRange: thisMonthRange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseInRangeBox extends StatelessWidget {
  const _ExpenseInRangeBox({
    required this.label,
    required this.dateTimeRange,
  });
  final String label;
  final DateTimeRange dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return TransactionsAmountBox(
      label: label,
      totalWithCountStream: database.watchTotalWithCountOfWallet(
        isIncome: false,
        allWallets: Provider.of<AllWallets>(context),
        onlyIncomeAndExpense: true,
        searchFilters: SearchFilters(dateTimeRange: dateTimeRange),
      ),
      textColor: getColor(context, "expenseAmount"),
      openPage: TransactionsSearchPage(
        initialFilters: SearchFilters().copyWith(
          dateTimeRange: dateTimeRange,
          expenseIncome: [ExpenseIncome.expense],
        ),
      ),
    );
  }
}
