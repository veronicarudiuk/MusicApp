//
//  Constants.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

struct K {
    struct BrandColors {
        static let darkBG = "DarkBG" //#151521
        static let grayBG = "GrayBG" //#D9D9D9, opacity 29%
        static let tabBarBG = "TabBarBG" //#24242E
        
        static let blueColor = "Blue" //#24D2EA
        static let cyanColor = "Cyan" //#08979C
        
        static let veryLightGray = "VeryLightGray" //#D1D5DB
        static let lightGray = "LightGray" //#78909C
        static let darkGray = "DarkGray" //#455A64
        
        static let greenGradientColor = "GreenGradientColor" //#24EBCA
        static let purpleGradientColor = "PurpleGradientColor" //#1B0447
    }
    
    struct Fonts {
        static let poppinsSemiBold = "Poppins SemiBold"
        static let poppinsRegular = "Poppins Regular"
        
        static let robotoRegular = "Roboto Regular"
        
        static let interExtraBold = "Inter ExtraBold"
        static let interMedium = "Inter Medium"
        static let interRegular = "Inter Regular"
        static let interSemiBold = "Inter SemiBold"
    }
    
    struct Auth {
        static let clientId = "67c1af1dd0304240a6bf5fbd8b2e4007"
        static let clientSecret = "1a0a674b59434317b2066e4565169c07"
        static let tokenApiURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.google.ru/"
    }
}
