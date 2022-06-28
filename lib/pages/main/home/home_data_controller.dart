import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class HomeDataController extends GetxController {
  List<ShowPreview> popularMovies = [];
  updatePopularMovies({required List<ShowPreview> popularMovies}) {
    this.popularMovies = popularMovies;
    update();
  }

  List<ShowPreview> popularShows = [];
  updatePopularShows({required List<ShowPreview> popularShows}) {
    this.popularShows = popularShows;
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
