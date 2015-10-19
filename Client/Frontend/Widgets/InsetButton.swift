/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */


/**
 * Button whose insets are included in its intrinsic size.
 */
class InsetButton: UIButton {
    override func intrinsicContentSize() -> CGSize {
        let size = super.intrinsicContentSize()
        return CGSizeMake(size.width + titleEdgeInsets.left + titleEdgeInsets.right,
            size.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
    }
}