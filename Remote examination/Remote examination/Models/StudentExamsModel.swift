//
//  StudentExamsModel.swift
//  Remote examination
//
//  Created by Anna Abdeeva on 22.03.2022.
//

import Foundation

struct StudentExam: Codable {
    let id, semesterRating, examRating: Int
    let allowed: Bool
    let examPeriod: ExamPeriod
    let student: Student
}

// MARK: - ExamPeriod
struct ExamPeriod: Codable {
    let id: Int
    let start, end: String
    let exam: Exam
}

// MARK: - Exam
struct Exam: Codable {
    let id: Int
    let examRule: ExamRule
    let teacher: Teacher
    let discipline: Discipline
    let groups: [Group]
}

// MARK: - Discipline
struct Discipline: Codable {
    let id: Int
    let name: String
}

// MARK: - Group
struct Group: Codable {
    let id: Int
    let name: String
}

// MARK: - ExamRule
struct ExamRule: Codable {
    let id: Int
    let name: String
    let themes: [Theme]
    let discipline: Group
    let questionCount, exerciseCount, duration, minimalRating: Int
}

// MARK: - Theme
struct Theme: Codable {
    let id: Int
    let name: String
    let discipline: Group
}

// MARK: - Teacher
struct Teacher: Codable {
    let id: Int
    let account: Account
}

// MARK: - Account
struct Account: Codable {
    let id: Int
    let username, name, surname: String
    let roles: [String]
}

// MARK: - Student
struct Student: Codable {
    let id: Int
    let account: Account
    let group: Group
}

enum StudentAPIError: Error {
    case a
    case b
    case c
}

struct LoginResponse: Codable {
    let token: String
    let roles: String
}
