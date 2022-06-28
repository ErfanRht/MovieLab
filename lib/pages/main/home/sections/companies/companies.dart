import 'package:flutter/material.dart';
import 'package:movielab/modules/navigate.dart';
import 'package:movielab/pages/main/home/sections/companies/box.dart';
import 'company_page.dart';

class HomePopularCompanies extends StatelessWidget {
  const HomePopularCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> companiesData = [
      {
        'id': 'co0051941',
        'name': 'Marvel Studios',
        'image':
            'https://brandlogos.net/wp-content/uploads/2021/12/marvel_studios-brandlogo.net_.png',
        'color': null
      },
      {
        'id': 'co0002663',
        'name': 'Warner Bros.',
        'image':
            'https://seeklogo.com/images/W/warner-bros-logo-1D6B588E26-seeklogo.com.png',
        'color': const Color(0xff0D5B08)
      },
      {
        'id': 'co0005073',
        'name': 'Universal Pictures',
        'image':
            'https://seeklogo.com/images/U/universal-pictures-logo-3D0B151D14-seeklogo.com.png',
        'color': const Color(0xff00aeef)
      },
      {
        'id': 'co0026545',
        'name': 'Sony Pictures',
        'image':
            'https://www.vumastore.co.ke/wp-content/uploads/2022/02/Daco_129005.png',
        'color': const Color(0xff00439C)
      },
    ];
    return SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: companiesData.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigate.pushTo(
                      context,
                      CompanyPage(
                        company: companiesData[index],
                      ));
                },
                borderRadius: BorderRadius.circular(27.5),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: CompanyBox(company: companiesData[index])));
          },
        ));
  }
}
