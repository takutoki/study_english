//
//  QuestionViewController.swift
//  study_english
//
//  Created by takumitokiwa on 2021/09/23.
//

import UIKit
import RxSwift
import RxCocoa

class QuestionViewController: UIViewController {

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var firstAnswerButton: AnswerButton!
    @IBOutlet weak var secondAnswerButton: AnswerButton!
    @IBOutlet weak var thirdAnswerButton: AnswerButton!
    
    private let viewModel: QuestionViewModelProtocol
    var answers: [SelectAnswer] = []
    
    let disposeBag = DisposeBag()
    
    init(inject: QuestionViewModelProtocol) {
        self.viewModel = inject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        bindInstructionLabel()
        bindAnswerText()
        tapAnswer()
    }

    private func viewInit() {
        instructionLabel.text = "単語の意味を答えなさい。"
        wordLabel.textAlignment = .center
        wordLabel.font =  UIFont.systemFont(ofSize: 50)
        wordLabel.textColor = .blue
    }
    
    private func bindInstructionLabel() {
        viewModel.questionStream
            .map{ $0.word }
            .bind(to: wordLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindAnswerText() {
        viewModel.answerStream
            .filter{ $0.count > 0 }
            .bind(to: answerBinder)
            .disposed(by: disposeBag)
    }
    
    private var answerBinder: Binder<[QuestionResponse.Answer]> {
        return Binder(self) { base, answers in
            base.answers = answers.map{ SelectAnswer($0) }
            base.firstAnswerButton.setTitle(answers[0].text, for: .normal)
            base.secondAnswerButton.setTitle(answers[1].text, for: .normal)
            base.thirdAnswerButton.setTitle(answers[2].text, for: .normal)
        }
    }
    
    private func tapAnswer() {
        firstAnswerButton.rx.tap.bind(to: firstTap).disposed(by: disposeBag)
        secondAnswerButton.rx.tap.bind(to: secondTap).disposed(by: disposeBag)
        thirdAnswerButton.rx.tap.bind(to: thirdTap).disposed(by: disposeBag)
    }
    
    private var firstTap: Binder<()> {
        return Binder(self) { base, _ in
            base.setAnswer(index: 0)
        }
    }

    private var secondTap: Binder<()> {
        return Binder(self) { base, _ in
            base.setAnswer(index: 1)
        }
    }

    private var thirdTap: Binder<()> {
        return Binder(self) { base, _ in
            base.setAnswer(index: 2)
        }
    }

    private func setAnswer(index: Int) {
        let answer = answers[index]
        let newAnswer = SelectAnswer(answer.text, answer.correct, true)
        answers[index] = newAnswer
        viewModel.select(value: answers)
        // present(QuestionViewController(inject: base.viewModel), animated: true) {}
    }
}
