//
//  NewReleasesData.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 21/01/2023.
//

import Foundation

struct NewReleasesData: Decodable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Decodable {
    let items: [Album]
}

struct Album: Decodable {
    let id: String
}

//struct Images: Decodable {
//    let url: String
//}

//{
//    albums =     {
//        href = "https://api.spotify.com/v1/browse/new-releases?country=GE&locale=ru&offset=0&limit=1";
//        items =         (
//            {
//                "album_type" = album;
//                artists =                 (
//                    {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/6KImCVD70vtIoJWnq6nGn3";
//                        };
//                        href = "https://api.spotify.com/v1/artists/6KImCVD70vtIoJWnq6nGn3";
//                        id = 6KImCVD70vtIoJWnq6nGn3;
//                        name = "Harry Styles";
//                        type = artist;
//                        uri = "spotify:artist:6KImCVD70vtIoJWnq6nGn3";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/5r36AJ6VOJtp00oxSkBZ5h";
//                };
//                href = "https://api.spotify.com/v1/albums/5r36AJ6VOJtp00oxSkBZ5h";
//                id = 5r36AJ6VOJtp00oxSkBZ5h;
//                images =                 (
//                    {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2732e8ed79e177ff6011076f5f0";
//                        width = 640;
//                    },
//                    {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e022e8ed79e177ff6011076f5f0";
//                        width = 300;
//                    },
//                    {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048512e8ed79e177ff6011076f5f0";
//                        width = 64;
//                    }
//                );
//                name = "Harry's House";
//                "release_date" = "2022-05-20";
//                "release_date_precision" = day;
//                "total_tracks" = 13;
//                type = album;
//                uri = "spotify:album:5r36AJ6VOJtp00oxSkBZ5h";
//            }
//        );
//        limit = 1;
//        next = "https://api.spotify.com/v1/browse/new-releases?country=GE&locale=ru&offset=1&limit=1";
//        offset = 0;
//        previous = "<null>";
//        total = 57;
//    };
//}
