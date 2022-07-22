//
//  MeaningsViewModel.swift
//  Meanings
//
//  Created by 1964058 on 02/06/22.
//

import Foundation

var baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="

class MeaningsViewModel {
    
    var apiManager:APIManager!
    var errorMessage = Observable<String>()
    var isSearching = Observable<Bool>()
    var meanings = Observable<[MeaningCellViewModel]>()
    
    init(apiManger:APIManager = APIManager()) {
        self.apiManager = apiManger
    }
    
    var maeningCellViewModel: [MeaningCellViewModel]?
    
    /*func fetchMeaning(with text:String, completion: @escaping (_ status:Bool, _ errorMessage:String?, _ searchResults:[MeaningCellViewModel]?) -> Void) {
            guard !text.isEmpty, let url = URL(string:baseURL + text) else {
                completion(false, "Data Error",nil)
                return
            }
            apiManager.loadData(from: url) { result in
                switch result {
                case .data(let data):
                    do {
                        var meanings = [MeaningCellViewModel]()
                        let meaning:[Meaning] = try JSONDecoder().decode([Meaning].self, from: data)
                        if meaning.isEmpty {
                            print("Empty Data")
                            self.meanings = Observable(meanings)
                            self.maeningCellViewModel = meanings
                            completion(false,"Empty Data",self.maeningCellViewModel)
                            return
                        } else {
                            var lfs:[lfs] = []
                            if let first = meaning.first, let meanings = first.lfs {
                                lfs = meanings
                            }
                            for item in lfs {
                                meanings.append(MeaningCellViewModel(meaningText: item.lf))
                            }
                            self.maeningCellViewModel = meanings
                            completion(true,nil, self.maeningCellViewModel)
                            return
                        }
                    } catch let parseError {
                        print(parseError.localizedDescription)
                        completion(false,parseError.localizedDescription, nil)
                        return
                    }
                case .error(let error):
                    print(error.localizedDescription)
                    completion(false,error.localizedDescription, nil)
                    return
                }
            }
        }*/
    
    func fetchMeaning(with text:String) {
                self.isSearching.value = true
                guard !text.isEmpty, let url = URL(string:baseURL + text) else {
                    self.isSearching.value = false
                    return
                }
                apiManager.loadData(from: url) { result in
                    switch result {
                    case .data(let data):
                        do {
                            var meanings = [MeaningCellViewModel]()
                            let meaning:[Meaning] = try JSONDecoder().decode([Meaning].self, from: data)
                            if meaning.isEmpty {
                                self.meanings.value = []
                                self.isSearching.value = false
                                return
                            } else {
                                var lfs:[lfs] = []
                                if let first = meaning.first, let meanings = first.lfs {
                                    lfs = meanings
                                }
                                for item in lfs {
                                    meanings.append(MeaningCellViewModel(meaningText: item.lf))
                                }
                                self.meanings.value = meanings
                                self.isSearching.value = false
                                return
                            }
                        } catch let parseError {
                            print(parseError.localizedDescription)
                            self.errorMessage.value = parseError.localizedDescription
                            self.isSearching.value = false
                            return
                        }
                    case .error(let error):
                        print(error.localizedDescription)
                        self.errorMessage.value = error.localizedDescription
                        self.isSearching.value = false
                        return
                    }
                }
            }
}
