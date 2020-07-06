//
//  HomeViewModel.swift
//  AsurionTask
//
//  Created by Yogesh Ingole on 01/07/20.
//  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
//

import UIKit

class HomeViewModel {


    var arrPetList: [PetModel] = [PetModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var settingModel:SettingModel?
    {
        didSet {
            self.updateSettingStatus?()
        }
    }

    var reloadTableViewClosure: (()->())?
    var updateSettingStatus: (()->())?
    init() {
        loadinitialData()
    }
    func loadinitialData()
    {
        getSetting()
        getPetsList()
    }
    // MARK: Get Setting
    public func getSetting()
    {
        let settingProxy = GetSettingsProxy()
        settingProxy.delegate = self
        settingProxy.getSetting()
    }

    // MARK: Get Setting

    func getPetsList()
    {
        let petsProxy = GetPetsProxy()
        petsProxy.delegate = self
        petsProxy.getPetsList()
    }
}
extension HomeViewModel:GetSettingProtocol
{
    func getSettingSuccess(response:SettingModel)
    {
        self.settingModel = response


        print(response.workHours)
    }
    func getSettingFailed(error:String)
    {
        print(error)
    }
}

extension HomeViewModel:GetPetsProxyProtocol
{
    func getPetsSuccess(response: [PetModel]) {
        self.arrPetList = response
    }
    func getPetFailed(error: String) {

    }
}

