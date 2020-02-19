//
//  ConverterViewController.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var showHistoryButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollViewfooterHeight: NSLayoutConstraint!
    
    let segmentedControl = UISegmentedControl()
    
    var selectedOutputType: OutputType {
        return segmentedControl.selectedSegmentIndex == 0 ? .hiragana : .katakana
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let input = inputTextView.text, !input.isEmpty {
            outputTextView.setIsHiddenWithAnimation(to: false)
            retryButton.setIsHiddenWithAnimation(to: true)
            saveButton.setIsHiddenWithAnimation(to: false)
            scrollViewfooterHeight.constant = 100
            return
        } else {
            inputTextView.becomeFirstResponder()
        }
    }
    
    // MARK: - setup views when the view is being loaded
    
    private func setupTitleView() {
        segmentedControl.insertSegment(withTitle: OutputType.hiragana.displayName, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: OutputType.katakana.displayName, at: 1, animated: true)
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(convertInput), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    private func setupContentView() {
        inputTextView.delegate = self
        inputTextView.addToolBar(title: "Done", target: self, selector: #selector(finishEditing))
        outputTextView.isHidden = true
        retryButton.isHidden = true
        saveButton.isHidden = true
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        showHistoryButton.addTarget(self, action: #selector(tappedShowHistoryButton), for: .touchUpInside)
        scrollViewfooterHeight.constant = 0
    }
    
    // MARK: - actions
    
    @objc func finishEditing() {
        view.endEditing(true)
    }
    
    @objc func tappedShowHistoryButton() {
        finishEditing()
    }
    
    @objc func tappedSaveButton() {
        Worker.shared.addHistory(outputType: selectedOutputType, sentence: inputTextView.text, converted: outputTextView.text, success: {
            print("success!")
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    // MARK: - API call
    
    @objc func convertInput() {
        guard let input = inputTextView.text, !input.isEmpty else {
            outputTextView.setIsHiddenWithAnimation(to: true)
            retryButton.setIsHiddenWithAnimation(to: true)
            saveButton.setIsHiddenWithAnimation(to: true)
            scrollViewfooterHeight.constant = 0
            return
        }
        outputTextView.setIsHiddenWithAnimation(to: false)
        outputTextView.text = "Loading..."

        Worker.shared.getRubyCharacters(sentence: input,
                                            outputType: selectedOutputType,
                                            success: { (result) in
            DispatchQueue.main.async {
                self.outputTextView.text = result
                self.retryButton.setIsHiddenWithAnimation(to: true)
                self.saveButton.setIsHiddenWithAnimation(to: false)
                self.scrollViewfooterHeight.constant = -100
            }
        }, failure: { (errorMessage) in
            DispatchQueue.main.async {
                self.outputTextView.text = errorMessage
                self.retryButton.setIsHiddenWithAnimation(to: false)
                self.saveButton.setIsHiddenWithAnimation(to: true)
                self.scrollViewfooterHeight.constant = 0
            }
        })
    }
}

// MARK: - UITextViewDelegate

extension ConverterViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        convertInput()
    }
}
