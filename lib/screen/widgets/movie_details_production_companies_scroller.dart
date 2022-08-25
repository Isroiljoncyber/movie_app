import 'package:flutter/material.dart';

import '../../domain/model/movie_details_model.dart';
import '../../utils/constant.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  const ProductionCompaniesScroller(this.productionCompanies, {super.key});

  final List<ProductionCompanies> productionCompanies;

  Widget _buildCompanies(BuildContext context, int index) {
    var companies = productionCompanies[index];
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              companies.logoPath != null
                  ? "$imageBaseUrl${companies.logoPath}"
                  : imageBaseUrlDefault,
            ),
            radius: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              companies.name!,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Production Companies',
            style: textTheme.subtitle1?.copyWith(fontSize: 18),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
            itemCount: productionCompanies.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildCompanies,
          ),
        ),
      ],
    );
  }
}
