//
//  TransformNodeOutput.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 1/30/19.
//

import Foundation
import CoreGraphics
import QuartzCore

class GroupOutputNode: NodeOutput {

  init(parent: NodeOutput?, rootNode: NodeOutput?) {
    self.parent = parent
    self.rootNode = rootNode
  }

  let parent: NodeOutput?
  let rootNode: NodeOutput?

  private(set) var outputPath: CGPath?
  private(set) var transform: CATransform3D = CATransform3DIdentity

  func setTransform(_ xform: CATransform3D, forFrame: CGFloat) {
    transform = xform
    outputPath = nil
  }

  func hasOutputUpdates(_ forFrame: CGFloat) -> Bool {
    let upstreamUpdates = parent?.hasOutputUpdates(forFrame) ?? false
    if upstreamUpdates {
      outputPath = nil
    }
    let rootUpdates = rootNode?.hasOutputUpdates(forFrame) ?? false
    if rootUpdates {
      outputPath = nil
    }

    var localUpdates: Bool = false
    if outputPath == nil {
      localUpdates = true

      let newPath = CGMutablePath()
      if let parentNode = parent, let parentPath = parentNode.outputPath {
        /// First add parent path.
        newPath.addPath(parentPath)
      }
      var xform = CATransform3DGetAffineTransform(transform)
      if let rootNode = rootNode,
        let rootPath = rootNode.outputPath,
        let xformedPath = rootPath.copy(using: &xform) {
        /// Now add root path. Note root path is transformed.
        newPath.addPath(xformedPath)
      }

      outputPath = newPath
    }

    return upstreamUpdates || localUpdates
  }

}
