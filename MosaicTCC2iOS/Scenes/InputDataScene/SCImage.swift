//
//  DICOMModel.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 22/02/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

struct SCImage: Codable {
    
    var SOPClassUID = "1.2.840.10008.5.1.4.1.1.7"
    var SOPInstanceUID = "1.2.840.10008.5.1.4.1.1.7"
    
    private(set) var currentDateString: String?
    private(set) var currentTimeString: String?

    var fileMeta = FileMeta()
    var patient: Patient?
    var generalStudy: GeneralStudy?
    var generalSeries: GeneralSeries?
    var scEquipament: SCEquipament?
    var generalImage: GeneralImage?
    
    init(patient: Patient?,
         generalStudy: GeneralStudy?,
         generalSeries: GeneralSeries?,
         scEquipament: SCEquipament?,
         generalImage: GeneralImage?) {
        
        currentDateString = Date().convertToStringFromFormat("yyyyMMdd")
        currentTimeString = Date().convertToStringFromFormat("HHMMSS")
        self.generalStudy = generalStudy
        self.generalStudy?.StudyDate = currentDateString
        self.generalStudy?.StudyTime = currentTimeString
        self.generalImage = generalImage
        self.generalImage?.ContentDate = currentDateString
        self.generalImage?.ContentTime = currentTimeString
        self.patient = patient
        self.generalSeries = generalSeries
        self.scEquipament = scEquipament
        
    }
   
}

struct FileMeta: Codable {
    var MediaStorageSOPClassUID = "1.2.840.10008.5.1.4.1.1.7"
    var MediaStorageSOPInstanceUID = "1.2.840.10008.5.1.4.1.1.7"
//        var ImplementationClassUID = "1.2.3.4"
    var FileMetaInformationGroupLength = 190
//      var   FileMetaInformationVersion = b'\x00\x01'
    var ImplementationClassUID = "1.2.826.0.1.3680043.8.498.1"
}

struct Patient: Codable {
   var PatientName = "Test^Firstname"
   var PatientID = "123456"
   var PatientBirthDate = "19890605"
   var PatientSex = "M"
   var PatientOrientation = ""
}

struct GeneralStudy: Codable  {
    var StudyInstanceUID = "1.2.3.4.5.6.7"
//      var   StudyDate = datetime.datetime.now().strftime('%Y%m%d')
//      var   StudyTime = datetime.datetime.now().strftime('%H%M%S.%f')
    var   StudyDate: String?
    var   StudyTime: String?
    var StudyID = "Tyson"
    var ReferringPhysicianName = "Mike^Tyson"
    var AccessionNumber = "9887776"
}

struct GeneralSeries: Codable  {
    var SeriesInstanceUID = "1.2.3.4.5.6"
    var SeriesNumber = "123455"
    var Modality = "GM"
    var Laterality = "L"
}

struct SCEquipament: Codable  {
    var ConversionType = "SI"
}

struct GeneralImage: Codable  {
    var InstanceNumber = "17580"
    var PatientOrientation = ""
//      var   dt = datetime.datetime.now()
//      var   ContentDate = dt.strftime('%Y%m%d')
//      var   timeStr = dt.strftime('%H%M%S.%f')  # long format with micro seconds
//      var   ContentTime = timeStr
    var ContentDate: String?
    var ContentTime: String?
}

struct PixelData {
    func algo() {
        
    }
}
