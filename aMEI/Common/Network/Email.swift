//
//  Mail.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import MessageUI


class Email: UIViewController, MFMailComposeViewControllerDelegate {
    
    func sendEmail(subject: String, body: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(["2022954160@teiacoltec.org"])
            mailComposeViewController.setSubject(subject)
            mailComposeViewController.setMessageBody(body, isHTML: false)
            
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            // Device is not configured for sending emails
            // Handle this scenario accordingly
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Email composition cancelled")
        case .saved:
            print("Email saved as a draft")
        case .sent:
            print("Email sent successfully")
        case .failed:
            print("Failed to send email: \(error?.localizedDescription ?? "")")
        @unknown default:
            break
        }
    }

    
}
