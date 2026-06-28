//
//  Transactions+mock.swift
//  Trial
//
//  Created by Radek on 28.06.2026.
//  Copyright © 2026 BeeOne Gmbh. All rights reserved.
//

import Foundation
@testable import Trial

extension [Transaction] {
    static let mock: Self = [
        Trial.Transaction(
            id: "D3E0BD0330B14C01",
            title: "MA 10 Wiener Kindergaerten",
            subtitle: Optional(
                "MA 10 Wiener Kindergaerten/Wilma Ri"
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    "AT601200051428010635"
                ),
                bic: Optional(
                    "BKAUATWWXXX"
                ),
                number: nil,
                bankCode: nil,
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            senderName: Optional(
                "Stadt Wien"
            ),
            senderOriginator: Optional(
                "MA 10 Wiener Kindergaerten"
            ),
            senderReference: "002202296141",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    "AT552011182743536500"
                ),
                bic: Optional(
                    "GIBAATWWXXX"
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            receiverName: Optional(
                "Birgit Anna Mayer"
            ),
            receiverReference: "",
            creditorId: "AT03MAG00000009679",
            amount: Trial.Amount(
                value: -6535,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: -6535,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1518390000),
            valuationDate: Date(timeIntervalSince1970: 1518390000),
            importDate: Date(timeIntervalSince1970: 1518403980),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1518407555),
            reference: "1200018020810550037217259240",
            originatorSystem: "SD*/EZG",
            additionalTexts: Trial.AdditionalTexts(
                text1: "MA 10 Wiener Kindergaerten/Wilma Ri",
                text2: "MA 10 Wiener Kindergaerten",
                text3: "MDID:00206579811000001",
                lineItems: [
                    "MA 10 Wiener Kindergaerten/Wilma Ri",
                    "nner/Elternbeitraege Wiener Kinderg",
                    "aert/PDezember 2017 V121282892"
                ],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "DU-BK-DD",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: Optional(
                "DOMESTIC"
            ),
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: Optional(
                "Stadt Wien"
            ),
            partnerOriginator: Optional(
                "MA 10 Wiener Kindergaerten"
            ),
            partnerAddress: [
                "Neues Rathaus 1",
                "1080 Wien"
            ]
        ),
        Trial.Transaction(
            id: "D3DEE8FB792E7B01",
            title: "DM-FIL. 0609",
            subtitle: Optional(
                "Payment with card 1 on the 10. Feb. at 17:38."
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "40100101600"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            senderName: nil,
            senderOriginator: nil,
            senderReference: "",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            receiverName: nil,
            receiverReference: "",
            creditorId: "",
            amount: Trial.Amount(
                value: -1555,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: -1555,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1518390000),
            valuationDate: Date(timeIntervalSince1970: 1518217200),
            importDate: Date(timeIntervalSince1970: 1518277125),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1518277119),
            reference: "201111802102ALB-00H47LKMPT8W",
            originatorSystem: "EPA/LPO",
            additionalTexts: Trial.AdditionalTexts(
                text1: "DM-FIL. 0609 0609W K1   10.02. 17:38",
                text2: "",
                text3: "",
                lineItems: [],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "POS",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: nil,
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: nil,
            partnerOriginator: nil,
            partnerAddress: []
        ),
        Trial.Transaction(
            id: "D3DEA17BAC954E01",
            title: "HOFER DANKT",
            subtitle: Optional(
                "Payment with card 2 on the 10. Feb. at 12:18."
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "40100101600"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            senderName: nil,
            senderOriginator: nil,
            senderReference: "",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            receiverName: nil,
            receiverReference: "",
            creditorId: "",
            amount: Trial.Amount(
                value: -1592,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: -1592,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1518390000),
            valuationDate: Date(timeIntervalSince1970: 1518217200),
            importDate: Date(timeIntervalSince1970: 1518258527),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1518257926),
            reference: "201111802102ALB-00BZWTDI33BK",
            originatorSystem: "EPA/LPO",
            additionalTexts: Trial.AdditionalTexts(
                text1: "HOFER DANKT  0586  K2   10.02. 12:18",
                text2: "",
                text3: "",
                lineItems: [],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "POS",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: nil,
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: nil,
            partnerOriginator: nil,
            partnerAddress: []
        ),
        Trial.Transaction(
            id: "D3DE8D5F1CCB4D61",
            title: "SPAR DANKT 4249 WIEN",
            subtitle: Optional(
                "Payment with card 2 on the 9. Feb. at 15:18."
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "40100101600"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            senderName: nil,
            senderOriginator: nil,
            senderReference: "",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    ""
                ),
                bic: Optional(
                    ""
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    ""
                )
            ),
            receiverName: nil,
            receiverReference: "",
            creditorId: "",
            amount: Trial.Amount(
                value: -1809,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: -1809,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1518390000),
            valuationDate: Date(timeIntervalSince1970: 1518130800),
            importDate: Date(timeIntervalSince1970: 1518252549),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1518252528),
            reference: "201111802102ALB-00ABNMM8WHXC",
            originatorSystem: "EPA/LPO",
            additionalTexts: Trial.AdditionalTexts(
                text1: "POS          18,09 AT  K2   09.02. 15:18",
                text2: "SPAR DANKT 4249 WIEN 1090 040",
                text3: "",
                lineItems: [],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "POS",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: nil,
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: nil,
            partnerOriginator: nil,
            partnerAddress: []
        ),
        Trial.Transaction(
            id: "D3D8F78368E31201",
            title: "Birgit Mayer",
            subtitle: Optional(
                "Miete Februar"
            ),
            sender: Trial.AccountNumber(
                iban: Optional(
                    "AT841420020010764360"
                ),
                bic: Optional(
                    "EASYATW1XXX"
                ),
                number: Optional(
                    "20010764360"
                ),
                bankCode: Optional(
                    "14200"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            senderName: Optional(
                "Birgit Mayer"
            ),
            senderOriginator: nil,
            senderReference: "",
            senderBankReference: nil,
            receiver: Trial.AccountNumber(
                iban: Optional(
                    "AT552011182743536500"
                ),
                bic: Optional(
                    "GIBAATWWXXX"
                ),
                number: Optional(
                    "82743536500"
                ),
                bankCode: Optional(
                    "20111"
                ),
                prefix: Optional(
                    ""
                ),
                countryCode: Optional(
                    "AT"
                )
            ),
            receiverName: Optional(
                "Stefan Rinner, Birgit Mayer"
            ),
            receiverReference: "Miete Februar",
            creditorId: "",
            amount: Trial.Amount(
                value: 43500,
                precision: 2,
                currency: "EUR"
            ),
            amountSender: Trial.Amount(
                value: 43500,
                precision: 2,
                currency: "EUR"
            ),
            bookingDate: Date(timeIntervalSince1970: 1517871600),
            valuationDate: Date(timeIntervalSince1970: 1517871600),
            importDate: Date(timeIntervalSince1970: 1517872791),
            dueDate: nil,
            exchangeDate: nil,
            insertTimestamp: Date(timeIntervalSince1970: 1517875903),
            reference: "142001802052FE10000009926094",
            originatorSystem: "SD*/UEW",
            additionalTexts: Trial.AdditionalTexts(
                text1: "Miete Februar",
                text2: "Birgit Mayer",
                text3: "",
                lineItems: [],
                constantSymbol: nil,
                variableSymbol: nil,
                specificSymbol: nil
            ),
            note: nil,
            bookingType: "DU-BK-UEW",
            bookingTypeTranslation: nil,
            orderRole: "RECEIVER",
            orderCategory: Optional(
                "DOMESTIC"
            ),
            cardId: "0000000000000000",
            maskedCardNumber: "",
            invoiceId: nil,
            location: "",
            partnerName: Optional(
                "Birgit Mayer"
            ),
            partnerOriginator: nil,
            partnerAddress: []
        ),
    ]
}
