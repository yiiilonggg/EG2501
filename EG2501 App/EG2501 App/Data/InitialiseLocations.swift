//
//  InitialiseLocations.swift
//  EG2501 App
//
//  Created by Yi Long on 24/10/22.
//

import Foundation
import MapKit

var originPureLocationTemplate: location = location(id: UUID(), name: "", coord: CLLocationCoordinate2D(latitude: 1.3994598548390178, longitude: 103.90583853449176))
var destinationPureLocationTemplate: location = location(id: UUID(), name: "", coord: CLLocationCoordinate2D(latitude: 1.4059953853028693, longitude: 103.9026254423773))
var punggolMRT: location = location(id: UUID(), name: "Punggol MRT Station", coord: CLLocationCoordinate2D(latitude: 1.4059953853028693, longitude: 103.9026254423773))
var sooTeckLRT: location = location(id: UUID(), name: "Soo Teck LRT Station", coord: CLLocationCoordinate2D(latitude: 1.4055895903971825, longitude: 103.89719669193707))
var sumangLRT: location = location(id: UUID(), name: "Sumang LRT Station", coord: CLLocationCoordinate2D(latitude: 1.408700014539525, longitude: 103.89854852529069))
var samuderaLRT: location = location(id: UUID(), name: "Samudera LRT Station", coord: CLLocationCoordinate2D(latitude: 1.4160041322128736, longitude: 103.90219632955171))
var punggolPointLRT: location = location(id: UUID(), name: "Punggol Point LRT Station", coord: CLLocationCoordinate2D(latitude: 1.4170176547437445, longitude: 103.90665392604484))
var samKeeLRT: location = location(id: UUID(), name: "Sam Kee LRT Station", coord: CLLocationCoordinate2D(latitude: 1.409960228799469, longitude: 103.90495876996692))
var damaiLRT: location = location(id: UUID(), name: "Damai LRT Station", coord: CLLocationCoordinate2D(latitude: 1.4052302398108665, longitude: 103.90859584535262))
var oasisLRT: location = location(id: UUID(), name: "Oasis LRT Station", coord: CLLocationCoordinate2D(latitude: 1.4025166591052414, longitude: 103.91266207431049))
var kadaloorLRT: location = location(id: UUID(), name: "Kadaloor LRT Station", coord: CLLocationCoordinate2D(latitude: 1.3998567033588594, longitude: 103.91658882832343))
var coralEdgeLRT: location = location(id: UUID(), name: "Coral Edge LRT Station", coord: CLLocationCoordinate2D(latitude: 1.393925420256907, longitude: 103.91250114168695))
var meridianLRT: location = location(id: UUID(), name: "Meridian LRT Station", coord: CLLocationCoordinate2D(latitude: 1.397164567686388, longitude: 103.90903572770928))
var coveLRT: location = location(id: UUID(), name: "Cove LRT Station", coord: CLLocationCoordinate2D(latitude: 1.3994598548390178, longitude: 103.90583853449176))

var locationsCore: [location] = [punggolMRT, sooTeckLRT, sumangLRT, samuderaLRT, punggolPointLRT, samKeeLRT, damaiLRT, oasisLRT, kadaloorLRT, coralEdgeLRT, meridianLRT, coveLRT,_Punggol_Temp_Int,_Opp_Blk_199C,_Opp_Blk_296,_BLK_301A,_BLK_604A,_Punggol_Rd_End,_Aft_Soo_Teck_Stn,_Bef_Soo_Teck_Stn,_Cove_Stn_Exit_B,_Cove_Stn_Exit_A,_Meridian_Stn_Exit_B,_Meridian_Stn_Exit_A,_Coral_Edge_Stn_Exit_B,_Coral_Edge_Stn_Exit_A,_Atf_Punggol_Ctrl,_Bef_Punggol_Ctrl,_Bef_Punggol_Rd,_Aft_Punggol_Rd,_Opp_Blk_201A,_Blk_201A,_Blk_303D,_Blk_298,_Riviera_Stn_Exit_B,_Riviera_Stn_Exit_A,_Blk_196C,_Blk_178,_Punggol_Stn_Waterway_Pt,_Punggol_Stn_Int,_Blk_649,_Blk_162B,_Opp_Blk_188,_Bet_Blks_187_188,_Punggol_Sec_Blk_601B,_Opp_Punggol_Sec_Blk_195E,_Damai_Stn_Exit_B,_Damai_Stn_Exit_A,_Oasis_Stn_Exit_B_Blk_617D,_Oasis_Stn_Exit_A,_Kadaloor_Stn_Exit_B,_Kadaloor_Stn_Exit_A,_Opp_Blk_268D,_Blk_268C,_Opp_Blk_272C,_Blk_272C,_Punggol_View_Pr_Sch,_Opp_Punggol_View_Pr_Sch,_Blk_682A,_Blk_661A,_Punggol_Sec_Sch,_Opp_Punggol_Sec_Sch,_Blk_672A,_Blk_670A,_Opp_Blk_264A,_Bef_Blk_264,_Horizon_Pr_Sch,_Opp_Horizon_Pr_Sch,_Greendale_Pr_Sch,_Twin_Waterfalls,_Blk_220C,_Opp_Blk_315B,_Blk_315B,_Blk_322_CP,_Opp_Blk_322_CP,_Blk_312_CP,_Blk_310B,_Bef_Punggol_Dr,_Aft_Punggol_Dr,_Opp_Blk_259_CP,_Blk_259_CP,_Waterwoods,_Aft_Punggol_Field,_Blk_226A,_Blk_224A,_Blk_228B,_Opp_Blk_228B,_Blk_227A,_Opposite_Blk_227A,_WATERWAY_PR_SCH,_OPP_WATERWAY_PR_SCH,_BLK_218,_BLK_258A,_Sumang_Stn_Exit_B,_Sumang_Stn_Exit_A,_Nibong_Stn_Exit_B,_Nibong_Stn_Exit_A,_Samudera_Stn_Exit_B,_Samudera_Stn_Exit_A,_Aft_Punggol_Pt_Stn,_Bef_Punggol_Pt_Stn,_Marina_Country_Club,_Blk_413C,_Blk_421C,_Punggol_cove_pr_sch,_Opp_punggol_cove_pr_sch,_Bef_Northshore_Cres]
var locationsLRTCore: [location] = [punggolMRT, sooTeckLRT, sumangLRT, samuderaLRT, punggolPointLRT, samKeeLRT, damaiLRT, oasisLRT, kadaloorLRT, coralEdgeLRT, meridianLRT, coveLRT]
