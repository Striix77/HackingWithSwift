//
//  GameError.swift
//  WordScramble
//
//  Created by Freak on 30.03.2026.
//
import Foundation

enum GameError: Error {
    case fileNotFound, decodingFailed, emptyFile
}
