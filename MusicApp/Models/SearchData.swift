//
//  SearchData.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import Foundation

struct SearchData: Decodable {
    let tracks: TrackSearchData//
}

struct TrackSearchData: Decodable {
    let items: [Track]//
}

struct Album: Decodable {
    let album_type: String
    let id: String
    let images: [ImageData]
    let name: String
    let artists: [ArtistData]
}

struct ImageData: Decodable {
    let height: Int
    let url: String
    let width: Int
}

struct ArtistData: Decodable {
    let external_urls: [String: String]
    let id: String
    let name: String
    let type: String
}

//{
//    tracks =     {
//        href = "https://api.spotify.com/v1/search?query=D&type=track&locale=ru&offset=0&limit=2";
//        items =         (
//            {
//                album =                 {
//                    "album_type" = single;
//                    artists =                     (
//                        {
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/artist/1sSYaQBOI71QZDZ9OWW3hp";
//                            };
//                            href = "https://api.spotify.com/v1/artists/1sSYaQBOI71QZDZ9OWW3hp";
//                            id = 1sSYaQBOI71QZDZ9OWW3hp;
//                            name = "Chani Nattan";
//                            type = artist;
//                            uri = "spotify:artist:1sSYaQBOI71QZDZ9OWW3hp";
//                        }
//                    );
//                    "available_markets" =                     (
//                        AD,
//                        
//                        ZW
//                    );
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/album/3RaIXDlIRvziryGLXm8lBR";
//                    };
//                    href = "https://api.spotify.com/v1/albums/3RaIXDlIRvziryGLXm8lBR";
//                    id = 3RaIXDlIRvziryGLXm8lBR;
//                    images =                     (
//                        {
//                            height = 640;
//                            url = "https://i.scdn.co/image/ab67616d0000b2736e5bd2a10414d383b4f9c0ca";
//                            width = 640;
//                        },
//                        {
//                            height = 300;
//                            url = "https://i.scdn.co/image/ab67616d00001e026e5bd2a10414d383b4f9c0ca";
//                            width = 300;
//                        },
//                        {
//                            height = 64;
//                            url = "https://i.scdn.co/image/ab67616d000048516e5bd2a10414d383b4f9c0ca";
//                            width = 64;
//                        }
//                    );
//                    name = Daku;
//                    "release_date" = "2021-01-16";
//                    "release_date_precision" = day;
//                    "total_tracks" = 1;
//                    type = album;
//                    uri = "spotify:album:3RaIXDlIRvziryGLXm8lBR";
//                };
//                artists =                 (
//                    {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/1sSYaQBOI71QZDZ9OWW3hp";
//                        };
//                        href = "https://api.spotify.com/v1/artists/1sSYaQBOI71QZDZ9OWW3hp";
//                        id = 1sSYaQBOI71QZDZ9OWW3hp;
//                        name = "Chani Nattan";
//                        type = artist;
//                        uri = "spotify:artist:1sSYaQBOI71QZDZ9OWW3hp";
//                    },
//                    {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/4Lk9Mory8nRTolPO1TMMcN";
//                        };
//                        href = "https://api.spotify.com/v1/artists/4Lk9Mory8nRTolPO1TMMcN";
//                        id = 4Lk9Mory8nRTolPO1TMMcN;
//                        name = "Inderpal Moga";
//                        type = artist;
//                        uri = "spotify:artist:4Lk9Mory8nRTolPO1TMMcN";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 131077;
//                explicit = 0;
//                "external_ids" =                 {
//                    isrc = QZFYX2181314;
//                };
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/3wz2vWhYnnBoFmgMkqtzLy";
//                };
//                href = "https://api.spotify.com/v1/tracks/3wz2vWhYnnBoFmgMkqtzLy";
//                id = 3wz2vWhYnnBoFmgMkqtzLy;
//                "is_local" = 0;
//                name = Daku;
//                popularity = 84;
//                "preview_url" = "https://p.scdn.co/mp3-preview/37da64695c508e05c14ecdc0c1d49f1891f2ae82?cid=67c1af1dd0304240a6bf5fbd8b2e4007";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:3wz2vWhYnnBoFmgMkqtzLy";
//            },
//            {
//                album =                 {
//                    "album_type" = album;
//                    artists =                     (
//                        {
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/artist/5NHm4TU5Twz7owibYxJfFU";
//                            };
//                            href = "https://api.spotify.com/v1/artists/5NHm4TU5Twz7owibYxJfFU";
//                            id = 5NHm4TU5Twz7owibYxJfFU;
//                            name = King;
//                            type = artist;
//                            uri = "spotify:artist:5NHm4TU5Twz7owibYxJfFU";
//                        }
//                    );
//                    "available_markets" =                     (
//                        AD,
//                        AE,
//                        
//                        ZW
//                    );
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/album/7uftfPn8f7lwtRLUrEVRYM";
//                    };
//                    href = "https://api.spotify.com/v1/albums/7uftfPn8f7lwtRLUrEVRYM";
//                    id = 7uftfPn8f7lwtRLUrEVRYM;
//                    images =                     (
//                        {
//                            height = 640;
//                            url = "https://i.scdn.co/image/ab67616d0000b273e0fc847e272a9bf7a04643da";
//                            width = 640;
//                        },
//                        {
//                            height = 300;
//                            url = "https://i.scdn.co/image/ab67616d00001e02e0fc847e272a9bf7a04643da";
//                            width = 300;
//                        },
//                        {
//                            height = 64;
//                            url = "https://i.scdn.co/image/ab67616d00004851e0fc847e272a9bf7a04643da";
//                            width = 64;
//                        }
//                    );
//                    name = "The Carnival";
//                    "release_date" = "2020-09-21";
//                    "release_date_precision" = day;
//                    "total_tracks" = 8;
//                    type = album;
//                    uri = "spotify:album:7uftfPn8f7lwtRLUrEVRYM";
//                };
//                artists =                 (
//                    {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/5NHm4TU5Twz7owibYxJfFU";
//                        };
//                        href = "https://api.spotify.com/v1/artists/5NHm4TU5Twz7owibYxJfFU";
//                        id = 5NHm4TU5Twz7owibYxJfFU;
//                        name = King;
//                        type = artist;
//                        uri = "spotify:artist:5NHm4TU5Twz7owibYxJfFU";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 270000;
//                explicit = 0;
//                "external_ids" =                 {
//                    isrc = FRX762050882;
//                };
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/0yCWDaAgOtg6TKlNCg9rwA";
//                };
//                href = "https://api.spotify.com/v1/tracks/0yCWDaAgOtg6TKlNCg9rwA";
//                id = 0yCWDaAgOtg6TKlNCg9rwA;
//                "is_local" = 0;
//                name = "Tu Aake Dekhle";
//                popularity = 86;
//                "preview_url" = "https://p.scdn.co/mp3-preview/f8de7d415bf18af1031a08d01cce95c8dfc2aaea?cid=67c1af1dd0304240a6bf5fbd8b2e4007";
//                "track_number" = 8;
//                type = track;
//                uri = "spotify:track:0yCWDaAgOtg6TKlNCg9rwA";
//            }
//        );
//        limit = 2;
//        next = "https://api.spotify.com/v1/search?query=D&type=track&locale=ru&offset=2&limit=2";
//        offset = 0;
//        previous = "<null>";
//        total = 10063;
//    };
//}
