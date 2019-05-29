//
//  InstrumentManager.swift
//  SwiftVISA
//
//  Created by Connor Barnes on 5/16/19.
//  Copyright © 2019 SwiftVISA. All rights reserved.
//

import CVISA

/// A class the encapsulates a VISA resource manager.
///
/// Instances of this class cannot be initialized directly. To access the default resource manager, use `ResourceManager.default`.
class InstrumentManager {
	/// The session associated with the resource manager.
	var session: ViSession
	
	/// Creates a `ResourceManager` from a `ViSession`.
	///
	/// - Parameter session: The VISA Session object.
	private init(session: ViSession) {
		self.session = session
	}
	
	/// After a resource manager has been successfully initialized, it is stored here for future use.
	private static var _default: InstrumentManager?
	
	/// The shared resource manager. If the resource manager could not be created, this returns `nil`.
	static var `default`: InstrumentManager? {
		if let saved = _default {
			// If a resource manager object has already been created, use that one rather than creating a new resource manager
			return saved
		}

		// A resource manager has not been created yet, try to create one
		var session = ViSession()
		let status = viOpenDefaultRM(&session)
		guard status >= VI_SUCCESS else {
			return nil
		}

		// Successfully created, store this object for future use
		let resourceManager = InstrumentManager(session: session)
		_default = resourceManager
		return resourceManager
	}
}

// MARK: Make Instrument
extension InstrumentManager {
	public func makeInstrument(uii: String) throws -> Instrument {
		// TODO: Make me
		#warning("Not implemented")
		fatalError("Not implemented")
	}
}

// MARK: Close
extension InstrumentManager {
	/// Closes the resource manager. Call this when you are finished with the resource manager. Once this has been called, the resource manager cannot be reopened.
	func close() {
		viClose(session)
	}
}
