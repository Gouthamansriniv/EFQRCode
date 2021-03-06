//
//  EFQRCode.swift
//  EFQRCode
//
//  Created by EyreFree on 2017/3/28.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

public class EFQRCode: NSObject {

    // MARK: - Recognizer
    #if !os(watchOS)
    public static func recognize(image: CGImage) -> [String]? {
        return EFQRCodeRecognizer(image: image).recognize()
    }
    #endif

    // MARK: - Generator
    #if !os(watchOS)
    public static func generate(
        content: String,
        size: EFIntSize = EFIntSize(width: 600, height: 600),
        backgroundColor: CIColor,
        foregroundColor: CIColor,
        watermark: CGImage? = nil
        ) -> CGImage? {
        return generate(content: content, size: size, backgroundColor: backgroundColor.toCGColor() ?? CGColor.EFWhite(), foregroundColor: foregroundColor.toCGColor() ?? CGColor.EFBlack(), watermark: watermark)
    }
    #endif

    #if os(macOS)
    public static func generate(
        content: String,
        size: EFIntSize = EFIntSize(width: 600, height: 600),
        backgroundColor: NSColor,
        foregroundColor: NSColor,
        watermark: CGImage? = nil
        ) -> CGImage? {
        return generate(content: content, size: size, backgroundColor: backgroundColor.toCGColor(), foregroundColor: foregroundColor.toCGColor(), watermark: watermark)
    }
    #else
    public static func generate(
    content: String,
    size: EFIntSize = EFIntSize(width: 600, height: 600),
    backgroundColor: UIColor,
    foregroundColor: UIColor,
    watermark: CGImage? = nil
    ) -> CGImage? {
    return generate(content: content, size: size, backgroundColor: backgroundColor.toCGColor(), foregroundColor: foregroundColor.toCGColor(), watermark: watermark)
    }
    #endif

    public static func generate(
        content: String,
        size: EFIntSize = EFIntSize(width: 600, height: 600),
        backgroundColor: CGColor = CGColor.EFWhite(),
        foregroundColor: CGColor = CGColor.EFBlack(),
        watermark: CGImage? = nil
        ) -> CGImage? {

        let generator = EFQRCodeGenerator(
            content: content,
            size: size
        )
        generator.setWatermark(watermark: watermark)
        generator.setColors(backgroundColor: backgroundColor, foregroundColor: foregroundColor)
        return generator.generate()
    }
}
