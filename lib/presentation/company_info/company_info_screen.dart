import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/domain/model/company_info.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';
import 'package:stock_app/presentation/company_info/company_info_view_model.dart';
import 'package:stock_app/presentation/company_info/components/stock_chart.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyInfoViewModel>();
    final state = viewModel.state;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (state.errorMessage != null)
              Center(child: Text(state.errorMessage!)),
            if (state.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (state.isLoading == false && state.errorMessage == null)
              _buildBudy(context, state)
          ],
        ),
      ),
    );
  }

  Widget _buildBudy(BuildContext context, CompanyInfoState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.companyInfo!.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                overflow: TextOverflow.ellipsis),
          ),
          Text(
            state.companyInfo!.symbol,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const Divider(),
          Text(
            'Industry: ${state.companyInfo!.industry}',
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          Text(
            'Country: ${state.companyInfo!.country}',
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          const Divider(),
          Text(
            state.companyInfo!.description,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Market Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (state.stockInfos.isNotEmpty)
            StockChart(
              infos: state.stockInfos,
              graphColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onSurface,
            )
        ],
      ),
    );
  }
}
