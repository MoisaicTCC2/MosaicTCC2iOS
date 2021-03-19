//
//  StudiesModel.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 18/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct StudiesModel {
    
    // MARK: - Patient
    struct Patient: Codable {
        let patientID, patientName, patientSex, patientsBirthDate: String
        let studies: [Study]

        enum CodingKeys: String, CodingKey {
            case patientID = "patient_id"
            case patientName = "patient_name"
            case patientSex = "patient_sex"
            case patientsBirthDate = "patients_birthdate"
            case studies = "studies"
        }
    }

    // MARK: - Study
    struct Study: Codable {
        let accessionNumber, referringPhysician: String
        let series: [Series]
        let studyDate, studyID, studyInstanceUID, studyTime: String

        enum CodingKeys: String, CodingKey {
            case accessionNumber = "accession_number"
            case referringPhysician = "referring_physician"
            case series = "series"
            case studyDate = "study_date"
            case studyID = "study_id"
            case studyInstanceUID = "study_instance_uid"
            case studyTime = "study_time"
        }
    }

    // MARK: - Series
    struct Series: Codable {
        let files: [File]
        let modality, seriesInstanceUID, seriesNumber, studyID: String

        enum CodingKeys: String, CodingKey {
            case files = "files"
            case modality = "modality"
            case seriesInstanceUID = "series_instance_uid"
            case seriesNumber = "series_number"
            case studyID = "study_id"
        }
    }

    // MARK: - File
    struct File: Codable {
        let dcmURL: String
        let imageURL: String
        let sopInstanceUID: String

        enum CodingKeys: String, CodingKey {
            case dcmURL = "dcm_url"
            case imageURL = "image_url"
            case sopInstanceUID = "sop_instance_uid"
        }
    }

    
}
