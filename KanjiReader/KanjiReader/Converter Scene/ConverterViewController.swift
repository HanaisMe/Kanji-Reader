//
//  ConverterViewController.swift
//  KanjiReader
//
//  Created by Jeongsik Lee on 2020/02/19.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

enum ConverterStatus {
    case noInput
    case loading
    case history
    case success
    case error
}

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
            updateView(status: .history)
        } else {
            updateView(status: .noInput)
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
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        showHistoryButton.addTarget(self, action: #selector(transferToHistory), for: .touchUpInside)
    }
    
    // MARK: - udpate views according to the status
    
    private func updateView(status: ConverterStatus, ouputTextViewText: String? = nil) {
        switch status {
        case .noInput:
            inputTextView.becomeFirstResponder()
            outputTextView.setIsHiddenWithAnimation(to: true)
            retryButton.setIsHiddenWithAnimation(to: true)
            saveButton.setIsHiddenWithAnimation(to: true)
            scrollViewfooterHeight.constant = 0
        case .history:
            outputTextView.setIsHiddenWithAnimation(to: false)
            retryButton.setIsHiddenWithAnimation(to: true)
            saveButton.setIsHiddenWithAnimation(to: false)
            scrollViewfooterHeight.constant = 100
        case .loading:
            outputTextView.setIsHiddenWithAnimation(to: false)
            outputTextView.text = ouputTextViewText
        case .success:
            outputTextView.setIsHiddenWithAnimation(to: false)
            outputTextView.text = ouputTextViewText
            retryButton.setIsHiddenWithAnimation(to: true)
            saveButton.setIsHiddenWithAnimation(to: false)
            scrollViewfooterHeight.constant = 100
        case .error:
            outputTextView.setIsHiddenWithAnimation(to: false)
            outputTextView.text = ouputTextViewText
            retryButton.setIsHiddenWithAnimation(to: false)
            saveButton.setIsHiddenWithAnimation(to: true)
            scrollViewfooterHeight.constant = 0
        }
    }
    
    // MARK: - actions
    
    @objc func finishEditing() {
        view.endEditing(true)
    }
    
    @objc func transferToHistory() {
        finishEditing()
        let historyVC = Builder.buildHistoryScene()
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    // MARK: - API calls
    
    @objc func tappedSaveButton() {
        Worker.shared.addHistory(outputType: selectedOutputType,
                                 sentence: inputTextView.text,
                                 converted: outputTextView.text,
                                 success: { // TODO: - handle success
            print("success!")
        }, failure: { (errorMessage) in // TODO: - handle failure
            print(errorMessage)
        })
    }
    
    @objc func convertInput() {
        guard let input = inputTextView.text, !input.isEmpty else {
            updateView(status: .noInput)
            return
        }
        updateView(status: .loading, ouputTextViewText: "Loading...")

        Worker.shared.getRubyCharacters(sentence: input,
                                        outputType: selectedOutputType,
                                        success: { [weak self] (result) in
            DispatchQueue.main.async {
                self?.updateView(status: .success, ouputTextViewText: result)
            }
        }, failure: { [weak self] (errorMessage) in
            DispatchQueue.main.async {
                self?.updateView(status: .error, ouputTextViewText: errorMessage)
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
