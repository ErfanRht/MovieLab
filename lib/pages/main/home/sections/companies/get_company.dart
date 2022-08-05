import 'package:flutter/foundation.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/modules/cache/cacheholder.dart';

Future<Map?> getCompanyInfo({required String id}) async {
  Map? company;
  final apiRequester = APIRequester();
  final cacheHolder = CacheHolder();

  await cacheHolder.getCompanyInfoFromCache(id: id).then((response) async {
    if (response != null) {
      if (kDebugMode) {
        print("GET COMPANY INFO FROM CACHE");
      }
      await Future.delayed(const Duration(seconds: 1));
      company = response;
    } else {
      try {
        await apiRequester.getCompany(id: id).then((response) {
          if (response != null) {
            if (kDebugMode) {
              print("GET COMPANY INFO FROM API");
            }
            if (kDebugMode) {
              print("SAVE COMPANY INFO IN CACHE");
            }
            cacheHolder.saveCompanyInfoInCache(company: response);
            company = response;
          } else {
            company = null;
          }
        });
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
        company = null;
      }
    }
  });
  return company;
}
