import Foundation

struct MovieModel: Movie {
    let Id: Int
    let Rank: Int
    let Name: String
    let Duration: String
    let Description: String
    let Director: String
    let Genres: [String]
    let Actors: [String]
}

struct MovieDetailModel: MovieDetail {
    var Id: Int
    var Name: String
    var Duration: String
    var Description: String
    var Director: String
    var Genres: [String]
    var Actors: [String]
}

struct MovieRankModel: MovieRank {
    var Id: Int
    var Rank: Int
    var Name: String
}
