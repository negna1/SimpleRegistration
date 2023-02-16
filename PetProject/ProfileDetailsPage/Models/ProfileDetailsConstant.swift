//  
//  ProfileDetailsConstantswift.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Combine

extension ProfileDetailsController {
    struct Constant {
        static let title: String = "Profile Details"
        static let error: String = "Error"
    }
}

extension ProfileDetailsViewModel {
    struct Constant {
        static let firstSectionTitle = "Picture description"
        static let secondSectionTitle = "General description"
        static let notHaveInfo: String = "We don't have an info"
        
        static let authorInfo: String = "Author of Picture"
        static let viewCount: String = "View Count"
        static let likeCount: String = "Like Count"
        static let commentCount: String = "Comment Count"
        static let favouriteCount: String = "Favourite Count"
        static let downloadCount: String = "Download Count"
        
        static let authorInfoIcon: String = "person"
        static let viewCountIcon: String = "viewfinder.circle"
        static let likeCountIcon: String = "hand.thumbsup"
        static let commentCountIcon: String = "message"
        static let favouriteCountIcon: String = "star"
        static let downloadCountIcon: String = "square.and.arrow.down"
    }
}

