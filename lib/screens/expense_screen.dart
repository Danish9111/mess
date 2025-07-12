import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

import 'package:mess/extentions.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExpensesScreen(),
      ),
    ),
  );
}

// Expense data model
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

// Summary data model
class ExpenseSummary {
  final double totalShare;
  final double amountPaid;
  final double netBalance;

  ExpenseSummary({
    required this.totalShare,
    required this.amountPaid,
    required this.netBalance,
  });
}

// Mock Provider for expense data
final expenseSummaryProvider = FutureProvider<ExpenseSummary>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return ExpenseSummary(
    totalShare: 8500,
    amountPaid: 9200,
    netBalance: 700,
  );
});

// Mock Provider for payment history
final paymentHistoryProvider = FutureProvider<List<Expense>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    Expense(
      id: '1',
      title: 'Breakfast',
      amount: 4000,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Monthly Payment', // changed from 'Paid monthly'
    ),
    Expense(
      id: '2',
      title: 'Lunch',
      amount: 1200,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Monthly Payment', // changed from 'Paid monthly'
    ),
    Expense(
      id: '3',
      title: 'Dinner',
      amount: 4000,
      date: DateTime.now().subtract(const Duration(days: 8)),
      category: 'Monthly Payment', // changed from 'Paid monthly'
    ),
    Expense(
      id: '4',
      title: 'Extras(snacks,drinks etc)',
      amount: 650,
      date: DateTime.now().subtract(const Duration(days: 12)),
      category: 'Extras', // changed from 'Paid monthly'
    ),
  ];
});

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(expenseSummaryProvider);
    final paymentsAsync = ref.watch(paymentHistoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Monthly Expenses',
            style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(expenseSummaryProvider.future),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'June 2023 Expenses',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your mess expense details for this month',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7E8CA0),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Summary Card
            SliverToBoxAdapter(
              child: summaryAsync.when(
                data: (summary) => _buildSummaryCard(summary),
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Error loading summary'),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 20, right: 20, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E3A59),
                      ),
                    ),
                    Text(
                      '${paymentsAsync.value?.length ?? 0} items',
                      style: const TextStyle(
                        color: Color(0xFF7E8CA0),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Payment History List
            paymentsAsync.when(
              data: (payments) => _buildPaymentList(payments),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Error loading payments'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(ExpenseSummary summary) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlueAccent, Color(0xFFB3E5FC)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.applyOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildSummaryRow(
              'Total Expense',
              'Rs.${summary.totalShare.toStringAsFixed(2)}',
              icon: Iconsax.profile_2user,
            ),
            const SizedBox(height: 20),
            _buildSummaryRow(
              'Amount Paid',
              'Rs.${summary.amountPaid.toStringAsFixed(2)}',
              icon: Iconsax.wallet,
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: Colors.white.applyOpacity(0.3),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.arrow_swap,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Net Balance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.applyOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                Text(
                  summary.netBalance >= 0
                      ? 'Rs.${summary.netBalance.abs().toStringAsFixed(2)}'
                      : 'Rs.${summary.netBalance.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: summary.netBalance >= 0
                        ? Colors.green
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  summary.netBalance >= 0 ? 'You are owed' : 'You owe',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.applyOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {IconData? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.applyOpacity(0.9),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentList(List<Expense> payments) {
    if (payments.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.receipt, size: 64, color: Colors.grey.shade300),
              const SizedBox(height: 16),
              const Text(
                'No payments recorded',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final payment = payments[index];
          return _buildPaymentItem(payment);
        },
        childCount: payments.length,
      ),
    );
  }

  Widget _buildPaymentItem(Expense payment) {
    final categoryColors = {
      'Breakfast': const Color(0xFFFF9F43),
      'Lunch': const Color(0xFF2ECC71),
      'Dinner': const Color(0xFF9B59B6),
      'Extras': const Color(0xFF3498DB),
      'Maintenance': const Color(0xFF1ABC9C),
      'Monthly Payment': Colors.lightBlueAccent, // fallback for unknown titles
    };

    final iconForCategory = {
      'Breakfast': Iconsax.cake,
      'Lunch': Iconsax.shopping_bag,
      'Dinner': Iconsax.music,
      'Extras': Iconsax.flash,
      'Maintenance': Icons.pan_tool_sharp,
      'Monthly Payment': Iconsax.wallet, // fallback for unknown titles
    };

    // If category is 'Monthly Payment', use the title to pick color/icon
    String key = payment.category;
    if (payment.category == 'Monthly Payment' &&
        categoryColors.containsKey(payment.title)) {
      key = payment.title;
    }

    final color = categoryColors[key] ?? Colors.grey;
    final icon = iconForCategory[key] ?? Icons.help_outline;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          payment.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, yyyy').format(payment.date),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF7E8CA0),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                payment.category,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${payment.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF2E3A59),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              payment.date
                      .isAfter(DateTime.now().subtract(const Duration(days: 3)))
                  ? 'Recent'
                  : '',
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
