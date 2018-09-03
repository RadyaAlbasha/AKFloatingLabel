//
//  AKFloatingLabelTextView.swift
//  AKFloatingLabel
//
//  Created by Diogo Autilio on 04/07/17.
//  Copyright (c) 2017 Diogo Autilio. All rights reserved.
//

import UIKit

@IBDesignable open class AKFloatingLabelTextView: UITextView {

    public enum TextViewState: Int {
        case idle = 0
        case valid
        case invalid
    }

    /**
     * The placeholder string to be shown in the text view when no other text is present.
     */
    @IBInspectable public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            floatingLabel.text = placeholder
            if floatingLabelShouldLockToTop {
                floatingLabel.frame = CGRect(x: floatingLabel.frame.origin.x, y: floatingLabel.frame.origin.y, width: frame.size.width, height: floatingLabel.frame.size.height)
            }
            setNeedsLayout()
        }
    }

    /**
     * Indicates whether the floating label should lock to the top of the text view, or scroll away with text when the text
     * view is scrollable. By default, floating labels will lock to the top of the text view and their background color will
     * be set to the text view's background color
     * Note that this works best when floating labels have a non-clear background color.
     */
    @IBInspectable public var floatingLabelShouldLockToTop: Bool = true

    /**
     * Text color to be applied to the placeholder.
     * Defaults to `UIColor.lightGray.withAlphaComponent(0.65)`.
     */
    @IBInspectable public var placeholderTextColor: UIColor = UIColor.lightGray.withAlphaComponent(0.65) {
        didSet {
            self.placeholderLabel.textColor = self.placeholderTextColor
        }
    }

    /**
     * Text color to be applied to the floating label while the text view is not a first responder.
     * Defaults to `UIColor.gray`.
     * Provided for the convenience of using as an appearance proxy.
     */
    @IBInspectable public var floatingLabelTextColor: UIColor = UIColor.gray

    /**
     * Text color to be applied to the invalid label.
     * Defaults to `UIColor.red`.
     */
    @IBInspectable public var invalidTextFieldColor: UIColor = UIColor.red

    /**
     * Text color to be applied to the invalid label.
     * Defaults to `UIColor.gray`.
     */
    @IBInspectable public var validTextFieldColor: UIColor = UIColor.gray

    /**
     * Indicates whether the floating label's appearance should be animated regardless of first responder status.
     * By default, animation only occurs if the text field is a first responder.
     */
    @IBInspectable public var animateEvenIfNotFirstResponder: Bool = false

    /**
     * Text color to be applied to the floating label while the text view is a first responder.
     * Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
     */
    @IBInspectable public var floatingLabelActiveTextColor: UIColor?

    /**
     * Padding to be applied to the y coordinate of the floating label upon presentation.
     */
    @IBInspectable public var floatingLabelYPadding: CGFloat = 0.0

    /**
     * Padding to be applied to the y coordinate of the placeholder.
     */
    @IBInspectable public var placeholderYPadding: CGFloat = 0.0

    /**
     * Padding to be applied to the x coordinate of the floating label upon presentation.
     */
    @IBInspectable public var floatingLabelXPadding: CGFloat = 0.0

    /**
     * Padding for bottomline in textView.
     * Defaults is 1.
     */
    @IBInspectable public var paddingForBottomLine: CGFloat = 1.0

    /**
     * Should add bottom border.
     * Defaults to true
     */
    @IBInspectable public var hasBottomBorder: Bool = true

    /**
     * Top value for textContainerInset
     * Change this value if you need more padding between text input and floating label
     */
    public var startingTextContainerInsetTop: CGFloat = 0.0

    /**
     * Read-only access to the placeholder label.
     */
    public var placeholderLabel: UILabel = UILabel()

    /**
     * Read-only access to the floating label.
     */
    public var floatingLabel: UILabel = UILabel()

    /**
     * Read-only access to the floating error label.
     */
    public var floatingLabelError = UILabel()

    /**
     * Current textfield validation state.
     * Defaults to .idle
     */
    public var currentValidationState: TextViewState = .idle

    /**
     * Font to be applied to the floating label. Defaults to `UIFont.boldSystemFont(ofSize: 12.0)`.
     * Provided for the convenience of using as an appearance proxy.
     */
    public var floatingLabelFont: UIFont? = UIFont.boldSystemFont(ofSize: 12.0) {
        didSet {
            self.floatingLabel.font = (self.floatingLabelFont != nil) ? self.floatingLabelFont : self.defaultFloatingLabelFont()
            let placeholder = self.placeholder
            self.placeholder = placeholder // Force the label to lay itself out with the new font.
        }
    }

    /**
     * Duration of the animation when showing the floating label.
     * Defaults to 0.3 seconds.
     */
    public var floatingLabelShowAnimationDuration: TimeInterval = 0.3

    /**
     * Duration of the animation when hiding the floating label.
     * Defaults to 0.3 seconds.
     */
    public var floatingLabelHideAnimationDuration: TimeInterval = 0.3

    /**
     * Force floating label to be always visible
     * Defaults to false
     */
    public var alwaysShowFloatingLabel: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    private var bottomBorder: CALayer = CALayer()

    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

        // force setter to be called on a placeholder defined in a NIB/Storyboard
        if self.placeholder != nil {
            let placeholder = self.placeholder
            self.placeholder = placeholder
        }
    }

    func commonInit() {
        startingTextContainerInsetTop = textContainerInset.top
        textContainer.lineFragmentPadding = 0
        placeholderLabel = UILabel(frame: self.frame)
        if self.font == nil {
            // by default self.font may be nil - so make UITextView use UILabel's default
            font = placeholderLabel.font
        }
        placeholderLabel.font = font
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.lineBreakMode = .byWordWrapping
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.textColor = placeholderTextColor
        self.insertSubview(placeholderLabel, at: 0)

        floatingLabel.alpha = 0.0
        floatingLabel.backgroundColor = self.backgroundColor
        self.addSubview(floatingLabel)

        // some basic default fonts/colors
        floatingLabelFont = defaultFloatingLabelFont()
        floatingLabel.font = floatingLabelFont
        floatingLabel.textColor = floatingLabelTextColor

        floatingLabelError.text = ""
        floatingLabelError.font = self.defaultFloatingLabelFont()
        floatingLabelError.textColor = invalidTextFieldColor
        floatingLabelError.textAlignment = .left
        floatingLabelError.alpha = 1.0
        self.addSubview(floatingLabelError)

        self.layer.addSublayer(bottomBorder)

        NotificationCenter.default.addObserver(self, selector: #selector(self.layoutSubviews), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.layoutSubviews), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.layoutSubviews), name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidEndEditing, object: self)
    }

    func defaultFloatingLabelFont() -> UIFont? {
        var textViewFont: UIFont?

        if textViewFont == nil, placeholderLabel.attributedText != nil, let placeholder = placeholderLabel.attributedText, placeholder.length > 0 {
            textViewFont = placeholderLabel.attributedText?.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
        }
        if textViewFont == nil {
            textViewFont = placeholderLabel.font
        }

        guard let safeTextViewFont = textViewFont else {
            return nil
        }

        let fontSize = roundf(Float(safeTextViewFont.pointSize * 0.7))
        return UIFont(name: safeTextViewFont.fontName, size: CGFloat(fontSize))
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        adjustTextContainerInsetTop()
        setLabelErrorOriginForTextAlignment()
        setBorder()

        if let floatingLabelBounds = floatingLabel.superview?.bounds {
            let floatingLabelSize = floatingLabel.sizeThatFits(floatingLabelBounds.size)
            floatingLabel.frame = CGRect(x: floatingLabel.frame.origin.x, y: floatingLabel.frame.origin.y, width: frame.size.width, height: floatingLabelSize.height)
        }

        let textIsEmpty = (self.text?.isEmpty ?? true)

        if let placeholderLabelBounds = placeholderLabel.superview?.bounds {
            let placeholderLabelSize = placeholderLabel.sizeThatFits(placeholderLabelBounds.size)

            let textRect: CGRect = self.textRect()

            placeholderLabel.alpha = !textIsEmpty ? 0.0 : 1.0
            placeholderLabel.frame = CGRect(x: textRect.origin.x, y: textRect.origin.y, width: placeholderLabelSize.width, height: placeholderLabelSize.height)
        }

        setLabelOriginForTextAlignment()

        let firstResponder = isFirstResponder

        floatingLabel.textColor = (firstResponder && text != nil && !textIsEmpty ? labelActiveColor() : floatingLabelTextColor)
        if (text == nil || textIsEmpty) && !alwaysShowFloatingLabel {
            hideFloatingLabel(firstResponder)
        } else {
            showFloatingLabel(firstResponder)
        }
    }

    func labelActiveColor() -> UIColor {
        if let floatingLabelActiveTextColor = floatingLabelActiveTextColor {
            return floatingLabelActiveTextColor
        } else if self.responds(to: #selector(getter: self.tintColor)) {
            return self.tintColor
        }
        return UIColor.blue
    }

    func showFloatingLabel(_ animated: Bool) {
        let showBlock: (() -> Void) = {() -> Void in
            self.floatingLabel.alpha = 1.0
            var top = self.floatingLabelYPadding
            if true == self.floatingLabelShouldLockToTop {
                top += self.contentOffset.y
            }
            self.floatingLabel.frame = CGRect(x: self.floatingLabel.frame.origin.x, y: top, width: self.floatingLabel.frame.size.width, height: self.floatingLabel.frame.size.height)
        }
        if (animated || animateEvenIfNotFirstResponder) && (!floatingLabelShouldLockToTop || floatingLabel.alpha != 1.0) {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration, delay: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: showBlock, completion: { _ in })
        } else {
            showBlock()
        }
    }

    func hideFloatingLabel(_ animated: Bool) {
        let hideBlock: (() -> Void) = {() -> Void in
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame = CGRect(x: self.floatingLabel.frame.origin.x, y: self.floatingLabel.font.lineHeight + self.placeholderYPadding, width: self.floatingLabel.frame.size.width, height: self.floatingLabel.frame.size.height)
        }
        if animated || animateEvenIfNotFirstResponder {
            UIView.animate(withDuration: floatingLabelHideAnimationDuration, delay: 0.0, options: [.beginFromCurrentState, .curveEaseIn], animations: hideBlock, completion: { _ in })
        } else {
            hideBlock()
        }
    }

    func adjustTextContainerInsetTop() {
        self.textContainerInset = UIEdgeInsets(top: startingTextContainerInsetTop + floatingLabel.font.lineHeight + placeholderYPadding, left: textContainerInset.left, bottom: textContainerInset.bottom, right: textContainerInset.right)
    }

    func setLabelOriginForTextAlignment() {
        var floatingLabelOriginX = textRect().origin.x
        var placeholderLabelOriginX = floatingLabelOriginX

        if textAlignment == .center {
            floatingLabelOriginX = (frame.size.width / 2) - (floatingLabel.frame.size.width / 2)
            placeholderLabelOriginX = (frame.size.width / 2) - (placeholderLabel.frame.size.width / 2)
        } else if textAlignment == .right {
            floatingLabelOriginX = frame.size.width - floatingLabel.frame.size.width
            placeholderLabelOriginX = (frame.size.width - placeholderLabel.frame.size.width - textContainerInset.right)
        }

        floatingLabel.frame = CGRect(x: floatingLabelOriginX + floatingLabelXPadding, y: floatingLabel.frame.origin.y, width: floatingLabel.frame.size.width, height: floatingLabel.frame.size.height)
        placeholderLabel.frame = CGRect(x: placeholderLabelOriginX, y: placeholderLabel.frame.origin.y, width: placeholderLabel.frame.size.width, height: placeholderLabel.frame.size.height)
    }

    func setLabelErrorOriginForTextAlignment() {
        floatingLabelError.frame = CGRect(x: 0, y: bottomBorder.frame.origin.y + 2.0, width: 300, height: 20.0)
    }

    func setBorder() {
        if hasBottomBorder {
            bottomBorder.borderColor = validTextFieldColor.cgColor
            bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - paddingForBottomLine, width: self.frame.size.width, height: 1)
            bottomBorder.borderWidth = 1
            self.layer.masksToBounds = true
        }
    }

    func textRect() -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, contentInset)
        rect.origin.x += textContainer.lineFragmentPadding
        rect.origin.y += textContainerInset.top
        return rect.integral
    }

    // MARK: - UITextView

    override open var textAlignment: NSTextAlignment {
        didSet {
            setNeedsLayout()
        }
    }

    override open var font: UIFont? {
        didSet {
            self.placeholderLabel.font = self.font
            layoutSubviews()
        }
    }

    override open var text: String! {
        didSet {
            layoutSubviews()
        }
    }

    override open var backgroundColor: UIColor? {
        didSet {
            if self.floatingLabelShouldLockToTop {
                self.floatingLabel.backgroundColor = self.backgroundColor
            }
        }
    }

    // MARK: - Public

    /**
     *  Sets the placeholder and the floating title
     *
     *  @param placeholder The string that to be shown in the text view when no other text is present.
     *  @param floatingTitle The string to be shown above the text view once it has been populated with text by the user.
     */
    func setPlaceholder(_ placeholder: String, floatingTitle: String) {
        self.placeholder = placeholder
        placeholderLabel.text = placeholder
        floatingLabel.text = floatingTitle
        setNeedsLayout()
    }

    public func updateState(_ validationState: TextViewState, withMessage message: String) {
        var lineColor: UIColor?
        currentValidationState = validationState

        switch validationState {
        case .valid:
            lineColor = validTextFieldColor
            floatingLabelError.text = message
        case .invalid:
            lineColor = invalidTextFieldColor
            if message != "" {
                floatingLabelError.text = message
            }
        default: break
        }

        if hasBottomBorder {
            bottomBorder.borderColor = lineColor?.cgColor
            layer.masksToBounds = false
        }
    }

    public func hideBottomBar() {
        self.bottomBorder.isHidden = true
    }
}
