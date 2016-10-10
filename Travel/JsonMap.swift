//
//  JsonMap.swift
//  Travel
//
//  Created by Elight on 6/2/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation
public class JsonMap {
    var name: String!
    var areas: [Areas]!
    init(name: String, areas: [Areas]){
        self.name = name
        self.areas = areas
    }
    init(){
        
    }
}

public class Areas {
    var name: String
    var audio: String
    var blocks: [Blocks]
    init(name: String, audio: String, blocks: [Blocks]){
        self.name = name
        self.audio = audio
        self.blocks = blocks
    }
}

public class Blocks {
    var picture: String
    var paragraph: [Paragraph]
    init(picture: String, paragraphs: [Paragraph]){
        self.picture = picture
        self.paragraph = paragraphs
    }
}

public class Paragraph {
    var text: String
    var start: Int
    init(text: String, start: Int){
        self.text = text
        self.start = start
    }
}