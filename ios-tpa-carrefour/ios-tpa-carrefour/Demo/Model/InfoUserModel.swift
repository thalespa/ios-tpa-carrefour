//
//  InfoUserModel.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import Foundation

struct InfoUserModel: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_rl: String?
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
    let name: String?
    let company: String?
    let blog: String
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitter_username: String?
    let public_repos: Int
    let public_gists: Int
    let followers: Int
    let following: Int
    let createdAt: String?
    let updatedAt: String?
}
