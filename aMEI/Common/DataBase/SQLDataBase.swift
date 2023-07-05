//
//  SQLDataBase.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation


enum SQLDataBase: String, CaseIterable, Identifiable{
    
    case insert = "INSERT INTO %d VALUES (%d)"
    case delete = "DELETE FROM %d"
    case select_base = "SELECT %d FROM %d"
    case select_join = " JOIN %d ON %d = %d"
    case query_where = " WHERE %d"
    case query_like = " WHERE %d LIKE %d"
    case query_and = " AND %d"
    case query_or = " OR %d"
    case query_between = " BETWEEN %d AND %d"
    case select_order_by = " ORDER BY %d"
    case select_limit = " LIMIT %d"
    case update = "UPDATE %d SET %d"
    case createFAQ = "CREATE TABLE faq(id int not null,question varchar(5000),answer varchar(100000),PRIMARY KEY (id));"
      case createTYPE = "CREATE TABLE type(id int not null, name varchar(1000), expenses int, revenue int, PRIMARY KEY (id));"
          
      case createFINANCIAL = "CREATE TABLE financial_statement(id int not null, type_id int not null, description varchar(1000), value varchar(1000), recurrent int, flow varchar(1000), PRIMARY KEY (id), FOREIGN KEY (type_id) REFERENCES type(id));"
          
      case createSERVICE = "CREATE TABLE service(id int not null, name varchar(1000), description varchar(1000), value varchar(1000), duration varchar(1000), type_id int not null, PRIMARY KEY (id), FOREIGN KEY (type_id) REFERENCES type(id));"

      case createPRODUCT = "CREATE TABLE product(id int not null, name varchar(1000), description varchar(1000), value varchar(1000), storage varchar(1000), type_id int not null, PRIMARY KEY (id), FOREIGN KEY (type_id) REFERENCES type(id));"
          
      case createINVENTORY = "CREATE TABLE inventory(id int not null, date varchar(1000), amount varchar(1000), product_id int not null, PRIMARY KEY (id), FOREIGN KEY (product_id) REFERENCES product(id));"
          
      case createQSA = "CREATE TABLE qsa(id int not null, nome varchar(1000), qual varchar(1000), pais_origem varchar(1000), nome_rep_legal varchar(1000), qual_rep_legal varchar(1000), PRIMARY KEY (id));"
          
      case createACTIVITY = "CREATE TABLE activity(id int not null, code varchar(1000), text varchar(1000), type varchar(1000) DEFAULT ‘primary’, PRIMARY KEY (id) );"
          
      case createADRESS = "CREATE TABLE adress(id int not null, logradouro varchar(1000), numero varchar(1000), complemento varchar(1000), cep varchar(1000), bairro varchar(1000), municipio varchar(1000), uf varchar(1000), PRIMARY KEY (id));"
          
      case createPERSON = "CREATE TABLE person(id int not null, adress_id int, name varchar(1000), document varchar(1000), phone varchar(1000), email varchar(1000), PRIMARY KEY (id), FOREIGN KEY (adress_id) REFERENCES adress(id));"
          
      case createRH = "CREATE TABLE rh(id int not null, person_id int not null, role varchar(1000), wage varchar(1000), extra varchar(1000), PRIMARY KEY (id), FOREIGN KEY (person_id) REFERENCES person(id));"
          
      case createCLOCK = "CREATE TABLE clock_in_out(id int not null, rh_id int not null, date varchar(1000), day_in varchar(1000), day_out varchar(1000), PRIMARY KEY (id), FOREIGN KEY (rh_id) REFERENCES rh(id));"
          
      case createCOMPANY = "CREATE TABLE company(id int NOT NULL, status varchar(1000), ultima_atualizacao varchar(1000), cnpj varchar(20), tipo varchar(1000), porte varchar(1000), nome varchar(1000), fantasia varchar(1000), abertura varchar(1000), natureza_juridica varchar(1000), adress_id int, email varchar(1000), telefone varchar(1000), efr varchar(1000), situacao varchar(1000), data_situacao varchar(1000), motivo_situacao varchar(1000), situacao_especial varchar(1000), data_situacao_especial varchar(1000), capital_social varchar(1000), PRIMARY KEY (id), FOREIGN KEY (adress_id) REFERENCES adress(id));"
          
      case createCLIENT = "CREATE TABLE client(id int not null, person_id int, company_id int, type varchar(1000), active int, PRIMARY KEY (id), FOREIGN KEY (person_id) REFERENCES person(id), FOREIGN KEY (company_id) REFERENCES company(id));"
          
      case createSCHEDULE = "CREATE TABLE schedule(id int not null, datetime varchar(1000), title varchar(1000), description varchar(1000), alerts varchar(1000), client_id int, PRIMARY KEY (id), FOREIGN KEY (client_id) REFERENCES client(id));"
          
      case createSCHEDULE_SERVICE = "CREATE TABLE schedule_service(id int not null, schedule_id int, service_id int, amount_service varchar(1000), product_id int, amount_product varchar(1000), completion int, discount varchar(1000), PRIMARY KEY (id), FOREIGN KEY (schedule_id) REFERENCES schedule(id), FOREIGN KEY (service_id) REFERENCES service(id), FOREIGN KEY (product_id) REFERENCES product(id));"
          
      case createUSERS = "CREATE TABLE users(id int not null, company_id int not null, cnpj varchar(20), password varchar(1000), PRIMARY KEY (id), FOREIGN KEY (company_id) REFERENCES company(id));"
          
      case createACCOUNTING = "CREATE TABLE accounting(id int not null, balance varchar(1000), date varchar(1000), user_id int not null, PRIMARY KEY (id), FOREIGN KEY (user_id) REFERENCES user(id));"
          
      case createCOMPANY_ACTIVITIES = "CREATE TABLE company_activities(company_id int not null, activity_id int not null, FOREIGN KEY (company_id) REFERENCES company(id), FOREIGN KEY (activity_id) REFERENCES activity(id));"
          
      case createCOMPANY_QSA = "CREATE TABLE company_qsa(company_id int not null, qsa_id int not null, FOREIGN KEY (company_id) REFERENCES company(id), FOREIGN KEY (qsa_id) REFERENCES qsa(id));"
    
    case insertCompany0 = "INSERT INTO company values (0, 'status', 'ultima_atualizacao', 'cnpj', 'tipo', 'porte', 'nome', 'fantasia', 'abertura', 'natureza_juridica', 0, 'email', 'telefone', 'efr', 'situacao', 'data_situacao', 'motivo_situacao', 'situacao_especial', 'data_situacao_especial', 'capital_social')"
    case insertPerson0 = "INSERT INTO person VALUES (0, 0, 'Not a person', '00000000000', '00000000000', 'not@person.com' )"
    case insertAdress0 = "INSERT INTO adress VALUES (0, 'Rua', 'Numero', 'Complemento', 'CEP', 'Bairro', 'Cidade', 'Estado')"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}
