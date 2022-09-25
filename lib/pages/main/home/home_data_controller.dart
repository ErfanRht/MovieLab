import 'package:get/get.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';

class HomeDataController extends GetxController {
  List<ShowPreview> trendingMovies = [];
  updateTrendingMovies({required List<ShowPreview> trendingMovies}) {
    this.trendingMovies = trendingMovies;
    update();
  }

  List<ShowPreview> trendingShows = [];
  updateTrendingShows({required List<ShowPreview> trendingShows}) {
    this.trendingShows = trendingShows;
    update();
  }

  List<ShowPreview> inTheaters = [];
  updateInTheaters({required List<ShowPreview> inTheaters}) {
    this.inTheaters = inTheaters;
    update();
  }

  List<ShowPreview> topRatedMovies = [];
  updateTopRatedMovies({required List<ShowPreview> topRatedMovies}) {
    this.topRatedMovies = topRatedMovies;
    update();
  }

  List<ShowPreview> topRatedShows = [];
  updateTopRatedShows({required List<ShowPreview> topRatedShows}) {
    this.topRatedShows = topRatedShows;
    update();
  }

  List<ShowPreview> recommendations = [];
  updateRecommendations({required List<ShowPreview> recommendations}) {
    this.recommendations = recommendations;
    update();
  }

  List<Map<String, List<ShowPreview>>> companiesinfo = [];
  updateCompaniesInfo(
      {required List<Map<String, List<ShowPreview>>> companiesinfo}) {
    this.companiesinfo = companiesinfo;
    update();
  }

  addCompanyInfo({required Map<String, List<ShowPreview>> companyinfo}) {
    companiesinfo.add(companyinfo);
    update();
  }

  List<ShowPreview> boxOffice = [];
  updateBoxOffice({required List<ShowPreview> boxOffice}) {
    this.boxOffice = boxOffice;
    update();
  }

  List<ShowPreview> allTimeBoxOffice = [];
  updateAllTimeBoxOffice({required List<ShowPreview> allTimeBoxOffice}) {
    this.allTimeBoxOffice = allTimeBoxOffice;
    update();
  }
}
