//
//  CreateClientViewModel.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class CreateClientViewModel: ObservableObject{
    
    @Published var uiState: CreateClientUIState = .none
    
    var publisher: PassthroughSubject<Bool, Never>!
    private var cancellableSaveRequest: AnyCancellable?
    private var cancellableCEP: AnyCancellable?
    private var cancellableCPF: AnyCancellable?
    private var cancellableCNPJRequest: AnyCancellable?
    private let interactor: CreateClientInteractor
    
    @Published var document: String = ""
    
    @Published var adress = Endereco(id: 0, street: "", number: "", complement: "", cep: "", neighborhood: "", city: "", state: "")
    @Published var oldAdress = Endereco(id: 0, street: "", number: "", complement: "", cep: "", neighborhood: "", city: "", state: "")
    
    @Published var client = Client(id: 0, personId: 0, companyId: 0, type: ClientType.company.rawValue, active: 1)
    @Published var oldClient = Client(id: 0, personId: 0, companyId: 0, type: ClientType.company.rawValue, active: 0)
    @Published var person = Person(id: 0, adressId: 0, name: "", document: "", phone: "", email: "")
    @Published var cnpjData = CNPJConsulta(status: "", ultima_atualizacao: "", cnpj: "", tipo: "", porte: "", nome: "", fantasia: "", abertura: "", atividade_principal: [Atividade(code: "", text: "")], atividades_secundarias: [Atividade(code: "", text: "")], natureza_juridica: "", logradouro: "", numero: "", complemento: "", cep: "", bairro: "", municipio: "", uf: "", email: "", telefone: "", efr: "", situacao: "", data_situacao: "", motivo_situacao: "", situacao_especial: "", data_situacao_especial: "", capital_social: "", qsa: [QSA(nome: "", qual: "", pais_origem: "", nome_rep_legal: "", qual_rep_legal: "")], billing: Billing(free: false, database: false))

    @Published var clientType = ClientType.person
    @Published var isNew: Bool = true
    @Published var documentValido: Bool = false
    @Published var cnpjValido: Bool = false
    var cadastraCNPJ: Bool = true
    
    
    init(client: Client, interactor: CreateClientInteractor) {
        self.client = client
        self.oldClient = client
        self.isNew = false
        self.interactor = interactor
//        self.adress =
//        self.oldAdress =
    }
    
    init(interactor: CreateClientInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSaveRequest?.cancel()
        cancellableCEP?.cancel()
        cancellableCPF?.cancel()
        cancellableCNPJRequest?.cancel()
    }
    
    func reset(){
        self.client = self.oldClient
        documentValido = false
        cnpjValido = false
    }
    
    func validaDocumento(){
        if self.clientType == .company{
            self.cancellableCPF = self.interactor.buscaCNPJ(cnpj: self.document)
                .receive(on: DispatchQueue.main)
                .sink{ completion in
                    
                    switch(completion){
                    case .failure(let appError):
                        self.uiState = CreateClientUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { success in
                    if !success{
                        self.buscaDadosCNPJ()
                    }
                    else{
                        self.cadastraCNPJ = false
                    }
                    self.documentValido = true
                }
        }
        else{
            self.cancellableCPF = self.interactor.buscaCPF(request: self.document)
                .receive(on: DispatchQueue.main)
                .sink{ completion in
                    
                    switch(completion){
                    case .failure(let appError):
                        self.uiState = CreateClientUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { success in
                    if success {
                        self.documentValido = true
                    }
                    else{
                        self.publisher.send(false)
                    }
                }
        }
    }
    
    
    func insertClient() -> String{
        let clientid = interactor.fetchLastId(table: "client")
        if self.clientType == ClientType.company{
            self.client.type = ClientType.company.rawValue
            if self.cadastraCNPJ{
                return "INSERT INTO client VALUES(\(clientid), 0, \(self.interactor.fetchLastId(table: "company")), '\(self.client.type)', \(self.client.active) )"
            }
            else{
                let companyId = self.interactor.fetchCompanyId(cnpj: self.document)
                   return "INSERT INTO client VALUES(\(clientid), 0, \(companyId), '\(self.client.type)', \(self.client.active) )"
                
            }
        }
        self.client.type = ClientType.person.rawValue
        let query = "INSERT INTO client VALUES(\(clientid), \(self.interactor.fetchLastId(table: "person")), 0, '\(self.client.type)', \(self.client.active) )"
        print(query)
        return query
    }
    
    func insertAdress() -> String{
        if clientType == ClientType.company{
            return "INSERT INTO adress VALUES ( \(interactor.fetchLastId(table: "adress")), '\(cnpjData.logradouro)', '\(cnpjData.numero)', '\(cnpjData.complemento)', '\(cnpjData.cep)', '\(cnpjData.bairro)', '\(cnpjData.municipio)', '\(cnpjData.uf)');"
        }
        return "INSERT INTO adress VALUES ( \(interactor.fetchLastId(table: "adress")), '\(adress.street)', '\(adress.number)', '\(adress.complement)', '\(adress.cep)', '\(adress.neighborhood)', '\(adress.city)', '\(adress.state)');"
    }
    
    func insertQsaQuery() -> [String]{
        var query = [""].self
        var qsaid = interactor.fetchLastId(table: "qsa")

        for each in cnpjData.qsa{
            
            let companyid = interactor.fetchLastId(table: "company")
            query.append("INSERT INTO qsa VALUES ( \(qsaid), '\(each.nome)', '\(each.qual)', '\(each.pais_origem)', '\(each.nome_rep_legal)', '\(each.qual_rep_legal)');")
            query.append("INSERT INTO company_qsa VALUES (\(companyid), \(qsaid));")
            qsaid += 1
        }
         return query
    }
    
    func insertActivityQuery() -> [String]{
        var query = [""].self
        var activityid = interactor.fetchLastId(table: "activity")
        let companyid = interactor.fetchLastId(table: "company") - 1
        
        for each in cnpjData.atividade_principal{
            query.append("INSERT INTO activity VALUES ( \(activityid), '\(each.code)', '\(each.text)', 'primary');")
            query.append("INSERT INTO company_activities VALUES (\(activityid), \(companyid));")
            activityid += 1
        }
        
        for each in cnpjData.atividades_secundarias{
            query.append("INSERT INTO activity VALUES ( \(activityid), '\(each.code)', '\(each.text)', 'secondary');")
            query.append("INSERT INTO company_activities VALUES (\(activityid), \(companyid));")
            activityid += 1
        }
        return query
    }
    
    func insertCompanyQuery() -> String{
        
        var query = ""
        let adressid = interactor.fetchLastId(table: "adress")
        let companyid = interactor.fetchLastId(table: "company")
        let cleanedCNPJ = cnpjData.cnpj.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        query += "INSERT INTO company VALUES ( \(companyid), '\(cnpjData.status)', '\(cnpjData.ultima_atualizacao)', '\(cleanedCNPJ)', '\(cnpjData.tipo)', '\(cnpjData.porte)', '\(cnpjData.nome)', '\(cnpjData.fantasia)', '\(cnpjData.abertura)', '\(cnpjData.natureza_juridica)', \(adressid), '\(cnpjData.email)', '\(cnpjData.telefone)', '\(cnpjData.efr)', '\(cnpjData.situacao)', '\(cnpjData.data_situacao)', '\(cnpjData.motivo_situacao)', '\(cnpjData.situacao_especial)', '\(cnpjData.data_situacao_especial)', '\(cnpjData.capital_social)');"
        
        return query
    }
    
    func insertPerson() -> String{
        self.person.document = self.document
        return "INSERT INTO person VALUES ( \(interactor.fetchLastId(table: "person")), \(interactor.fetchLastId(table: "adress")), '\(person.name)', '\(person.document)', '\(person.phone)', '\(person.email)' )"
    }
    
    func buscaCEP(){
        self.uiState = .loading  //para barra de progresso e carregamento
        
        
        self.cancellableCEP = self.interactor.buscaCEP(request: self.adress.cep)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(_):
                    self.uiState = .error("CEP não encontrado")
                    break
                default:
                    break
                }
            }, receiveValue: { success in
                self.adress = Endereco(id: 0,
                                       street: success.street,
                                       number: "",
                                       complement: "",
                                       cep: success.cep,
                                       neighborhood: success.neighborhood,
                                       city: success.city,
                                       state: success.state)
                self.uiState = .cepfound
                print(self.adress)
            })
    }
    
    func updatePerson() -> String{
        if self.adress == self.oldAdress{
            return "UPDATE person SET name = '\(person.name)', document = '\(person.document)', phone = '\(person.phone)', email = '\(person.email)' WHERE id = \(self.oldClient.id)"
        }
        else{
            return "UPDATE person SET adress_id = \(interactor.fetchLastId(table: "adress")), name = '\(person.name)', document = '\(person.document)', phone = '\(person.phone)', email = '\(person.email)' WHERE id = \(self.oldClient.id)"
        }
    }
    
    func updateClient() -> String{//Arrumar
        if self.clientType == ClientType.company{
            self.client.type = ClientType.company.rawValue
            if self.cadastraCNPJ{
                return "UPDATE client SET company_id = \(self.interactor.fetchLastId(table: "company")), client_id = 0, type = '\(self.client.type)', active = \(self.client.active) WHERE id = \(self.interactor.fetchCompanyId(cnpj: self.document))"
            }
            else{
                return "UPDATE client SET active = \(self.client.active) WHERE id = \(self.interactor.fetchCompanyId(cnpj: self.document))"
                
            }
        }
        self.client.type = ClientType.person.rawValue
        let query = "UPDATE client SET company_id = 0, person_id = \(self.interactor.fetchLastId(table: "person")), type = '\(self.client.type)', active = \(self.client.active) WHERE id = \(self.client.id)"
        print(query)
        return query
    }
    
    func saveClient(){
        if self.documentValido{
            var finalQuery = [""].self
            
            if self.isNew{
                if self.clientType == ClientType.company{
                    if self.cadastraCNPJ{
                        finalQuery.append(insertAdress())
                        finalQuery.append(insertCompanyQuery())
                        for query in insertActivityQuery(){
                            finalQuery.append(query)
                        }
                        for query in insertQsaQuery(){
                            finalQuery.append(query)
                        }
                    }
                }
                else {
                    finalQuery.append(insertAdress())
                    finalQuery.append(insertPerson())
                }
                finalQuery.append(insertClient())
            }
            else{
                if  self.clientType == ClientType.person{
                    finalQuery.append(updatePerson())
                }
                else{
                    if self.cadastraCNPJ{
                        finalQuery.append(insertAdress())
                        finalQuery.append(insertCompanyQuery())
                        for query in insertActivityQuery(){
                            finalQuery.append(query)
                        }
                        for query in insertQsaQuery(){
                            finalQuery.append(query)
                        }
                    }
                }
                finalQuery.append(updateClient())
            }
            
            
            
            self.cancellableSaveRequest = self.interactor.saveClient(query: finalQuery)
                .receive(on: DispatchQueue.main)
                .sink{ completion in
                    
                    switch(completion){
                    case .failure(let appError):
                        self.uiState = CreateClientUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { created in
                    if created {
                        self.uiState = CreateClientUIState.error("Cliente cadastrado")
                        self.publisher.send(created)
                        self.uiState = .none
                    }
                }
        }
    }
    
    func buscaDadosCNPJ(){
        
        self.uiState = .loading  //para barra de progresso e carregamento
        
        
        self.cancellableCNPJRequest = self.interactor.buscaCNPJ(request: self.document)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    self.uiState = .error(error.titulo + "\n" + error.detalhes)
                    break
                default:
                    break
                }
            }, receiveValue: { success in
                self.cnpjData = CNPJConsulta(status: success.status,
                                        ultima_atualizacao: success.ultima_atualizacao,
                                        cnpj: success.cnpj,
                                        tipo: success.tipo,
                                        porte: success.porte,
                                        nome: success.nome,
                                        fantasia: success.fantasia,
                                        abertura: success.abertura,
                                        atividade_principal: success.atividade_principal,
                                        atividades_secundarias: success.atividades_secundarias,
                                        natureza_juridica: success.natureza_juridica,
                                        logradouro: success.logradouro,
                                        numero: success.numero,
                                        complemento: success.complemento,
                                        cep: success.cep,
                                        bairro: success.bairro,
                                        municipio: success.municipio,
                                        uf: success.uf,
                                        email: success.email,
                                        telefone: success.telefone,
                                        efr: success.efr,
                                        situacao: success.situacao,
                                        data_situacao: success.data_situacao,
                                        motivo_situacao: success.motivo_situacao,
                                        situacao_especial: success.situacao_especial,
                                        data_situacao_especial: success.data_situacao_especial,
                                        capital_social: success.capital_social,
                                        qsa: success.qsa,
                                        billing: success.billing)
                self.cnpjValido = true
                self.uiState = .none
            }
            )
        
    }
}
