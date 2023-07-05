//
//  FAQ.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation

struct FAQ{
    let id: Int
    let question: String
    let answer: String
}



class FAQInsert{
    
    static func insertFAQ() -> [String]{
        
        var query: [String] = []
        
        var question = "Quais os beneficios de ser um MEI?"
        var answer = """
Se formalizar como MEI traz para o micro empreendedor as seguintes vantagens:
1- Ter um CNPJ;
2- Isenção de taxas para registro do MEI;
3- Pagamento de tributos com valores fixos mensais (INSS, ICMS e/ou ISS);
4- Inicio das atividades, sem prévio alvará ou licença;
5- Emissão de notas fiscais;
6- Maior poder de negociação com fornecedores, podendo obter descontos para pessoas jurídicas;
7- Acesso mais fácil a serviços financeiros, como conta bancaria jurídica, maquina de cartão, acesso ao credito, entre outros;
8-Vender e prestar serviços para outras empresas e até mesmo par ao governo.

"""
        var id = 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        question = "O que é o DAS?"
        answer = """
O DAS é o Documento de Arrecadação do Simples Nacional, ou seja, é como você, micro empreendedor individual vai recolher os impostos. Nele está incluso a contribuição previdenciário do empresario, como contribuinte individual, essa contribuição é o valor do salário mínimo do ano vigente, R$1,00 de ICMS, caso seja contribuinte desse imposto e R$5,00 de ISS, caso seja contribuinte desse imposto.
Para o MEI, os valores variam da seguinte forma:
R$ 66,10 para Comercio ou Industria;
R$ 70,10 para Prestação de Serviços e
R$ 71,10 para Comercio e Serviços juntos.
O pagamento pode ser feito por meio de debito automático, online ou emissão da DAS. Dei ser pago todo dia 20.
Para emitir o documento entre no link abaixo e clique no PGDAS no canto direito da tela:

https://www8.receita.fazenda.gov.br/SimplesNacional/

Certifique-se de ter seu código de acesso e seu certificado digital em dia.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        question = "Tenho DAS em atraso. O que faço?"
        answer = """
Relaxa, é possível parcelar estes valores!
Sim!
Você pode parcelar os débitos como MEI, desde que já tenha enviado a Declaração Anual de Faturamento (DASN) referente aos anos em atraso.
A solicitação pode ser feita pela internet, a qualquer momento, e você pode dividir o total dos débitos em até 60 vezes, desde que o valor gere pelo menos duas parcelas de, no mínimo, R$ 50,00.
Fique de olho!
Para manter o parcelamento ativo é preciso manter as guias em dia e não deixar atrasar mais de 3 parcelas, sejam elas consecutivas ou não.
Agora clique no link abaixo e, no serviço Parcelamento - Microempreendedor Individual, clique na chave em “Código de Acesso” para solicitar seu parcelamento.


https://www.gov.br/empresas-e-negocios/pt-br/empreendedor/servicos-para-mei/pagamento-de-contribuicao-mensal/parcelamento-1

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        
        question = "Paguei valor a maior no DAS. O que fazer?"
        answer = """
Fique tranquilo, é possível receber de volta o valor do INSS!
Sim!
Se você pagou o boleto duas vezes ou se pagou o boleto enquanto recebeu salário-maternidade, auxílio-doença ou auxílio-reclusão, você pode pedir o reembolso do que pagou a mais.
A restituição do valor pago como contribuição previdenciária (INSS) é solicitada pela internet e, caso seja liberada, será paga diretamente em sua conta bancária, se não houver débitos existentes.

Para solicitar o reembolso clique no botão ao lado e, no serviço Pedido Eletrônico de Restituição, clique na chave em “Código de Acesso”.
Já o reembolso dos valores de ICMS e/ou ISS deve ser pedido diretamente no seu estado e/ou município.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        question = "Benefícios do INSS com o pagamento do DAS"
        answer = """
Para aproveitar os benefícios, é obrigatório pagar as guias mensais (DAS) até a data do vencimento  e cumprir o número mínimo de contribuições(carência INSS).
 
Para você:
Aposentadoria por idade
Aposentadoria por invalidez
Auxílio-doença
Salário-maternidade
 Para a sua família:
Auxílio-reclusão
Pensão por morte

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        question = "Quais os tipos de Nota Fiscal um MEI pode emitir?"
        answer = """
Um dos grandes benefícios ao se formalizar como MEI é poder emitir nota fiscal (NF) e acessar novos mercados, vendendo para empresas e até mesmo órgãos públicos. Os tipos de nota fiscal variam de acordo com a ocupação que você exerce, entenda a diferença entre as notas fiscais: NF-e e  NFS-e.
A principal diferença está na função de cada modelo. A NF-e tem a função de registrar a venda de produtos, já a NFS-e tem a função de registrar a prestação de serviços. Vamos a um exemplo: uma loja de informática, quando são vendidas as peças, acessórios e computadores deve ser emitida uma NF-e. No caso de manutenção, consertos ou ajustes deve ser emitida uma NFS-e.
Portanto se sua empresa, vende produtos, deve emitir NF-e, se presta serviços deve emitir NFS-e, e faz os dois poderá emitir as duas.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        question = "MEI é obrigado a emitir Nota Fiscal?"
        answer = """
Em regra não.Além de ser um benefício, você pode ter a obrigação de emitir esse documento em alguns casos:
Sempre que vender ou prestar serviços para outras pessoas jurídicas (empresas ou governo), independentemente do tamanho delas;
Quando seus clientes (pessoa física) solicitarem, de acordo com o Código de Defesa do Consumidor;
Sempre que você precisar enviar seu produto para o cliente, independente se for empresa ou pessoa física, como por exemplo venda pela internet, telefone ou catálogo.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        question = "MEI pode comprar sem Nota Fiscal?"
        answer = """
Não, toda vez que você compra qualquer produto para a sua atividade como MEI é preciso solicitar a emissão da nota fiscal.
Toda empresa é obrigada e emitir nota fiscal. Se você comprou de um outro MEI, ele também é obrigado a emitir nota fiscal para você.
Lembra que o MEI é obrigado a emitir nota fiscal sempre que vende para outro CNPJ.
Guarde todas as notas fiscais dos produtos comprados ou serviços contratados e anexe junto ao relatório mensal .
Além de ser uma obrigação legal, guardar as notas fiscais de compra e venda também é uma forma de controle financeiro da sua empresa, fundamental para o sucesso do seu negócio!

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        question = "É obrigatório preencher o Relatório Mensal de Receitas Brutas?"
        answer = """
O Relatório Mensal de Receitas Brutas é uma obrigação prevista em lei, que você passa a ter após a formalização.
Apesar de não precisar ser entregue em nenhum órgão, ele deve ser preenchido até o dia 20 do mês seguinte às vendas ou prestações de serviços. Ele deve ser arquivado, junto com as Notas fiscais de compras e vendas, por um período mínimo de 5 anos.

Este relatório, além de te ajudar a controlar a média de faturamento mensal, também facilitará o envio da sua Declaração Anual de Faturamento (DASN), pois ela é o somatório de todos os relatórios preenchidos durante o ano.
Se a sua ocupação for de ‘Comércio’ preencha os campos indicados como revenda de mercadorias.
Caso a sua ocupação seja de ‘Indústria’ preencha os campos indicados como venda dos produtos industrializados.

Se a ocupação for de ‘Prestação de Serviços em geral ou Serviço de transporte municipal’ preencha os campos indicados como prestações de serviço.
Se a ocupação for de ‘Serviço de transporte intermunicipal ou interestadual’ escolha o campo de venda ou revenda de mercadorias.
Este relatório está presente na guia da Contabilidade do app.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        
        
        question = "O que é DASN - SIMEI?"
        answer = """
A DASN SIMEI é a Declaração Anual do Simples Nacional, exclusiva e obrigatória para o Microempreendedor Individual – MEI, na qual constam dados do faturamento da empresa. Para preencher a declaração, o MEI deve reunir todas as notas emitidas e comprovantes de pagamento do imposto mensal obrigatório.
O preenchimento dessa declaração pode ser realizado pelo site da Receita Federal ou pelo aplicativo MEI, disponível para Android ou IOS. Mesmo se não tiver rendimentos no ano, o MEI deve enviar a declaração com o valor zerado, para não constar pendência na Receita Federal.
Todos os anos, de 1º de janeiro até 31 de maio, o MEI deve entregar a declaração referente aos dados do ano anterior, no ano vigente. Ou seja, este ano ele terá que informar os dados dos 12 meses do ano passado, até a data referida.
Caso a DASN SIMEI seja entregue depois do dia 31 de maio, o MEI terá que pagar multas e juros para regularizar sua situação na Receita Federal. O não envio da declaração pode resultar em entraves de acesso a crédito e serviços financeiros exclusivos para o MEI.

"""
        id += 1
        query.append("INSERT INTO faq VALUES( \(id), '\(question)', '\(answer)' )")
        
        return query
    }
    
    
    
    
}
