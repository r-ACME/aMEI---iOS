//
//  SignUpViewModel.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel : ObservableObject{

    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableRequestLogin: AnyCancellable?
    private var cancellableRequestSignUp: AnyCancellable?
    private let interactor: SignUpInteractor
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var cnpj = ""
    @Published var senha = ""
    @Published var cnpjValido = false
    @Published var action: Int? = 0
    private var adress_id: Int = 0
    private var cnpjData: CNPJConsulta = CNPJConsulta(status: "", ultima_atualizacao: "", cnpj: "", tipo: "", porte: "", nome: "", fantasia: "", abertura: "", atividade_principal: [Atividade(code: "", text: "")], atividades_secundarias: [Atividade(code: "", text: "")], natureza_juridica: "", logradouro: "", numero: "", complemento: "", cep: "", bairro: "", municipio: "", uf: "", email: "", telefone: "", efr: "", situacao: "", data_situacao: "", motivo_situacao: "", situacao_especial: "", data_situacao_especial: "", capital_social: "", qsa: [QSA(nome: "", qual: "", pais_origem: "", nome_rep_legal: "", qual_rep_legal: "")], billing: Billing(free: false, database: false))
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableRequestLogin?.cancel()
        cancellableRequestSignUp?.cancel()
    }
    
    func getIds(){
        
    }
    
    func createAdressQuery() -> String{
        return "INSERT INTO adress VALUES ( \(interactor.fetchLastId(table: "adress")), '\(cnpjData.logradouro)', '\(cnpjData.numero)', '\(cnpjData.complemento)', '\(cnpjData.cep)', '\(cnpjData.bairro)', '\(cnpjData.municipio)', '\(cnpjData.uf)');"
    }
    
    func createQsaQuery() -> [String]{
        var query = [""].self

        for each in cnpjData.qsa{
            let qsaid = interactor.fetchLastId(table: "qsa")
            let companyid = interactor.fetchLastId(table: "company")
            query.append("INSERT INTO qsa VALUES ( \(qsaid), '\(each.nome)', '\(each.qual)', '\(each.pais_origem)', '\(each.nome_rep_legal)', '\(each.qual_rep_legal)');")
            query.append("INSERT INTO company_qsa VALUES (\(companyid), \(qsaid));")
        }
         return query
    }
    
    func createActivityQuery() -> [String]{
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
    
    func createCompanyQuery() -> String{
        
        var query = ""
        let adressid = interactor.fetchLastId(table: "adress")
        let companyid = interactor.fetchLastId(table: "company")
        let cleanedCNPJ = cnpjData.cnpj.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        query += "INSERT INTO company VALUES ( \(companyid), '\(cnpjData.status)', '\(cnpjData.ultima_atualizacao)', '\(cleanedCNPJ)', '\(cnpjData.tipo)', '\(cnpjData.porte)', '\(cnpjData.nome)', '\(cnpjData.fantasia)', '\(cnpjData.abertura)', '\(cnpjData.natureza_juridica)', \(adressid), '\(cnpjData.email)', '\(cnpjData.telefone)', '\(cnpjData.efr)', '\(cnpjData.situacao)', '\(cnpjData.data_situacao)', '\(cnpjData.motivo_situacao)', '\(cnpjData.situacao_especial)', '\(cnpjData.data_situacao_especial)', '\(cnpjData.capital_social)');"
        
        return query
    }
    
    func createUser() -> String{
        var query = ""
        var userid = interactor.fetchLastId(table: "users")
        var companyid = interactor.fetchLastId(table: "company") - 1
        let cleanedCNPJ = cnpjData.cnpj.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)

        query += "INSERT INTO users VALUES (\(userid), \(companyid), '\(cleanedCNPJ)', '\(senha)');"
        return query
    }
    
    func createAccount(){
        
        var finalQuery = [""].self
        
        finalQuery.append(createAdressQuery())
        finalQuery.append(createCompanyQuery())
        for query in createActivityQuery(){
            finalQuery.append(query)
            
        }
        for query in createQsaQuery(){
            finalQuery.append(query)
            
        }
        finalQuery.append(createUser())
        
        self.cancellableRequestSignUp = self.interactor.createAccount(query: finalQuery)
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message.titulo + appError.message.detalhes)
                    break
                case .finished:
                    break
                }
            } receiveValue: {created in
                if (created){
                    
                    self.cancellableRequestLogin = self.interactor.login(request: UserAuth(cnpj: self.cnpj, password: self.senha))
                        .receive(on: DispatchQueue.main)
                        .sink{ completion in
                            
                            switch(completion){
                            case .failure(let appError):
                                self.uiState = SignUpUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { success in
                            self.interactor.insertAuth(user: UserAuth(cnpj: self.cnpj, password: self.senha))
                            self.publisher.send(created)
                            self.uiState = .success
                        }
                }
            }
    }
    
    func buscaCNPJ(){
        
        self.uiState = .loading  //para barra de progresso e carregamento
        
        
        self.cancellableRequestSignUp = self.interactor.buscaCNPJ(request: self.cnpj)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(_):
                    self.uiState = .error("CNPJ não encontrado")
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
                
                print(success)
                self.cnpjValido = self.cnpjData.natureza_juridica.contains("213-5") ?? false
                if(self.cnpjValido){
                    self.uiState = .none
                }
                else{
                    self.action = 5
                    self.uiState = .none
                }
            }
            )
        
    }
    
    func signUpFinish() -> some View{
        
        mainView()
    }
    
    func mainView() -> some View{
        return SignUpViewRouter.makeMainView()
    }
}
