import 'package:flutter/foundation.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'cacheholder.dart';

Future<dynamic> getItemInfo(
    {required final String id, required final ItemType itemType}) async {
  dynamic? item;
  final apiRequester = APIRequester();
  final cacheHolder = CacheHolder();

  await cacheHolder.getShowInfoFromCache(id: id).then((response) async {
    if (response != null) {
      if (kDebugMode) {
        print(
            "GET ${itemType.toString().toUpperCase().replaceAll("ITEMTYPE.", "")} INFO FROM CACHE");
      }
      item = response;
    } else {
      try {
        if (itemType == ItemType.SHOW) {
          await apiRequester.getShow(id: id).then((response) {
            if (response != null) {
              if (kDebugMode) {
                print(
                    "GET ${itemType.toString().toUpperCase().replaceAll("ITEMTYPE.", "")} INFO FROM API");
              }
              if (kDebugMode) {
                print(
                    "SAVE ${itemType.toString().toUpperCase().replaceAll("ITEMTYPE.", "")} INFO IN CACHE");
              }
              cacheHolder.saveShowInfoInCache(show: response);
              item = response;
            } else {
              item = null;
            }
          });
        } else if (itemType == ItemType.ARTIST) {
          await apiRequester.getActor(id: id).then((response) {
            if (response != null) {
              if (kDebugMode) {
                print(
                    "GET ${itemType.toString().toUpperCase().replaceAll("ITEMTYPE.", "")} INFO FROM API");
              }
              if (kDebugMode) {
                print(
                    "SAVE ${itemType.toString().toUpperCase().replaceAll("ITEMTYPE.", "")} INFO IN CACHE");
              }
              cacheHolder.saveActorInfoInCache(actor: response);
              item = response;
            } else {
              item = null;
            }
          });
        } else {
          item = null;
        }
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
        item = null;
      }
    }
  });
  return item;
}
