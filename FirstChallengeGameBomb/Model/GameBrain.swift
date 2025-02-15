//
//  GameBrain.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import Foundation
import Settings

struct GameBrain {
    
    @UserDefault(key: "selectedCategories", defaultValue: [])
    private var selectedCategories: [String]
    
    @UserDefault(key: "сompletedQuestions", defaultValue: [])
    private var сompletedQuestions: [String]
    
    let questions = [
        
        // О разном
        Question(text: "Назовите популярный праздник", category: "О Разном"),
        Question(text: "Назовите что-то, что можно найти в кармане", category: "О Разном"),
        Question(text: "Назовите предмет, который есть в каждом доме", category: "О Разном"),
        Question(text: "Назовите известную настольную игру", category: "О Разном"),
        Question(text: "Назовите что-то, что люди часто теряют", category: "О Разном"),
        Question(text: "Назовите популярный напиток", category: "О Разном"),
        Question(text: "Назовите что-то, что можно увидеть в парке", category: "О Разном"),
        Question(text: "Назовите один из символов удачи", category: "О Разном"),
        Question(text: "Назовите вещь, которую люди берут с собой в путешествие", category: "О Разном"),
        Question(text: "Назовите что-то, что люди покупают каждую неделю", category: "О Разном"),
        Question(text: "Назовите то, что можно увидеть на кухне", category: "О Разном"),
        Question(text: "Назовите что-то, что часто бывает в кошельке", category: "О Разном"),
        Question(text: "Назовите вещь, без которой трудно представить утро", category: "О Разном"),
        Question(text: "Назовите способ, которым люди передвигаются по городу", category: "О Разном"),
        Question(text: "Назовите что-то, что используют для измерения времени", category: "О Разном"),

        // Спорт и Хобби
        Question(text: "Назовите популярный вид спорта", category: "Спорт и Хобби"),
        Question(text: "Назовите предмет, который нужен для игры в теннис", category: "Спорт и Хобби"),
        Question(text: "Назовите вид единоборств", category: "Спорт и Хобби"),
        Question(text: "Назовите что-то, что можно коллекционировать", category: "Спорт и Хобби"),
        Question(text: "Назовите знаменитого спортсмена", category: "Спорт и Хобби"),
        Question(text: "Назовите популярную командную игру", category: "Спорт и Хобби"),
        Question(text: "Назовите хобби, связанное с музыкой", category: "Спорт и Хобби"),
        Question(text: "Назовите вид спорта, где используют мяч", category: "Спорт и Хобби"),
        Question(text: "Назовите популярное водное развлечение", category: "Спорт и Хобби"),
        Question(text: "Назовите карточную игру", category: "Спорт и Хобби"),
        Question(text: "Назовите летний вид спорта", category: "Спорт и Хобби"),
        Question(text: "Назовите зимний вид спорта", category: "Спорт и Хобби"),
        Question(text: "Назовите что-то, что используют для рисования", category: "Спорт и Хобби"),
        Question(text: "Назовите вид спорта, который проводится на Олимпийских играх", category: "Спорт и Хобби"),
        Question(text: "Назовите знаменитый футбольный клуб", category: "Спорт и Хобби"),

        // Про жизнь
        Question(text: "Назовите место, где работают люди", category: "Про Жизнь"),
        Question(text: "Назовите что-то, что человек делает утром", category: "Про Жизнь"),
        Question(text: "Назовите популярную профессию", category: "Про Жизнь"),
        Question(text: "Назовите то, что покупают в супермаркете", category: "Про Жизнь"),
        Question(text: "Назовите транспорт, который используют каждый день", category: "Про Жизнь"),
        Question(text: "Назовите способ поздравить человека с праздником", category: "Про Жизнь"),
        Question(text: "Назовите место, куда люди любят ходить по выходным", category: "Про Жизнь"),
        Question(text: "Назовите предмет, который используют в офисе", category: "Про Жизнь"),
        Question(text: "Назовите популярное блюдо на ужин", category: "Про Жизнь"),
        Question(text: "Назовите что-то, что люди делают перед сном", category: "Про Жизнь"),
        Question(text: "Назовите город, в который люди хотят поехать в отпуск", category: "Про Жизнь"),
        Question(text: "Назовите что-то, что помогает людям проснуться утром", category: "Про Жизнь"),
        Question(text: "Назовите одно из домашних животных", category: "Про Жизнь"),
        Question(text: "Назовите популярное приложение для общения", category: "Про Жизнь"),
        Question(text: "Назовите что-то, что часто ломается в доме", category: "Про Жизнь"),

        // Знаменитости
        Question(text: "Назовите известного актёра", category: "Знаменитости"),
        Question(text: "Назовите певца или певицу", category: "Знаменитости"),
        Question(text: "Назовите знаменитого спортсмена", category: "Знаменитости"),
        Question(text: "Назовите мирового лидера прошлого или настоящего", category: "Знаменитости"),
        Question(text: "Назовите популярного блогера", category: "Знаменитости"),
        Question(text: "Назовите известного художника", category: "Знаменитости"),
        Question(text: "Назовите писателя, чьи книги стали бестселлерами", category: "Знаменитости"),
        Question(text: "Назовите героя популярного фильма", category: "Знаменитости"),
        Question(text: "Назовите известную женщину-актрису", category: "Знаменитости"),
        Question(text: "Назовите знаменитого учёного", category: "Знаменитости"),
        Question(text: "Назовите известную музыкальную группу", category: "Знаменитости"),
        Question(text: "Назовите ведущего известного телешоу", category: "Знаменитости"),
        Question(text: "Назовите спортсмена, который участвовал в Олимпийских играх", category: "Знаменитости"),
        Question(text: "Назовите режиссёра известного фильма", category: "Знаменитости"),
        Question(text: "Назовите знаменитого комика", category: "Знаменитости"),
        
        // Искусство и кино
        Question(text: "Назовите известный фильм", category: "Искусство и Кино"),
        Question(text: "Назовите популярного режиссёра", category: "Искусство и Кино"),
        Question(text: "Назовите известного художника", category: "Искусство и Кино"),
        Question(text: "Назовите жанр кинематографа", category: "Искусство и Кино"),
        Question(text: "Назовите известный музей", category: "Искусство и Кино"),
        Question(text: "Назовите известного актёра", category: "Искусство и Кино"),
        Question(text: "Назовите музыкальный инструмент", category: "Искусство и Кино"),
        Question(text: "Назовите известную театральную пьесу", category: "Искусство и Кино"),
        Question(text: "Назовите анимационный фильм", category: "Искусство и Кино"),
        Question(text: "Назовите произведение классической музыки", category: "Искусство и Кино"),
        Question(text: "Назовите жанр живописи", category: "Искусство и Кино"),
        Question(text: "Назовите известную кинопремию", category: "Искусство и Кино"),
        Question(text: "Назовите всемирно известную картину", category: "Искусство и Кино"),
        Question(text: "Назовите вид танца", category: "Искусство и Кино"),
        Question(text: "Назовите популярный сериал", category: "Искусство и Кино"),

        // Природа
        Question(text: "Назовите дикое животное", category: "Природа"),
        Question(text: "Назовите вид дерева", category: "Природа"),
        Question(text: "Назовите океан или море", category: "Природа"),
        Question(text: "Назовите птицу, которая умеет говорить", category: "Природа"),
        Question(text: "Назовите известное природное явление", category: "Природа"),
        Question(text: "Назовите цветок", category: "Природа"),
        Question(text: "Назовите национальный парк", category: "Природа"),
        Question(text: "Назовите вымирающий вид животных", category: "Природа"),
        Question(text: "Назовите вид насекомого", category: "Природа"),
        Question(text: "Назовите природную катастрофу", category: "Природа"),
        Question(text: "Назовите континент", category: "Природа"),
        Question(text: "Назовите реку", category: "Природа"),
        Question(text: "Назовите горный хребет", category: "Природа"),
        Question(text: "Назовите климатический пояс", category: "Природа"),
        Question(text: "Назовите животное, обитающее в Арктике", category: "Природа")
    ]
        
    mutating func getQuestionText() -> String {
        
        // Выбираем вопросы которые соотвествуют выбранным категориям
        let filterQuestions = questions.filter { question in
            selectedCategories.contains(where: { question.category.contains($0) })
        }
        
        // Из отфильтрованных вопросов удаляем те, что уже были
        var questionsWithoutRepetition = filterQuestions.filter { question in
            !сompletedQuestions.contains(question.text)
        }
        
        // Если уже все вопросы были, то чистим сохраненные и возвращаем весь список
        if questionsWithoutRepetition.isEmpty {
            questionsWithoutRepetition = filterQuestions
            сompletedQuestions.removeAll()
        }
            
        if filterQuestions.isEmpty {
            return ""
        } else {
            let question = questionsWithoutRepetition[Int.random(in: 0..<questionsWithoutRepetition.count)].text
            сompletedQuestions.append(question)
            return question
        }
    }
}
