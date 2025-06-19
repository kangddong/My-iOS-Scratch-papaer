//
//  ViewController.swift
//  ExmacOSComponent
//
//  Created by 강동영 on 5/22/25.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "window is nil ? \(self.view.window == nil)")
        
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        print(#function, "window is nil ? \(self.view.window == nil)")
        
        // Do any additional setup after loading the view.
        let toolbar = NSToolbar(identifier: "toolbar")
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly
        toolbar.allowsUserCustomization = false
        self.view.window?.toolbar = toolbar
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        /// Create a new NSToolbarItem, and then go through the process of setting up its attributes.
        return toolbarItem
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        /** Note that the system adds the .toggleSideBar toolbar item to the toolbar to the far left.
            This toolbar item hides and shows (toggle) the primary or side bar split-view item.
            
            For this toolbar item to work, you need to set the split-view item's NSSplitViewItem.Behavior to sideBar,
            which is already in the storyboard. Also note that the system automatically places .addItem and .removeItem to the far right.
        */
        var toolbarItemIdentifiers = [NSToolbarItem.Identifier]()
        if #available(macOS 11.0, *) {
            toolbarItemIdentifiers.append(.toggleSidebar)
        }
        return toolbarItemIdentifiers
    }
    
    /** NSToolbar delegates require this function. It returns an array holding identifiers for all allowed
        toolbar items in this toolbar. Any not listed here aren't available in the customization palette.
     */
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }
}
