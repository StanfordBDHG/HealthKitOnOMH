<!--
                  
This source file is part of the HealthKitOnFHIR open source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# HealthKitOnOMH

[![Build and Test](https://github.com/StanfordBDHG/HealthKitOnOMH/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordBDHG/HealthKitOnOMH/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/HealthKitOnOMH/branch/main/graph/badge.svg?token=17BMMYE3AC)](https://codecov.io/gh/StanfordBDHG/HealthKitOnOMH)


The HealthKitonOMH library provides extensions that convert supported HealthKit samples into corresponding [IEEE Standard 1752.1](https://opensource.ieee.org/omh/1752) and [Open mHealth (OMH)](https://www.openmhealth.org/documentation/#/overview/get-started) schemas.


## Installation
HealthKitOnOMH can be installed into your Xcode project using [Swift Package Manager](https://github.com/apple/swift-package-manager).

1. In Xcode 14 and newer (requires Swift 5.7), go to “File” » “Add Packages...”
2. Enter the URL to this GitHub repository, then select the `HealthKitOnOMH` package to install.

## Usage

The HealthKitonOMH library provides extensions that convert supported HealthKit samples into corresponding [IEEE Standard 1752.1](https://opensource.ieee.org/omh/1752) and [Open mHealth (OMH)](https://www.openmhealth.org/documentation/#/overview/get-started) schemas.

```swift
let sample: HKQuantitySample = // ...
let dataPoint: DataPoint<HealthKitQuantitySample> = try sample.omhDataPoint
```

## Example

In the following example, we will query the HealthKit store for step count data, convert the resulting samples to Open mHealth data points based on the [omh:heart-rate](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_heart-rate) schema.

```swift
import HealthKitOnOMH

// Initialize an HKHealthStore instance and request permissions with it
// ...

// Or create a HealthKit sample
let date = ISO8601DateFormatter().date(from: "1885-11-11T00:00:00-08:00") ?? .now
let sample = HKQuantitySample(
    type: HKQuantityType(.heartRate),
    quantity: HKQuantity(unit: HKUnit.count().unitDivided(by: .minute()), doubleValue: 42.0),
    start: date,
    end: date
)

// Convert the sample into an Open mHealth (OMH) Data Point
let json: String
do {
    guard let omhDataPoint = try sample.omhDataPoint as? any DataPoint<HeartRate> else {
        return
    }
            
    // Encode the data point as JSON
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
    
    // Note that Open mHealth uses snake case for its properties when represented in JSON
    encoder.keyEncodingStrategy = .convertToSnakeCase
            
    let data = try encoder.encode(omhDataPoint)
            
    json = String(decoding: data, as: UTF8.self)
} catch {
    // Handle any errors here.
    // ...
}
```

The above code will produce the following JSON in conformance with Open mHealth's [heart-rate](https://www.openmhealth.org/documentation/#/schema-docs/schema-library/schemas/omh_heart-rate) schema:

```
{
  "body" : {
    "effective_time_frame" : {
      "time_interval" : {
        "end_date_time" : {
          "value" : "1885-11-11T08:00:00Z"
        },
        "start_date_time" : {
          "value" : "1885-11-11T08:00:00Z"
        }
      }
    },
    "heart_rate" : {
      "unit" : "beats/min",
      "value" : 42
    }
  },
  "header" : {
    "creation_date_time" : {
      "value" : "2023-10-11T11:53:30Z"
    },
    "id" : "FF7F647D-8757-4926-871A-3D61DDCD0900",
    "schema_id" : {
      "name" : "heart-rate",
      "namespace" : "omh",
      "version" : "2.0"
    }
  }
}
```

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/HealthKitOnOMH/tree/main/LICENSES) for more information.


## Contributors
This project is developed as part of the Stanford Biodesign for Digital Health projects at Stanford.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/HealthKitOnOMH/tree/main/CONTRIBUTORS.md) for a full list of all HealthKitOnOMH contributors.


## Notices
HealthKit is a registered trademark of Apple, Inc.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
