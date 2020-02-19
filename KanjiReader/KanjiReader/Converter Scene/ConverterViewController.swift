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

class ConverterViewController: UIViewController, ViperView {
    
    typealias PresenterType = ConverterPresenter
    var presenter: ConverterPresenter?
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var showHistoryButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if inputTextView.text.isEmpty {
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
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        showHistoryButton.addTarget(self, action: #selector(routeToHistory), for: .touchUpInside)
    }
    
    // MARK: - udpate views according to the status
    
    func updateView(status: ConverterStatus, ouputTextViewText: String? = nil) {
        DispatchQueue.main.async {
            switch status {
            case .noInput:
                self.outputTextView.setIsHiddenWithAnimation(to: true)
                self.retryButton.setIsHiddenWithAnimation(to: true)
                self.saveButton.setIsHiddenWithAnimation(to: true)
            case .history:
                self.outputTextView.setIsHiddenWithAnimation(to: false)
                self.retryButton.setIsHiddenWithAnimation(to: true)
                self.saveButton.setIsHiddenWithAnimation(to: false)
            case .loading:
                self.outputTextView.setIsHiddenWithAnimation(to: false)
                self.outputTextView.text = ouputTextViewText
            case .success:
                self.outputTextView.setIsHiddenWithAnimation(to: false)
                self.outputTextView.text = ouputTextViewText
                self.retryButton.setIsHiddenWithAnimation(to: true)
                self.saveButton.setIsHiddenWithAnimation(to: false)
            case .error:
                self.outputTextView.setIsHiddenWithAnimation(to: false)
                self.outputTextView.text = ouputTextViewText
                self.retryButton.setIsHiddenWithAnimation(to: false)
                self.saveButton.setIsHiddenWithAnimation(to: true)
            }
        }
    }
    
    func updateView(with history: History) {
        segmentedControl.selectedSegmentIndex = OutputType(rawValue: history.outputType) == .hiragana ? 0 : 1
        inputTextView.text = history.sentence
        outputTextView.text = history.converted
        updateView(status: .history)
    }
    
    // MARK: - actions
    
    @objc func finishEditing() {
        view.endEditing(true)
    }
    
    @objc func routeToHistory() {
        finishEditing()
        presenter?.router?.routeToHistory()
    }
    
    // MARK: - API calls
    
    @objc func tappedSaveButton() {
        presenter?.addHistory(outputType: selectedOutputType,
                              sentence: inputTextView.text,
                              converted: outputTextView.text)
    }
    
    @objc func convertInput() {
        presenter?.convert(input: inputTextView.text,
                           outputType: selectedOutputType)
    }
}

// MARK: - UITextViewDelegate

extension ConverterViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        convertInput()
    }
}
