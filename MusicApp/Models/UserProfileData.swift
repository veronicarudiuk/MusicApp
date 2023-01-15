//
//  UserProfileData.swift
//  MusicApp
//
//  Created by Марс Мазитов on 13.01.2023.
//

import Foundation

struct UserProfileData: Decodable {
    let display_name: String
    let id: String
    let images: [Image]
    let email: String
    
}
extension UserProfileData {
    struct Image: Decodable {
        let url: String
    }
}


//
//    country = IN;
//    "display_name" = "Mars Full1";
//    email = "gronse7@gmail.com";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/31od3tvjwahnd6xmlheu2d4n6f34";
//    };
//    followers =     {
//        href = "<null>";
//        total = 0;
//    };
//    href = "https://api.spotify.com/v1/users/31od3tvjwahnd6xmlheu2d4n6f34";
//    id = 31od3tvjwahnd6xmlheu2d4n6f34;
//    images =     (
//                {
//            height = "<null>";
//            url = "https://i.scdn.co/image/ab6775700000ee851dbfcd2c3278ddf6bdfae6f1";
//            width = "<null>";
//        }
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:31od3tvjwahnd6xmlheu2d4n6f34";
//}
