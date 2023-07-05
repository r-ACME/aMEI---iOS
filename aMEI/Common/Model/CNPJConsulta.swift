//
//  CNPJConsulta.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
    

struct CNPJConsulta: Decodable{
    
    let status: String
    let ultima_atualizacao: String
    let cnpj: String
    let tipo: String
    let porte: String
    let nome: String
    let fantasia: String
    let abertura: String
    let atividade_principal: [Atividade]
    let atividades_secundarias: [Atividade]
    let natureza_juridica: String
    let logradouro: String
    let numero: String
    let complemento: String
    let cep: String
    let bairro: String
    let municipio: String
    let uf: String
    let email: String
    let telefone: String
    let efr: String
    let situacao: String
    let data_situacao: String
    let motivo_situacao: String
    let situacao_especial: String
    let data_situacao_especial: String
    let capital_social: String
    let qsa: [QSA]
    let billing: Billing
}

struct Billing: Decodable{
    let free: Bool
    let database: Bool
}

struct QSA: Decodable{
    let nome: String
    let qual: String
    let pais_origem: String
    let nome_rep_legal: String
    let qual_rep_legal: String
}

struct Atividade: Decodable{
    let code: String
    let text: String
}
/*
struct CNPJConsulta: Decodable{
    
    let code: String
    let status: String
    let message: String
    let cnpj: String
    let cnpj_matriz: String
    let nome_empresarial: String
    let situacao_simples_nacional: String
    let situacao_simei: String
    let situacao_simples_nacional_anterior: String
    let agendamentos: String
    let eventos_futuros_simples_nacional: String
    let eventos_futuros_simples_simei: String
}
*/
