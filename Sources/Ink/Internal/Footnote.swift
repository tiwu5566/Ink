internal struct Footnote: Fragment {
    var modifierTarget: Modifier.Target { .footnotes }

    var target: Target
    var text: FormattedText
    var style: Style

    static func read(using reader: inout Reader) throws -> Footnote {
        try reader.read("[")
        try reader.read("^")
        let text = FormattedText.read(using: &reader, terminators: ["]"])
        try reader.read("]")

        let textStr = text.plainText()
        let reference = textStr[text.plainText().startIndex...]
        return Footnote(target: .reference(reference), text: text, style: .superscript)
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {
        let url = String(target.url(from: urls))
        let safeUrl = url.replacingOccurrences(of: " ", with: "_")
        
        if style == .inline {
            return "<a href=\"#fn_\(safeUrl)\"><span id=\"fnref_\(safeUrl)\" class=\"fnref\">\(url)</span></a>"
        } else {
            return "<a href=\"#fn_\(safeUrl)\"><sup id=\"fnref_\(safeUrl)\" class=\"fnref\">\(url)</sup></a>"
        }
    }

    func plainText() -> String {
        text.plainText()
    }
}

extension Footnote {
    enum Target {
        case reference(Substring)
    }
    
    enum Style {
        case inline
        case superscript
    }
}

extension Footnote.Target {
    func url(from urls: NamedURLCollection) -> URL {
        switch self {
        case .reference(let name):
            return urls.url(named: name) ?? name
        }
    }
}
