internal struct Footnote: Fragment {
    var modifierTarget: Modifier.Target { .footnotes }

    var target: Target
    var text: FormattedText

    static func read(using reader: inout Reader) throws -> Footnote {
        try reader.read("[")
        try reader.read("^")
        let text = FormattedText.read(using: &reader, terminators: ["]"])
        try reader.read("]")

        let textStr = text.plainText()
        let reference = textStr[text.plainText().startIndex...]
        return Footnote(target: .reference(reference), text: text)
    }

    func html(usingURLs urls: NamedURLCollection,
              modifiers: ModifierCollection) -> String {
        let url = target.url(from: urls)
        let title = text.html(usingURLs: urls, modifiers: modifiers)
        return "<a id=\"fnref_\(url)\" class=\"fnref\" href=\"#fn_\(url)\">\(title)</a>"
    }

    func plainText() -> String {
        text.plainText()
    }
}

extension Footnote {
    enum Target {
        case reference(Substring)
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
