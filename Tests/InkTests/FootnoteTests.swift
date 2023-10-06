import XCTest
import Ink

final class FootnoteTests: XCTestCase {
    func testFootnotes() {
        let html = MarkdownParser().html(from: """
        Here is some text containing a footnote.[^some sample footnote]
        """)
        XCTAssertEqual(html, "<p>Here is some text containing a footnote.<sup id=\"fnref_some_sample_footnote\" class=\"fnref\"><a href=\"#fn_some_sample_footnote\">some sample footnote</a></sup></p>")
    }
}

extension FootnoteTests {
    static var allTests: Linux.TestList<FootnoteTests> {
        return [
            ("testFootnotes", testFootnotes)
        ]
    }
}
