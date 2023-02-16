//
//  ProfileDetailsInfoType.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Foundation
import UIKit

extension ProfileDetailsViewModel {
    enum InfoType: CaseIterable {
        case authorInfo
        case commentCount
        case downloadCount
        case likeCount
        case viewCount
        case favouriteCount
    }
}

extension ProfileDetailsViewModel.InfoType {
    var iconName: String {
        switch self {
        case .authorInfo:
            return ProfileDetailsViewModel.Constant.authorInfoIcon
        case .commentCount:
            return ProfileDetailsViewModel.Constant.commentCountIcon
        case .downloadCount:
            return ProfileDetailsViewModel.Constant.downloadCountIcon
        case .likeCount:
            return ProfileDetailsViewModel.Constant.likeCountIcon
        case .viewCount:
            return ProfileDetailsViewModel.Constant.viewCountIcon
        case .favouriteCount:
            return ProfileDetailsViewModel.Constant.favouriteCountIcon
        }
    }
    
    var title: String {
        switch self {
        case .authorInfo:
            return ProfileDetailsViewModel.Constant.authorInfo
        case .commentCount:
            return ProfileDetailsViewModel.Constant.commentCount
        case .downloadCount:
            return ProfileDetailsViewModel.Constant.downloadCount
        case .likeCount:
            return ProfileDetailsViewModel.Constant.likeCount
        case .viewCount:
            return ProfileDetailsViewModel.Constant.viewCount
        case .favouriteCount:
            return ProfileDetailsViewModel.Constant.favouriteCount
        }
    }
    
    func getValue(hit: Hit) -> String {
        switch self {
        case .authorInfo:
            return hit.user ?? ProfileDetailsViewModel.Constant.notHaveInfo
        case .commentCount:
            return  "\(hit.comments ?? -1)"
        case .downloadCount:
            return "\(hit.downloads ?? -1)"
        case .likeCount:
            return "\(hit.likes ?? -1)"
        case .viewCount:
            return "\(hit.views ?? -1)"
        case .favouriteCount:
            return "\(hit.collections ?? -1)"
        }
    }
}
