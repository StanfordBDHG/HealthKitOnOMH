//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT

public enum SpecimenSource: String, Codable {
    case breath = "breath"
    case capillaryBlood = "capillary blood"
    case interstitialFluid = "interstitial fluid"
    case saliva = "saliva"
    case sweat = "sweat"
    case tears = "tears"
    case urine = "urine"
}
