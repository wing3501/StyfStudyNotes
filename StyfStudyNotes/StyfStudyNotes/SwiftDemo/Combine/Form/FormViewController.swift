//
//  FormViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/14.
//

import UIKit
import Combine

class FormViewController: UIViewController {
    lazy var value1_input: UITextField = {
        var v = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        v.backgroundColor = .yellow
        v.addTarget(self, action: #selector(value1InputChanged), for: .editingChanged)
        return v
    }()
    
    lazy var value2_input: UITextField = {
        var v = UITextField(frame: CGRect(x: 50, y: 160, width: 200, height: 50))
        v.backgroundColor = .yellow
        v.addTarget(self, action: #selector(value2InputChanged), for: .editingChanged)
        return v
    }()
    lazy var value2_repeat_input: UITextField = {
        var v = UITextField(frame: CGRect(x: 50, y: 220, width: 200, height: 50))
        v.backgroundColor = .yellow
        v.addTarget(self, action: #selector(value2RepeatInputChanged), for: .editingChanged)
        return v
    }()
    
    lazy var submission_button: UIButton = {
        var v = UIButton(type: .custom)
        v.backgroundColor = .green
        v.setTitle("提交", for: .normal)
        v.frame = CGRect(x: 50, y: 280, width: 200, height: 50)
        v.addTarget(self, action: #selector(submissionButtonClick), for: .touchUpInside)
        return v
    }()
    lazy var value1_message_label: UILabel = {
        var v = UILabel(frame: CGRect(x: 50, y: 340, width: 300, height: 50))
        v.textColor = .black
        v.backgroundColor = .orange
        return v
    }()
    lazy var value2_message_label: UILabel = {
        var v = UILabel(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
        v.textColor = .black
        v.backgroundColor = .orange
        return v
    }()
    
    @objc func value1InputChanged(_ sender: UITextField) {
        value1 = sender.text ?? ""
    }
    @objc func value2InputChanged(_ sender: UITextField) {
        value2 = sender.text ?? ""
    }
    @objc func value2RepeatInputChanged(_ sender: UITextField) {
        value2_repeat = sender.text ?? ""
    }
    @objc func submissionButtonClick(_ sender: UIButton) {
        print("提交了-------")
    }
    
    @Published var value1: String = ""
    @Published var value2: String = ""
    @Published var value2_repeat: String = ""
    
    var validatedValue1: AnyPublisher<String?, Never> {
        return $value1.map { value1 in
            guard value1.count > 2 else {
                DispatchQueue.main.async {
                    self.value1_message_label.text = "minimum of 3 characters required"
                }
                return nil
            }
            DispatchQueue.main.async {
                self.value1_message_label.text = ""
            }
            return value1
        }.eraseToAnyPublisher()
    }
    
    var validatedValue2: AnyPublisher<String?, Never> {
        //        combineLatest 用于从属性中获取不断发布的更新，并将它们合并到单个管道中
        return Publishers.CombineLatest($value2, $value2_repeat)
            .receive(on: RunLoop.main)
            .map { value2, value2_repeat in
                guard value2_repeat == value2, value2.count > 4 else {
                    self.value2_message_label.text = "values must match and have at least 5 characters"
                    return nil
                }
                self.value2_message_label.text = ""
                return value2
            }.eraseToAnyPublisher()
    }
    
    var readyToSubmit: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validatedValue2, validatedValue1)
            .map { value2, value1 in
                guard let realValue2 = value2, let realValue1 = value1 else {
                    return nil
                }
                return (realValue2, realValue1)
            }
            .eraseToAnyPublisher()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(value1_input)
        view.addSubview(value2_input)
        view.addSubview(value2_repeat_input)
        view.addSubview(submission_button)
        view.addSubview(value1_message_label)
        view.addSubview(value2_message_label)
        
        self.readyToSubmit
                    .map { $0 != nil }
                    .receive(on: RunLoop.main)
                    .assign(to: \.isEnabled, on: submission_button)
                    .store(in: &cancellableSet)
    }
}
