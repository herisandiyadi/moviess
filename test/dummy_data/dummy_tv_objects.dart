import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/spoken_language.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_episode_toair.dart';
import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:ditonton/domain/entities/tv_network.dart';
import 'package:ditonton/domain/entities/tv_production_country.dart';
import 'package:ditonton/domain/entities/tv_season.dart';

final tTvDetail = TvDetail(
  adult: false,
  backdropPath: "/7M0huD4pLqe15c3VSxBMCqzFMSW.jpg",
  createdBy: <dynamic>[
    {
      "id": 19303,
      "credit_id": "52532e3219c29579400013ab",
      "name": "Kevin Smith",
      "gender": 2,
      "profile_path": "/uxDQ0NTZMnOuAaPa0tQzMFV9dx4.jpg"
    },
    {
      "id": 20503,
      "credit_id": "52532e3219c29579400013a5",
      "name": "Scott Mosier",
      "gender": 2,
      "profile_path": "/oEQcuNy9uYGMNq3e49VSJ7oPsJw.jpg"
    },
    {
      "id": 57407,
      "credit_id": "52532e3219c295794000136f",
      "name": "David Mandel",
      "gender": 2,
      "profile_path": "/beom0HmSu1sP5YWo6JHETDFtTj0.jpg"
    }
  ],
  episodeRunTime: [22],
  firstAirDate: DateTime.tryParse("2000-05-31"),
  genres: [TVGenre(id: 16, name: "Animation")],
  homepage: '',
  id: 2,
  inProduction: false,
  languages: ["en"],
  lastAirDate: DateTime.tryParse("2002-12-22"),
  lastEpisodeToAir: TvEpisodetoAir(
    id: 1130478,
    name: "The Last Episode Ever!",
    overview:
        "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
    voteAverage: 6.8,
    voteCount: 4,
    airDate: DateTime.tryParse("2002-12-22"),
    episodeNumber: 6,
    episodeType: "finale",
    productionCode: "",
    runtime: 22,
    seasonNumber: 1,
    showId: 2,
    stillPath: "/xhbjqZWbMaHKGdvm9M46JN0crRV.jpg",
  ),
  name: "Clerks",
  nextEpisodeToAir: null,
  networks: [
    TvNetwork(
      id: 2,
      logoPath: "/2uy2ZWcplrSObIyt4x0Y9rkG6qO.png",
      name: "ABC",
      originCountry: "US",
    ),
    TvNetwork(
      id: 47,
      logoPath: "/6ooPjtXufjsoskdJqj6pxuvHEno.png",
      name: "Comedy Central",
      originCountry: "US",
    ),
  ],
  numberOfEpisodes: 6,
  numberOfSeasons: 1,
  originCountry: ["US"],
  originalLanguage: "United States of America",
  originalName: "Clerks",
  overview:
      "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
  popularity: 16.885,
  posterPath: "/xunXvzFlkf1GGgMkCySA9CCFumB.jpg",
  productionCompanies: null,
  productionCountries: [
    TvProductionCountry(iso31661: "US", name: "United States of America")
  ],
  seasons: [
    TVSeason(
      airDate: null,
      episodeCount: 7,
      id: 2328128,
      name: "Specials",
      overview: "",
      posterPath: null,
      seasonNumber: 0,
      voteAverage: 0,
    ),
    TVSeason(
      airDate: DateTime.tryParse("2000-05-31"),
      episodeCount: 6,
      id: 2328127,
      name: "Season 1",
      overview: "",
      posterPath: "/qhKzJcAz9AhxZstTAsLu2lulbVY.jpg",
      seasonNumber: 1,
      voteAverage: 7.1,
    ),
  ],
  spokenLanguages: [
    TvSpokenLanguage(
      englishName: "English",
      iso6391: "en",
      name: "English",
    ),
  ],
  status: "Canceled",
  tagline: "",
  type: "Scripted",
  voteAverage: 7.012,
  voteCount: 86,
);

final tTvShow = Tv(
  backdropPath: "/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg",
  firstAirDate: "2008-01-20",
  genreIds: [18, 80],
  id: 1396,
  name: "Breaking Bad",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Breaking Bad",
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  popularity: 482.784,
  posterPath: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
  voteAverage: 151,
  voteCount: 3011,
);

final testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [TVGenre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTV = Tv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'title',
);

final testTvList = [tTvShow];

final testTvFromCache = Tv.watchlist(
  id: 1396,
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  posterPath: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
  name: "Breaking Bad",
);
