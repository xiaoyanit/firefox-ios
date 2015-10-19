/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

// TODO This should really use NSURLComponents to build up the query part. And not string ops.

class ReadingListFetchSpec {
    var queryString: String

    init(queryString: String) {
        self.queryString = queryString
    }

    func getURL(serviceURL serviceURL: NSURL) -> NSURL? {
        if let components = NSURLComponents(URL: serviceURL, resolvingAgainstBaseURL: true) {
            components.query = queryString
            return components.URL
        }
        return nil
    }

    func getURL(serviceURL serviceURL: NSURL, path: String) -> NSURL? {
        if let components = NSURLComponents(URL: serviceURL, resolvingAgainstBaseURL: true) {
            components.path = path
            components.query = queryString
            return components.URL
        }
        return nil
    }

    // This should really generate a dictionary of values that we can pass to NSURLComponents instead of building the query string by hand

    class Builder {
        var buffer = ""
        var first = true

        func build() -> ReadingListFetchSpec {
            return ReadingListFetchSpec(queryString: buffer)
        }

        private func ampersand() {
            if first {
                first = false
                return
            }
            buffer += "&"
        }

        func setUnread(unread: Bool) -> Builder {
            ampersand()
            buffer += "unread="
            buffer += unread ? "true" : "false"
            return self
        }

        func setStatus(status: String, not: Bool) -> Builder {
            ampersand()
            if not {
                buffer += "not_"
            }
            buffer += "status="
            buffer += status
            return self
        }

        private func qualifyAttribute(attribute: String, withQualifier qualifier: String, value: String) -> Builder {
            ampersand()
            buffer += qualifier
            buffer += attribute
            buffer += "="
            buffer += value
            return self
        }

        func setMinAttribute(attribute: String, value: String) -> Builder {
            qualifyAttribute(attribute, withQualifier: "min_", value: value)
            return self
        }

        func setMaxAttribute(attribute: String, value: String) -> Builder {
            qualifyAttribute(attribute, withQualifier: "max_", value: value)
            return self
        }
    }
}