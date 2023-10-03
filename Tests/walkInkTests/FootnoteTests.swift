import XCTest
import walkInk

final class FootnoteTests: XCTestCase {
    func testFootnotes() {
        let html = MarkdownParser().html(from: """
        Here is some text containing a footnote.[^somesamplefootnote]

        [^somesamplefootnote]: Here is the text of the footnote itself.
        """)
        XCTAssertEqual(html, "<p>Here is some text containing a footnote.<a id=\"fnref_somesamplefootnote\" class=\"fnref\" href=\"#fn_somesamplefootnote\">somesamplefootnote</a></p>")
    }
}

extension FootnoteTests {
    static var allTests: Linux.TestList<FootnoteTests> {
        return [
            ("testFootnotes", testFootnotes),

        ]
    }
}
