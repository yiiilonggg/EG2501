//
//  InitialiseRewards.swift
//  EG2501 App
//
//  Created by Yi Long on 23/10/22.
//

import Foundation
import SwiftUI

var ntuc: Reward = Reward(id: UUID(), name: "NTUC FairPrice $5-off Voucher", points: 25, usedBy: "31/12/2022", redeemed: false, redeemedDate: "", imageName: "NTUC Logo")
var grab: Reward = Reward(id: UUID(), name: "GRAB $2-off Self-Pickup Voucher", points: 10, usedBy: "31/12/2022", redeemed: false, redeemedDate: "", imageName: "GRAB Logo")
var popular: Reward = Reward(id: UUID(), name: "POPULAR $7-off Voucher", points: 30, usedBy: "31/12/2022", redeemed: true, redeemedDate: "21/10/2022", imageName: "Popular Logo")
var shuttleBus: Reward = Reward(id: UUID(), name: "Punggol Connect $4-off Voucher", points: 20, usedBy: "31/12/2022", redeemed: false, redeemedDate: "", imageName: "applet")

var rewardsListCore: [Reward] = [ntuc, grab, popular, shuttleBus]

var popularRewardCat: RewardCategory = RewardCategory(id: UUID(), name: "Popular", col: LinearGradient(colors: [.orange, .yellow], startPoint: .leading, endPoint: .trailing), image: "person.3.fill", imageOffsetX: 130, imageOffsetY: 20, wordOffsetX: -100, imageSize: 70)
var foodDining: RewardCategory = RewardCategory(id: UUID(), name: "Food & Dining", col: LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing), image: "leaf.fill", imageOffsetX: 150, imageOffsetY: 20, wordOffsetX: -65, imageSize: 70)
var localBusiness: RewardCategory = RewardCategory(id: UUID(), name: "Local Businesses", col: LinearGradient(colors: [.mint, .green], startPoint: .leading, endPoint: .trailing), image: "figure.wave", imageOffsetX: 150, imageOffsetY: 40, wordOffsetX: -50, imageSize: 130)
var supermarket: RewardCategory = RewardCategory(id: UUID(), name: "Supermarkets", col: LinearGradient(colors: [.black, .gray], startPoint: .leading, endPoint: .trailing), image: "cart.fill", imageOffsetX: 140, imageOffsetY: 15, wordOffsetX: -70, imageSize: 70)
var fashionApparel: RewardCategory = RewardCategory(id: UUID(), name: "Fashion & Apparel", col: LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing), image: "tshirt.fill", imageOffsetX: 140, imageOffsetY: 30, wordOffsetX: -50, imageSize: 80)
var healthFitness: RewardCategory = RewardCategory(id: UUID(), name: "Health & Fitness", col: LinearGradient(colors: [.red, .yellow], startPoint: .leading, endPoint: .trailing), image: "cross.fill", imageOffsetX: 140, imageOffsetY: 10, wordOffsetX: -60, imageSize: 70)
var leisure: RewardCategory = RewardCategory(id: UUID(), name: "Leisure", col: LinearGradient(colors: [.brown, .yellow], startPoint: .leading, endPoint: .trailing), image: "gamecontroller.fill", imageOffsetX: 140, imageOffsetY: 20, wordOffsetX: -110, imageSize: 70)
var electronicsGadgets: RewardCategory = RewardCategory(id: UUID(), name: "Electronics", col: LinearGradient(colors: [.blue, .yellow], startPoint: .leading, endPoint: .trailing), image: "4k.tv.fill", imageOffsetX: 140, imageOffsetY: 25, wordOffsetX: -90, imageSize: 70)

var rewardsCategoriesCore: [RewardCategory] = [popularRewardCat, foodDining, localBusiness, supermarket, fashionApparel, healthFitness, leisure, electronicsGadgets]
